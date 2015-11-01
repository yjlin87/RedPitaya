//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.2 (lin64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
//Date        : Sun Nov  1 08:48:37 2015
//Host        : Dent running 64-bit Ubuntu 15.04
//Command     : generate_target system_wrapper.bd
//Design      : system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper (
  inout  logic [14:0] DDR_addr   ,
  inout  logic  [2:0] DDR_ba     ,
  inout  logic        DDR_cas_n  ,
  inout  logic        DDR_ck_n   ,
  inout  logic        DDR_ck_p   ,
  inout  logic        DDR_cke    ,
  inout  logic        DDR_cs_n   ,
  inout  logic  [3:0] DDR_dm     ,
  inout  logic [31:0] DDR_dq     ,
  inout  logic  [3:0] DDR_dqs_n  ,
  inout  logic  [3:0] DDR_dqs_p  ,
  inout  logic        DDR_odt    ,
  inout  logic        DDR_ras_n  ,
  inout  logic        DDR_reset_n,
  inout  logic        DDR_we_n   ,

  output logic        FCLK_CLK0,
  output logic        FCLK_CLK1,
  output logic        FCLK_CLK2,
  output logic        FCLK_CLK3,
  output logic        FCLK_RESET0_N,
  output logic        FCLK_RESET1_N,
  output logic        FCLK_RESET2_N,
  output logic        FCLK_RESET3_N,

  inout  logic        FIXED_IO_ddr_vrn ,
  inout  logic        FIXED_IO_ddr_vrp ,
  inout  logic [53:0] FIXED_IO_mio     ,
  inout  logic        FIXED_IO_ps_clk  ,
  inout  logic        FIXED_IO_ps_porb ,
  inout  logic        FIXED_IO_ps_srstb,

  input  logic        M_AXI_GP0_ACLK   ,
  output logic [31:0] M_AXI_GP0_araddr ,
  output logic  [1:0] M_AXI_GP0_arburst,
  output logic  [3:0] M_AXI_GP0_arcache,
  output logic [11:0] M_AXI_GP0_arid   ,
  output logic  [3:0] M_AXI_GP0_arlen  ,
  output logic  [1:0] M_AXI_GP0_arlock ,
  output logic  [2:0] M_AXI_GP0_arprot ,
  output logic  [3:0] M_AXI_GP0_arqos  ,
  input  logic        M_AXI_GP0_arready,
  output logic  [2:0] M_AXI_GP0_arsize ,
  output logic        M_AXI_GP0_arvalid,
  output logic [31:0] M_AXI_GP0_awaddr ,
  output logic  [1:0] M_AXI_GP0_awburst,
  output logic  [3:0] M_AXI_GP0_awcache,
  output logic [11:0] M_AXI_GP0_awid   ,
  output logic  [3:0] M_AXI_GP0_awlen  ,
  output logic  [1:0] M_AXI_GP0_awlock ,
  output logic  [2:0] M_AXI_GP0_awprot ,
  output logic  [3:0] M_AXI_GP0_awqos  ,
  input  logic        M_AXI_GP0_awready,
  output logic  [2:0] M_AXI_GP0_awsize ,
  output logic        M_AXI_GP0_awvalid,
  input  logic [11:0] M_AXI_GP0_bid    ,
  output logic        M_AXI_GP0_bready ,
  input  logic  [1:0] M_AXI_GP0_bresp  ,
  input  logic        M_AXI_GP0_bvalid ,
  input  logic [31:0] M_AXI_GP0_rdata  ,
  input  logic [11:0] M_AXI_GP0_rid    ,
  input  logic        M_AXI_GP0_rlast  ,
  output logic        M_AXI_GP0_rready ,
  input  logic  [1:0] M_AXI_GP0_rresp  ,
  input  logic        M_AXI_GP0_rvalid ,
  output logic [31:0] M_AXI_GP0_wdata  ,
  output logic [11:0] M_AXI_GP0_wid    ,
  output logic        M_AXI_GP0_wlast  ,
  input  logic        M_AXI_GP0_wready ,
  output logic  [3:0] M_AXI_GP0_wstrb  ,
  output logic        M_AXI_GP0_wvalid ,

  input  logic        S_AXI_HP1_aclk   , S_AXI_HP0_aclk   ,
  input  logic [31:0] S_AXI_HP1_araddr , S_AXI_HP0_araddr ,
  input  logic  [1:0] S_AXI_HP1_arburst, S_AXI_HP0_arburst,
  input  logic  [3:0] S_AXI_HP1_arcache, S_AXI_HP0_arcache,
  input  logic  [5:0] S_AXI_HP1_arid   , S_AXI_HP0_arid   ,
  input  logic  [3:0] S_AXI_HP1_arlen  , S_AXI_HP0_arlen  ,
  input  logic  [1:0] S_AXI_HP1_arlock , S_AXI_HP0_arlock ,
  input  logic  [2:0] S_AXI_HP1_arprot , S_AXI_HP0_arprot ,
  input  logic  [3:0] S_AXI_HP1_arqos  , S_AXI_HP0_arqos  ,
  output logic        S_AXI_HP1_arready, S_AXI_HP0_arready,
  input  logic  [2:0] S_AXI_HP1_arsize , S_AXI_HP0_arsize ,
  input  logic        S_AXI_HP1_arvalid, S_AXI_HP0_arvalid,
  input  logic [31:0] S_AXI_HP1_awaddr , S_AXI_HP0_awaddr ,
  input  logic  [1:0] S_AXI_HP1_awburst, S_AXI_HP0_awburst,
  input  logic  [3:0] S_AXI_HP1_awcache, S_AXI_HP0_awcache,
  input  logic  [5:0] S_AXI_HP1_awid   , S_AXI_HP0_awid   ,
  input  logic  [3:0] S_AXI_HP1_awlen  , S_AXI_HP0_awlen  ,
  input  logic  [1:0] S_AXI_HP1_awlock , S_AXI_HP0_awlock ,
  input  logic  [2:0] S_AXI_HP1_awprot , S_AXI_HP0_awprot ,
  input  logic  [3:0] S_AXI_HP1_awqos  , S_AXI_HP0_awqos  ,
  output logic        S_AXI_HP1_awready, S_AXI_HP0_awready,
  input  logic  [2:0] S_AXI_HP1_awsize , S_AXI_HP0_awsize ,
  input  logic        S_AXI_HP1_awvalid, S_AXI_HP0_awvalid,
  output logic  [5:0] S_AXI_HP1_bid    , S_AXI_HP0_bid    ,
  input  logic        S_AXI_HP1_bready , S_AXI_HP0_bready ,
  output logic  [1:0] S_AXI_HP1_bresp  , S_AXI_HP0_bresp  ,
  output logic        S_AXI_HP1_bvalid , S_AXI_HP0_bvalid ,
  output logic [63:0] S_AXI_HP1_rdata  , S_AXI_HP0_rdata  ,
  output logic  [5:0] S_AXI_HP1_rid    , S_AXI_HP0_rid    ,
  output logic        S_AXI_HP1_rlast  , S_AXI_HP0_rlast  ,
  input  logic        S_AXI_HP1_rready , S_AXI_HP0_rready ,
  output logic  [1:0] S_AXI_HP1_rresp  , S_AXI_HP0_rresp  ,
  output logic        S_AXI_HP1_rvalid , S_AXI_HP0_rvalid ,
  input  logic [63:0] S_AXI_HP1_wdata  , S_AXI_HP0_wdata  ,
  input  logic  [5:0] S_AXI_HP1_wid    , S_AXI_HP0_wid    ,
  input  logic        S_AXI_HP1_wlast  , S_AXI_HP0_wlast  ,
  output logic        S_AXI_HP1_wready , S_AXI_HP0_wready ,
  input  logic  [7:0] S_AXI_HP1_wstrb  , S_AXI_HP0_wstrb  ,
  input  logic        S_AXI_HP1_wvalid , S_AXI_HP0_wvalid ,

  input  logic        Vaux0_v_n,
  input  logic        Vaux0_v_p,
  input  logic        Vaux1_v_n,
  input  logic        Vaux1_v_p,
  input  logic        Vaux8_v_n,
  input  logic        Vaux8_v_p,
  input  logic        Vaux9_v_n,
  input  logic        Vaux9_v_p,
  input  logic        Vp_Vn_v_n,
  input  logic        Vp_Vn_v_p
);

