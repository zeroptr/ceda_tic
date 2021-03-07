
{                                                                              }
{ IB_Components                                                                }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the foundational IB Native Core and Access components.}
unit
  IB_Components;

interface

uses
  SysUtils, Classes, Forms, Windows, Messages, Graphics, Dialogs,

{$ifdef IBO_VCL60_OR_GREATER}
  Variants, MaskUtils,
{$else}
  Mask,
{$endif}
  IB_MaskInterface,

  IB_Constants,
  IB_Header,
  IB_Session,
  IB_NodeList;
//IB_Monitor
//IB_SessionProps
//IB_ConnectionSource
//IB_TransactionSource
//IB_StatementSource
//IB_FieldDataLink
//IB_Process
//IB_DataScan
//IB_DataPump
//IB_SyncCursor
//IB_Controls
//IB_LocateEdit
//IB_ParamEdit
//IB_SearchEdit
//IB_SearchPanel
//IB_IncSearch
//IB_StatementGrid
//IB_CursorGrid
//IB_Grid
//IB_CGrid
//IB_DatasetBar
//IB_UpdateBar
//IB_SearchBar
//IB_NavigationBar
//IB_TransactionBar
//IB_StatementBar
//IB_Events
//IB_Export
//IB_Schema
//IB_Script
//IB_StoredProc
//IB_Dialogs
//IB_Ledger
//IB_Editors
//IBODatasetEditors
//IBODataset
//IBWeb
//IPIBDataset
//IB_Registration
//Db
//DbTables

{$IFNDEF IBO_ENUMINDEX_SUPPORT}
const
  ssSQL = 0;
  ssSelect = 1;
  ssFrom = 2;
  ssWhere = 3;
  ssGroup = 4;
  ssHaving = 5;
  ssUnion = 6;
  ssPlan = 7;
  ssOrder = 8;
  ssForUpdate = 9;
// For loop controls
  ssLowSQLSection = 0;
  ssHighSQLSection = 9;
{$ENDIF}

type
  TIB_Session = class;
  TIB_Component = class;
  TIB_SchemaCache = class;
  TIB_Connection = class;
  TIB_ConnectionLink = class;
  TIB_Transaction = class;
  TIB_TransactionInternal = class;
  TIB_TransactionLink = class;
  TIB_Statement = class;
  TIB_StatementLink = class;
  TIB_Dataset = class;
  TIB_BDataset = class;
  TIB_FilterCursor = class;
  TIB_UpdateSQL = class;
  TIB_DataSource = class;
  TIB_DataLink = class;
  TIB_KeyDataLink = class;
  TIB_MasterDataLink = class;
  TIB_Row = class;
  TIB_Column = class;
  TIB_ColumnBlob = class;
  TIB_ColumnArray = class;
  TIB_ColumnRef = ^TIB_Column;
// C++Builder does not issue the pre-declarations of types (as issued above)
// until it decides the declaration is required.  However TIB_Transaction
// uses TIB_BDataset in its ApplyUpdates procedure as an array parameter
// which, it appears, C++Builder does not recognise properly for the purposes
// of issuing predeclarations.  So by creating this dummy type declaration I
// force C++Builder to see that the pre-declaration is required.  I could have
// just used HPPEMIT directives, but I think this dummy operation should
// provide better long-term compatibility with future releases, and will be
// totally harmless if the problem is ever fixed.
{$IFDEF IBO_CPPB}
  TIB_BDatasetRef = ^TIB_BDataset;
{$ENDIF}

