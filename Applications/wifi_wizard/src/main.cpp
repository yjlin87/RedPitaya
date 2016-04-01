#include "main.h"

#include <string>
#include <sstream>
#include <cstdlib>
#include <fstream>
#include <vector>

#include <limits.h>
#include <math.h>
#include <stdio.h>
#include "version.h"
#include <sys/types.h>
#include <sys/sysinfo.h>

/* --------------------------------  OUT PARAMETERS  ------------------------------ */
CStringParameter listOfWIFI("WIFI_LIST", CBaseParameter::RWSA, "", 10000);
CStringParameter essidIn("WIFI_SSID", CBaseParameter::RW, "", 10000);
CStringParameter passwIn("WIFI_PASSW", CBaseParameter::RW, "", 10000);
CStringParameter errorOut("WIFI_ERROR", CBaseParameter::RW, "", 10000);
CStringParameter okOut("WIFI_OK", CBaseParameter::RW, "", 10000);
CBooleanParameter installWT("WIFI_INSTALL", CBaseParameter::RW, false, 0);

static const float DEF_MIN_SCALE = 1.f/1000.f;
static const float DEF_MAX_SCALE = 5.f;

const char *rp_app_desc(void) {
    return (const char *)"Red Pitaya Wi-Fi wizard application.\n";
}

int rp_app_init(void) {
    fprintf(stderr, "Loading Wi-Fi wizard version %s-%s.\n", VERSION_STR, REVISION_STR);
    CDataManager::GetInstance()->SetParamInterval(1000);

    rpApp_Init();
    rpApp_OscRun();

    if(!CheckIwlist())
    	errorOut.Value() = "wt not installed";
    else
    	okOut.Value() = "wt installed";

    return 0;
}

int rp_app_exit(void) {
    fprintf(stderr, "Unloading Wi-Fi wizard version %s-%s.\n", VERSION_STR, REVISION_STR);
    rpApp_Release();
    return 0;
}

int rp_set_params(rp_app_params_t *p, int len) {
    return 0;
}

int rp_get_params(rp_app_params_t **p) {
    return 0;
}

int rp_get_signals(float ***s, int *sig_num, int *sig_len) {
    return 0;
}

double roundUpTo1(double data) {
    double power = ceil(log(data) / log(10)) - 1;       // calculate normalization factor
    double dataNorm = data / pow(10, power);            // normalize data, so that 1 < data < 10
    dataNorm = 10;
    return (dataNorm * pow(10, power));         // unnormalize data
}

void UpdateSignals(void) {

}

void UpdateParams(void) {
	listOfWIFI.Value() = GetListOfWIFI("wlan0");
}

bool check_params(const rp_calib_params_t& current_params, int step) {
	return false;
}

// Stringify list to JSON
std::string ToString(std::vector<WIFINode> array) {
	std::stringstream JSONstr;

	JSONstr << "{";

	for(size_t i=0; i<array.size(); i++)
	{
		JSONstr << "\"wifi" << i << "\"" << ": {";
		JSONstr << "\"essid\": " << "\"" << array[i].essid << "\",";
		JSONstr << "\"keyEn\": " << "\"" << array[i].keyEn << "\",";
		JSONstr << "\"quality\": " << "\"" << array[i].quality << "\",";
		JSONstr << "\"sigLevel\": " << "\"" << array[i].sigLevel << "\"";
		JSONstr << "}";

		if(i < (array.size()-1))
		JSONstr << ",";
	}

	JSONstr << "}";

	return JSONstr.str();
}

bool CheckIwlist() {
	std::string lineFromResult;
	std::string tmpFileName = "iwlist.result";
	std::string command = "iwlist -v > " + tmpFileName;

	system(command.c_str());

	std::ifstream tmpFile(tmpFileName);
	std::getline(tmpFile, lineFromResult);

	size_t found = lineFromResult.find("iwlist    Wireless-Tools version");
		if (found != std::string::npos)
			return true;

	return false;
}

void InstallIwlist() {
	system("apt-get install -y wireless-tools");
	okOut.Value() = "wt installed";
}