////////////////////////////////////////////////////////////////////////////////
// DDR memory
////////////////////////////////////////////////////////////////////////////////

// assign DDR_addr    = 'z;
// assign DDR_ba      = 'z;
// assign DDR_cas_n   = 'z;
// assign DDR_ck_n    = 'z;
// assign DDR_ck_p    = 'z;
// assign DDR_cke     = 'z;
// assign DDR_cs_n    = 'z;
// assign DDR_dm      = 'z;
// assign DDR_dq      = 'z;
// assign DDR_dqs_n   = 'z;
// assign DDR_dqs_p   = 'z;
// assign DDR_odt     = 'z;
// assign DDR_ras_n   = 'z;
// assign DDR_reset_n = 'z;
// assign DDR_we_n    = 'z;

////////////////////////////////////////////////////////////////////////////////
// clock and reset
////////////////////////////////////////////////////////////////////////////////

logic clk;
logic rstn;

initial         clk = 1'b1;
always #(8ns/2) clk = ~clk;

initial begin
  rstn = 1'b0;
  repeat (4) @ (posedge clk);
  rstn = 1'b1;
end

assign FCLK_CLK0 = clk;
assign FCLK_CLK1 = clk;
assign FCLK_CLK2 = clk;
assign FCLK_CLK3 = clk;
assign FCLK_RESET0_N = rstn;
assign FCLK_RESET1_N = rstn;
assign FCLK_RESET2_N = rstn;
assign FCLK_RESET3_N = rstn;

