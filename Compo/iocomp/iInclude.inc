{*******************************************************}
{                                                       }
{       Iocomp Include File                             }
{                                                       }
{       Copyright (c) 1997,2007 Iocomp Software         }
{                                                       }
{*******************************************************}

{$O+} // Optimization
{$F-} // Force Far Calls
{$A+} // Word Align Data
{$U-} // Pentium Safe FDIV                                     
{$K-} // Smart Callbacks
{$W-} // Windows Stack Frame
{$R-} // Range Checking
{$S+} // Stack Checking
{$I+} // I/O Checking
{$Q-} // Overflow Checking
{$V-} // Strict Var-Strings
{$B-} // Complete Boolean Evaluation
{$X+} // Extended Syntax
{$T-} // Type @ Operator
{$P+} // Open Parameters
{$H+} // Huge Strings
{$Z-} // Word Size Enumerated Types

//Toggle these two values to switch between CLX and VCL specific code
//Note: in CLX mode, all source file names must be preceeded by a "Q"
//except for this file.
{.$DEFINE iCLX}
{$DEFINE iVCL}

//Toggle this value to switch between Full Product and Evaluation
//{$DEFINE EVAL}

//******************************************************************************
//==============================
//Borland Compiler Version Table
//==============================
//Delphi 1 = VER80
//Delphi 2 = VER90
//Delphi 3 = VER100
//Delphi 4 = VER120
//Delphi 5 = VER130
//Delphi 6 = VER140
//Kylix  1 = VER140
//Kylix  2 = VER140
//CBuilder 1 = VER93
//CBuilder 2 = {C++ Builder 2 never existed!}
//CBuilder 3 = VER110
//CBuilder 4 = VER125
//CBuilder 5 = VER135
//CBuilder 6 = VER140

//******************************************************************************
//=================================
//AutoDetect Delphi/Kylix Compilers
//=================================
{$IFDEF VER80}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_1}
  {$DEFINE ISDELPHI}
  {$DEFINE DELPHI_1}
  {$DEFINE MSWINDOWS}
{$ENDIF}
{$IFDEF VER90}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_2}
  {$DEFINE ISDELPHI}
  {$DEFINE DELPHI_2}
  {$DEFINE MSWINDOWS}
{$ENDIF}
{$IFDEF VER100}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_3}
  {$DEFINE ISDELPHI}
  {$DEFINE DELPHI_3}
  {$DEFINE MSWINDOWS}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_4}
  {$DEFINE ISDELPHI}
  {$DEFINE DELPHI_4}
  {$DEFINE MSWINDOWS}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_5}
  {$DEFINE ISDELPHI}
  {$DEFINE DELPHI_5}
  {$DEFINE MSWINDOWS}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE COMPILERFOUND}
  {$IFDEF MSWINDOWS}
    {$IFNDEF BCB}
      {$DEFINE COMPILER_6}
      {$DEFINE ISDELPHI}
      {$DEFINE DELPHI_6}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF LINUX}
    {$DEFINE COMPILER_6}
    {$DEFINE ISKYLIX}
    //{$IF RTLVersion < 14.20}
    //  {$DEFINE KYLIX_1}
    //{$ELSE}
    //  {$DEFINE KYLIX_2}
    //{$ENDIF}
  {$ENDIF}
{$ENDIF}
//******************************************************************************
//============================
//Detect C++ Builder Compilers
//============================
{$IFDEF VER93}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_2}
  {$DEFINE ISCPPB}
  {$DEFINE CPPB_2}
  {$DEFINE MSWINDOWS}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_3}
  {$DEFINE ISCPPB}
  {$DEFINE CPPB_3}
  {$DEFINE MSWINDOWS}
  {$ObjExportAll On}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_4}
  {$DEFINE ISCPPB}
  {$DEFINE CPPB_4}
  {$DEFINE MSWINDOWS}
  {$ObjExportAll On}
{$ENDIF}
{$IFDEF VER135}
  {$DEFINE COMPILERFOUND}
  {$DEFINE COMPILER_5}
  {$DEFINE ISCPPB}
  {$DEFINE CPPB_5}
  {$DEFINE MSWINDOWS}
  {$ObjExportAll On}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE COMPILERFOUND}
  {$IFDEF BCB}
    {$DEFINE COMPILER_6}
    {$DEFINE ISCPPB}
    {$DEFINE CPPB_6}
    {$ObjExportAll On}
  {$ENDIF}
{$ENDIF}
//******************************************************************************
//======================
//Detect Newer Compilers
//======================
{$IFNDEF COMPILERFOUND}
  //Assume we are using a newer compiler
  {$IFDEF MSWINDOWS}
    {$IFDEF BCB}
      {$DEFINE COMPILER_6}
      {$DEFINE ISCPPB}
      {$ObjExportAll On}
    {$ELSE}
      {$DEFINE COMPILER_6}
      {$DEFINE ISDELPHI}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF LINUX}
    {$DEFINE COMPILER_6}
  {$ENDIF}  
{$ENDIF}
//******************************************************************************
//==========================================
//DEFINE COMPILERS AND COMPATIBILITY DEFINES
//==========================================
{$IFDEF COMPILER_6}
  {$DEFINE COMPILER_1_UP}
  {$DEFINE COMPILER_2_UP}
  {$DEFINE COMPILER_3_UP}
  {$DEFINE COMPILER_4_UP}
  {$DEFINE COMPILER_5_UP}
  {$DEFINE COMPILER_6_UP}
{$ENDIF}
{$IFDEF COMPILER_5}
  {$DEFINE DSGNINTF_COMPAT}
  {$DEFINE COMPILER_1_UP}
  {$DEFINE COMPILER_2_UP}
  {$DEFINE COMPILER_3_UP}
  {$DEFINE COMPILER_4_UP}
  {$DEFINE COMPILER_5_UP}
{$ENDIF}
{$IFDEF COMPILER_4}
  {$DEFINE DSGNINTF_COMPAT}
  {$DEFINE COMPILER_1_UP}
  {$DEFINE COMPILER_2_UP}
  {$DEFINE COMPILER_3_UP}
  {$DEFINE COMPILER_4_UP}
{$ENDIF}
{$IFDEF COMPILER_3}
  {$DEFINE DSGNINTF_COMPAT}
  {$DEFINE COMPILER_1_UP}
  {$DEFINE COMPILER_2_UP}
  {$DEFINE COMPILER_3_UP}
{$ENDIF}
{$IFDEF COMPILER_2}
  {$DEFINE DSGNINTF_COMPAT}
  {$DEFINE COMPILER_1_UP}
  {$DEFINE COMPILER_2_UP}
{$ENDIF}
{$IFDEF COMPILER_41}
  {$DEFINE DSGNINTF_COMPAT}
  {$DEFINE COMPILER_1_UP}
{$ENDIF}

//******************************************************************************