std::string GetListOfWIFI(std::string wlanInterfaceName) {
	std::stringstream command;
	std::string tmpFileName = "scanning.result";
	std::string lineFromResult;
	int lineNumber = 0;

	command << "iwlist " << wlanInterfaceName << " scan | grep '\\(ESSID\\|Encryption\\|Quality\\)' > " << tmpFileName;
	// command << "cat /opt/redpitaya/www/apps/wifi_wizard/scan_wlan0_res | grep '\\(ESSID\\|Encryption\\|Quality\\)' > " << tmpFileName;

	system(command.str().c_str());

	// Get number of lines in result file
	std::ifstream tmpFile(tmpFileName);
	while(std::getline(tmpFile, lineFromResult))
		lineNumber++;
	tmpFile.close();

	std::ifstream infile(tmpFileName);

	std::vector<WIFINode> listWiFi;

	for(int i=0; i<(lineNumber/3); i++)
	{
		WIFINode wifi;

		std::getline(infile, lineFromResult);
		wifi.essid = ParseLineOfESSID(lineFromResult);

		std::getline(infile, lineFromResult);
		wifi.keyEn = ParseLineEncPass(lineFromResult);

		std::getline(infile, lineFromResult);
		wifi.quality = ParseLineQuality(lineFromResult);
		wifi.sigLevel = ParseLineSiglevel(lineFromResult);

		listWiFi.push_back(wifi);
	}
	infile.close();

	return ToString(listWiFi);
}

void CreateWPA_SUPPL(std::string ssid, std::string pass) {
	if(ssid == "")
		return;

	std::stringstream result;

	result << "ctrl_interface=/var/run/wpa_supplicant" << '\n' << "network={" << '\n';
	result << "\t\tssid=\"" << ssid << "\"" << '\n';

	if(pass != "")
	{
		result << "\t\tkey_mgmt=WPA-PSK\n";
		result << "\t\tpsk=\"" << pass << "\"" << '\n';
	}
	else
	{
		result << "\t\tkey_mgmt=NONE\n";
		result << "\t\tpsk=\"12345678\"" << '\n';
	}
	result << "}";

	std::string command = "echo '" + result.str() + "' > /opt/redpitaya/www/apps/wifi_wizard/wpa_supplicant.conf";
	system(command.c_str());
}

std::string ParseLineOfESSID(std::string str) {
	size_t start = 0;
	size_t stop = 0;

	for(size_t i=0; i<str.size(); i++)
	{
		if(str[i] == '\"' && start == 0)
			start = i;
		if(str[i] == '\"' && start != 0)
			stop = i;
	}

	return str.substr(start+1, stop-start-1);
}

bool ParseLineEncPass(std::string str) {
	if(str.substr(str.size()-2, 2) == "on")
		return true;
	return false;
}

int ParseLineQuality(std::string str) {
	size_t start = 0;
	size_t stop = 0;

	for(size_t i=0; i<str.size(); i++)
	{
		if(str[i] == '=' && start == 0)
			start = i;
		if(str[i] == '/' && start != 0)
			stop = i;
	}

	std::string result = str.substr(start+1, stop-start-1);
	return atoi(result.c_str());
}

int ParseLineSiglevel(std::string str) {
	size_t start = 0;
	size_t stop = 0;
	bool first = false;

	for(size_t i=0; i<str.size(); i++)
	{
		if(!first)
		{
			if(str[i] == '=')
				start = i;
			if(str[i] == '/' && start != 0)
			{
				start = 0;
				first = true;
			}
		}
		else
		{
			if(str[i] == '=')
				start = i;
			if(str[i] == '/' && start != 0)
				stop = i;
		}
	}

	std::string result = str.substr(start+1, stop-start-1);
	return atoi(result.c_str());
}

void OnNewParams(void) {
	if(essidIn.IsNewValue())
	{
		essidIn.Update();
		passwIn.Update();
		CreateWPA_SUPPL(essidIn.Value(), passwIn.Value());
	}
	if(installWT.IsNewValue())
	{
		installWT.Update();
		if(installWT.Value())
			InstallIwlist();
		installWT.Value() = false;
	}
}