////////////////////////////////////////////////////////////////////////////////
// Fixed IO
////////////////////////////////////////////////////////////////////////////////

// assign FIXED_IO_ddr_vrn  = 'z;
// assign FIXED_IO_ddr_vrp  = 'z;
// assign FIXED_IO_mio      = 'z;
// assign FIXED_IO_ps_clk   = 'z;
// assign FIXED_IO_ps_porb  = 'z;
// assign FIXED_IO_ps_srstb = 'z;

////////////////////////////////////////////////////////////////////////////////
// AMBA AXI-4 GP bus
////////////////////////////////////////////////////////////////////////////////

//     M_AXI_GP0_ACLK   ,
assign M_AXI_GP0_araddr  = '0;
assign M_AXI_GP0_arburst = '0;
assign M_AXI_GP0_arcache = '0;
assign M_AXI_GP0_arid    = '0;
assign M_AXI_GP0_arlen   = '0;
assign M_AXI_GP0_arlock  = '0;
assign M_AXI_GP0_arprot  = '0;
assign M_AXI_GP0_arqos   = '0;
//     M_AXI_GP0_arready,
assign M_AXI_GP0_arsize  = '0;
assign M_AXI_GP0_arvalid = '0;
assign M_AXI_GP0_awaddr  = '0;
assign M_AXI_GP0_awburst = '0;
assign M_AXI_GP0_awcache = '0;
assign M_AXI_GP0_awid    = '0;
assign M_AXI_GP0_awlen   = '0;
assign M_AXI_GP0_awlock  = '0;
assign M_AXI_GP0_awprot  = '0;
assign M_AXI_GP0_awqos   = '0;
//     M_AXI_GP0_awready,
assign M_AXI_GP0_awsize  = '0;
assign M_AXI_GP0_awvalid = '0;
//     M_AXI_GP0_bid    ,
assign M_AXI_GP0_bready  = '0;
//     M_AXI_GP0_bresp  ,
//     M_AXI_GP0_bvalid ,
//     M_AXI_GP0_rdata  ,
//     M_AXI_GP0_rid    ,
//     M_AXI_GP0_rlast  ,
assign M_AXI_GP0_rready  = '0;
//     M_AXI_GP0_rresp  ,
//     M_AXI_GP0_rvalid ,
assign M_AXI_GP0_wdata   = '0;
assign M_AXI_GP0_wid     = '0;
assign M_AXI_GP0_wlast   = '0;
//     M_AXI_GP0_wready ,
assign M_AXI_GP0_wstrb   = '0;
assign M_AXI_GP0_wvalid  = '0;

////////////////////////////////////////////////////////////////////////////////
// AMBA AXI-4 HP bus
////////////////////////////////////////////////////////////////////////////////