{$I IBA_StringList.INT       }
{$I IBA_Stream.INT           }
{$I IBA_Session.INT          }
{$I IBA_Component.INT        }
{$I IBA_SchemaCache.INT      }
{$I IBA_DMLCache.INT         }
{$I IBA_Connection.INT       }
{$I IBA_ConnectionLink.INT   }
{$I IBA_Transaction.INT      }
{$I IBA_TransactionLink.INT  }
{$I IBA_Database.INT         }
{$I IBA_Statement.INT        }
{$I IBA_StatementLink.INT    }
{$I IBA_Dataset.INT          }
{$I IBA_BindingCursor.INT    }
{$I IBA_LocateCursor.INT     }
{$I IBA_BDataset.INT         }
{$I IBA_FilterCursor.INT     }
{$I IBA_UpdateSQL.INT        }
{$I IBA_DataSource.INT       }
{$I IBA_DataLink.INT         }
{$I IBA_KeyDataLink.INT      }
{$I IBA_MasterDataLink.INT   }
{$I IBA_Row.INT              }
{$I IBA_Column.INT           }
{$I IBA_ColumnBlob.INT       }
{$I IBA_ColumnArray.INT      }

const
{: This value is used as the default boolean true value for text columns.}
  BoolTrueChr: char = 'T';
{: This value is used as the default boolean false value for text columns.}
  BoolFalseChr: char = 'F';
{: This value is used as the default boolean true value for numeric columns.}
  BoolTrueNbr: char = '1';
{: This value is used as the default boolean false value for numeric columns.}
  BoolFalseNbr: char = '0';

{: These are the states when a transaction is in the process of closing up a
unit of work.}
  PendingTransactionStates: set of TIB_TransactionState = [
    tsSavePointPending,
    tsCommitRetainingPending,
    tsCommitPending,
    tsCommitRefreshPending,
    tsRollbackRetainingPending,
    tsRollbackPending,
    tsRollbackRefreshPending ];

procedure ClearConnectionPool;
function GetRecord( ANode: PIB_Node; ARow: TIB_Row ): word;
procedure PutRecord( ANode: PIB_Node; ARow: TIB_Row );

implementation

uses
  Consts, Registry, uRounding,

{$IFNDEF IBO_VCL60_OR_GREATER}
  FileCtrl,
{$ENDIF}

{$IFDEF IBO_VCL40_OR_GREATER}
  SyncObjs,
{$ENDIF}

  IB_Utils, IB_Parse, IB_Schema,
  IBD_Login, IBD_CancelQuery;

{$I IBA_StringList.IMP       }
{$I IBA_Stream.IMP           }
{$I IBA_Session.IMP          }
{$I IBA_Component.IMP        }
{$I IBA_SchemaCache.IMP      }
{$I IBA_DMLCache.IMP         }
{$I IBA_Connection.IMP       }
{$I IBA_ConnectionLink.IMP   }
{$I IBA_Transaction.IMP      }
{$I IBA_TransactionLink.IMP  }
{$I IBA_Database.IMP         }
{$I IBA_Statement.IMP        }
{$I IBA_StatementLink.IMP    }
{$I IBA_Dataset.IMP          }
{$I IBA_BindingCursor.IMP    }
{$I IBA_LocateCursor.IMP     }
{$I IBA_BDataset.IMP         }
{$I IBA_FilterCursor.IMP     }
{$I IBA_UpdateSQL.IMP        }
{$I IBA_DataSource.IMP       }
{$I IBA_DataLink.IMP         }
{$I IBA_KeyDataLink.IMP      }
{$I IBA_MasterDataLink.IMP   }
{$I IBA_Row.IMP              }
{$I IBA_Column.IMP           }
{$I IBA_ColumnBlob.IMP       }
{$I IBA_ColumnArray.IMP      }

initialization
  ReserveSessionHookRef; 

{$IFDEF NAG}
  if Pos( 'DELPHI32.EXE', UpperCase( Application.EXEName )) > 0 then
  else if Pos( 'IB_SQL.EXE', UpperCase( Application.EXEName )) > 0 then
  else if FindWindow( 'TAppBuilder', nil ) > 0 then
  else ShowMessage( IB_REG_MESSAGE );
{$ENDIF}

finalization
  try
    ClearConnectionPool;
  except
  // Eat exceptions for lunch, we are going home.
  end;
  ReleaseSessionHookRef;

end.

