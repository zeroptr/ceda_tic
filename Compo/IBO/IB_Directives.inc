
{$R-}  // Turn off range checking.
{$A+}  // Need aligned record fields.
{$B-}  // Make sure there isn't complete boolean evaluation.
{$H+}  // Make sure huge strings are supported.

{------------------------------------------------------------------------------}
// Setup defines according to IBO version.
//
//  * This define is to be used by CPS only. It is temporary to ease the
//    maintaining of two separate development trees. Thus, some IBO4 code is
//    going to appear to show up in the 3.6 version but this is only to aid in
//    keeping the changes between the two versions in sync easier.

{$DEFINE IBO4_BETA}

{------------------------------------------------------------------------------}
// Setup usage of default/alternate session behavior.
//
//  When controlling your own sessions manually, such as when doing an ISAPI
//  module, it is not necessary to maintain a default session. This is a
//  benefit because it avoids using a multi-threading resource when this 
//  define is disabled. It is the same for the alternate session too.

// Make sure when building design-time packages the default session is on.

{$DEFINE ALLOW_DEFAULT_SESSION}
{ $ DEFINE ALLOW_ALT_SESSION}

{------------------------------------------------------------------------------}
// Setup defines according to compiler versions.
//
// Notes:
//
//   * Using an IBO_ prefix on the defines to avoid conflict with
//     non IBO packages.
//
//   * In an effort to minimise changes required to support new
//     compiler releases I use a reverse logic in assigning
//     some of the defines - that is, define all relevant values
//     and then undefine items not supported in specific versions.
//     - in support of this Delphi is the assumed compiler unless
//     overridden by specific C++Builder version. (Majority rule.)
//
//     IMPORTANT: If adding a new VCLxx_OR_GREATER define remember
//     to undefine the value in all the older versions!
//
//     Note: Actually this does not achieve much at the moment due
//     to a necessary hack in IBG_Custom.IMP.  Hopefully a means
//     will eventually be found to avoid that issue.
//     Use IBO_SUPPORTED_COMPILER if you need to test whether the
//     current compiler has been defined and tested to support IBObjects.
//

{$DEFINE IBO_40_OR_GREATER}    // Detection of move to IBO40
{$DEFINE IBO_DELPHI}  // Delphi - any version
{$DEFINE IBO_VCL20_OR_GREATER} // VCL v2.0 or greater (Delphi v2+)
{$DEFINE IBO_VCL30_OR_GREATER} // VCL v3.0 or greater (Delphi v3+)
{$DEFINE IBO_VCL35_OR_GREATER} // VCL v3.5 or greater (C++Builder v3+)
{$DEFINE IBO_VCL40_OR_GREATER} // VCL v4.0 or greater (Delphi v4+ or C++B v4+)
{$DEFINE IBO_VCL50_OR_GREATER} // VCL v5.0 or greater (Delphi v5+ or C++B v5+)
{$DEFINE IBO_VCL60_OR_GREATER} // VCL v6.0 or greater (Delphi v6+ or C++B v6+)
{$DEFINE IBO_VCL70_OR_GREATER} // VCL v7.0 or greater (Delphi v7+ or C++B v?+)

{------------------------------------------------------------------------------}
// Compiler specific defines, latest to oldest...

{$IFDEF VER150}    // Delphi v7
{$IFNDEF BCB}
{$DEFINE IBO_DELPHI_7}
{$DEFINE IBO_VCL70}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}
{$ENDIF}

{$IFDEF VER140}    // Delphi v6
{$IFNDEF BCB}
{$DEFINE IBO_DELPHI_6}
{$DEFINE IBO_VCL60}
{$UNDEF IBO_VCL70_OR_GREATER}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ELSE}
    // C++Builder v6
{$UNDEF IBO_DELPHI}
{$DEFINE IBO_CPPB}
{$DEFINE IBO_CPPB_6}
{$DEFINE IBO_VCL60} // same VCL version as Delphi 6
{$UNDEF IBO_VCL70_OR_GREATER}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}
{$ENDIF}