//     {S_AXI_HP1_aclk   , S_AXI_HP0_aclk   } = '0;
//     {S_AXI_HP1_araddr , S_AXI_HP0_araddr } = '0;
//     {S_AXI_HP1_arburst, S_AXI_HP0_arburst} = '0;
//     {S_AXI_HP1_arcache, S_AXI_HP0_arcache} = '0;
//     {S_AXI_HP1_arid   , S_AXI_HP0_arid   } = '0;
//     {S_AXI_HP1_arlen  , S_AXI_HP0_arlen  } = '0;
//     {S_AXI_HP1_arlock , S_AXI_HP0_arlock } = '0;
//     {S_AXI_HP1_arprot , S_AXI_HP0_arprot } = '0;
//     {S_AXI_HP1_arqos  , S_AXI_HP0_arqos  } = '0;
assign {S_AXI_HP1_arready, S_AXI_HP0_arready} = '0;
//     {S_AXI_HP1_arsize , S_AXI_HP0_arsize } = '0;
//     {S_AXI_HP1_arvalid, S_AXI_HP0_arvalid} = '0;
//     {S_AXI_HP1_awaddr , S_AXI_HP0_awaddr } = '0;
//     {S_AXI_HP1_awburst, S_AXI_HP0_awburst} = '0;
//     {S_AXI_HP1_awcache, S_AXI_HP0_awcache} = '0;
//     {S_AXI_HP1_awid   , S_AXI_HP0_awid   } = '0;
//     {S_AXI_HP1_awlen  , S_AXI_HP0_awlen  } = '0;
//     {S_AXI_HP1_awlock , S_AXI_HP0_awlock } = '0;
//     {S_AXI_HP1_awprot , S_AXI_HP0_awprot } = '0;
//     {S_AXI_HP1_awqos  , S_AXI_HP0_awqos  } = '0;
assign {S_AXI_HP1_awready, S_AXI_HP0_awready} = '0;
//     {S_AXI_HP1_awsize , S_AXI_HP0_awsize } = '0;
//     {S_AXI_HP1_awvalid, S_AXI_HP0_awvalid} = '0;
assign {S_AXI_HP1_bid    , S_AXI_HP0_bid    } = '0;
//     {S_AXI_HP1_bready , S_AXI_HP0_bready } = '0;
assign {S_AXI_HP1_bresp  , S_AXI_HP0_bresp  } = '0;
assign {S_AXI_HP1_bvalid , S_AXI_HP0_bvalid } = '0;
assign {S_AXI_HP1_rdata  , S_AXI_HP0_rdata  } = '0;
assign {S_AXI_HP1_rid    , S_AXI_HP0_rid    } = '0;
assign {S_AXI_HP1_rlast  , S_AXI_HP0_rlast  } = '0;
//     {S_AXI_HP1_rready , S_AXI_HP0_rready } = '0;
assign {S_AXI_HP1_rresp  , S_AXI_HP0_rresp  } = '0;
assign {S_AXI_HP1_rvalid , S_AXI_HP0_rvalid } = '0;
//     {S_AXI_HP1_wdata  , S_AXI_HP0_wdata  } = '0;
//     {S_AXI_HP1_wid    , S_AXI_HP0_wid    } = '0;
//     {S_AXI_HP1_wlast  , S_AXI_HP0_wlast  } = '0;
assign {S_AXI_HP1_wready , S_AXI_HP0_wready } = '0;
//     {S_AXI_HP1_wstrb  , S_AXI_HP0_wstrb  } = '0;
//     {S_AXI_HP1_wvalid , S_AXI_HP0_wvalid } = '0;

////////////////////////////////////////////////////////////////////////////////
// analog inputs
////////////////////////////////////////////////////////////////////////////////

//  input  logic        Vaux0_v_n,
//  input  logic        Vaux0_v_p,
//  input  logic        Vaux1_v_n,
//  input  logic        Vaux1_v_p,
//  input  logic        Vaux8_v_n,
//  input  logic        Vaux8_v_p,
//  input  logic        Vaux9_v_n,
//  input  logic        Vaux9_v_p,
//  input  logic        Vp_Vn_v_n,
//  input  logic        Vp_Vn_v_p

endmodule