{$IFDEF VER130}    // Delphi v5
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$IFNDEF BCB}
{$DEFINE IBO_DELPHI_5}
{$DEFINE IBO_VCL50}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ELSE}
    // C++Builder v5
{$UNDEF IBO_DELPHI}
{$DEFINE IBO_CPPB}
{$DEFINE IBO_CPPB_5}
{$DEFINE IBO_VCL50} // same VCL version as Delphi 5
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}
{$ENDIF}

{$IFDEF VER125}    // C++Builder v4
{$UNDEF IBO_DELPHI}
{$DEFINE IBO_CPPB}
{$DEFINE IBO_CPPB_4}
{$UNDEF IBO_VCL50_OR_GREATER}
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$DEFINE IBO_VCL40} // same VCL version as Delphi 4
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}

{$IFDEF VER120}    // Delphi v4
{$DEFINE IBO_DELPHI_4}
{$UNDEF IBO_VCL50_OR_GREATER}
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$DEFINE IBO_VCL40}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}

{$IFDEF VER110}    // C++Builder v3
{$UNDEF IBO_DELPHI}
{$DEFINE IBO_CPPB}
{$DEFINE IBO_CPPB_3}
{$UNDEF IBO_VCL40_OR_GREATER}
{$UNDEF IBO_VCL50_OR_GREATER}
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$DEFINE IBO_VCL35}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}

{$IFDEF VER100}    // Delphi v3
{$DEFINE IBO_DELPHI_3}
{$UNDEF IBO_VCL35_OR_GREATER}
{$UNDEF IBO_VCL40_OR_GREATER}
{$UNDEF IBO_VCL50_OR_GREATER}
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$DEFINE IBO_VCL30}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}

{$IFDEF VER90}     // Delphi v2
{$DEFINE IBO_DELPHI_2}
{$UNDEF IBO_VCL30_OR_GREATER}
{$UNDEF IBO_VCL35_OR_GREATER}
{$UNDEF IBO_VCL40_OR_GREATER}
{$UNDEF IBO_VCL50_OR_GREATER}
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$DEFINE IBO_VCL20}
{$DEFINE IBO_SUPPORTED_COMPILER}
{$ENDIF}

{$IFDEF VER93}     // C++Builder v1.0
// Intentional compile time error
ERROR: C++Builder v1.0 not supported
{$UNDEF IBO_DELPHI}
{$UNDEF IBO_VCL20_OR_GREATER}
{$UNDEF IBO_VCL30_OR_GREATER}
{$UNDEF IBO_VCL35_OR_GREATER}
{$UNDEF IBO_VCL40_OR_GREATER}
{$UNDEF IBO_VCL50_OR_GREATER}
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$ENDIF}

{$IFDEF VER80}     // Delphi v1.0 (Win16 version)
// Intentional compile time error
ERROR: Delphi v1.0 not supported
{$UNDEF IBO_DELPHI}
{$UNDEF IBO_VCL20_OR_GREATER}
{$UNDEF IBO_VCL30_OR_GREATER}
{$UNDEF IBO_VCL35_OR_GREATER}
{$UNDEF IBO_VCL40_OR_GREATER}
{$UNDEF IBO_VCL50_OR_GREATER}
{$UNDEF IBO_VCL60_OR_GREATER}
{$UNDEF IBO_VCL70_OR_GREATER}
{$ENDIF}

{------------------------------------------------------------------------------}
// Derived defines based on compiler/VCL versions...

{$IFDEF IBO_CPPB_3}  // only required for C++Builder v3
{$ObjExportAll On }
{$ENDIF           }

// BCB and Delphi prior to v4 do not support enumerated index specifiers
// in property definitions.  Setup a define to make implementation simpler.
{$IFDEF IBO_VCL40_OR_GREATER}
{$IFNDEF IBO_CPPB}
{$DEFINE IBO_ENUMINDEX_SUPPORT}
{$ENDIF}
{$ENDIF}

{$IFDEF IBO_VCL60_OR_GREATER}
{$WARN UNIT_PLATFORM OFF}
{$ENDIF}

