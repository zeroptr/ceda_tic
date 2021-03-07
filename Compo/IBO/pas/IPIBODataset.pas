
{                                                                              }
{ IPIBODataset                                                                 }
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

unit
  IPIBODataset;

interface

uses
  SysUtils,
  WinTypes,
  WinProcs,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  DB,       
  IB_Session,
  IB_Components,
  IB_Parse,
  wwStr,
  wwSystem,
  wwtypes,
  IBODataset;

Type
  TwwIBOQuery = class( TIBOQuery )
    Private
      FControlType    : TStrings;
      FPictureMasks   : TStrings;
      FUsePictureMask : boolean;
      FOnInvalidValue : TwwInvalidValueEvent;

      Function GetControlType : TStrings;
      Procedure SetControlType( sel : TStrings );
      Function GetPictureMasks : TStrings;
      Procedure SetPictureMasks( sel : TStrings );

    Protected
      Procedure DoBeforePost; Override; { For picture support }

    Public
      Constructor Create( AOwner : TComponent ); Override;
      Destructor Destroy; Override;

    Published
{$IFDEF IBO_VCL30_OR_GREATER}
//      Property IndexDefs;  // Only Publish this if your component defines IndexDefs
{$ENDIF}
      Property ControlType : TStrings
        Read  GetControlType
        Write setControltype;
      Property PictureMasks: TStrings
        Read GetPictureMasks
        Write SetPictureMasks;
      Property ValidateWithMask : boolean
        Read FUsePictureMask
        Write FUsePictureMask;
      Property OnInvalidValue: TwwInvalidValueEvent
        Read FOnInvalidValue
        Write FOnInvalidValue;
  end;

  TwwIBOTable = class( TIBOTable )
    private
      FControlType    : TStrings;
      FPictureMasks   : TStrings;
      FUsePictureMask : boolean;
      FOnInvalidValue : TwwInvalidValueEvent;

      Function GetControlType : TStrings;
      Procedure SetControlType( sel : TStrings );
      Function GetPictureMasks : TStrings;
      Procedure SetPictureMasks( sel : TStrings );

    protected
      Procedure DoBeforePost; Override; { For picture support }

    public
      Constructor Create( AOwner : TComponent ); Override;
      Destructor Destroy; Override;

    published
{$IFDEF IBO_VCL30_OR_GREATER}
//      Property IndexDefs;  // Only Publish this if your component defines IndexDefs
{$ENDIF}
      Property ControlType : TStrings
        Read  GetControlType
        Write setControltype;
      Property PictureMasks: TStrings
        Read GetPictureMasks
        Write SetPictureMasks;
      Property ValidateWithMask : boolean
        Read FUsePictureMask
        Write FUsePictureMask;
      Property OnInvalidValue: TwwInvalidValueEvent
        Read FOnInvalidValue
        Write FOnInvalidValue;
  end;

procedure Register;

implementation

uses
  wwcommon,
  dbconsts;

// Be sure to add these lines of code to the wwcommon unit so that these new
// classes are recognized.

(*
Function wwDataset(dataSet : TDataset): boolean;
begin
   if dataset=nil then result:= false
   else
     result:=
     wwIsClass(dataset.classType, 'TwwIBOTable') or
     wwIsClass(dataset.classType, 'TwwIBOQuery') or
     wwIsClass(dataset.classType, 'TwwTable') or
     wwIsClass(dataset.classType, 'TwwQuery') or
     wwIsClass(dataset.classType, 'TwwQBE') or
     wwIsClass(dataset.classType, 'TwwStoredProc') or
     wwIsClass(dataset.classType, 'TwwClientDataset');
   {31}
   if not result then begin
      if wwGetControlType(Dataset)<>Nil then result:= true;
   end
end;
*)

Constructor TwwIBOQuery.create( AOwner : TComponent );
begin
  inherited Create( AOwner );
  FControlType    := TStringList.create;
  FPictureMasks   := TStringList.create;
  FUsePictureMask := True;
end;

Destructor TwwIBOQuery.Destroy;
begin
  FControlType.Free;
  FPictureMasks.Free;
  FPictureMasks:= NIL;
  Inherited Destroy;
end;

Function TwwIBOQuery.GetControltype : TStrings;
begin
  Result := FControlType;
end;

Procedure TwwIBOQuery.SetControlType( sel : TStrings );
begin
  FControlType.Assign( sel );
end;

Function TwwIBOQuery.GetPictureMasks : TStrings;
begin
  Result:= FPictureMasks;
end;

Procedure TwwIBOQuery.SetPictureMasks( sel : TStrings );
begin
  FPictureMasks.Assign( sel );
end;

Procedure TwwIBOQuery.DoBeforePost;
begin
  Inherited DoBeforePost;
  if FUsePictureMask then
    wwValidatePictureFields( self, FOnInvalidValue );
end;

{ TwwIBOTable }

Constructor TwwIBOTable.Create( AOwner : TComponent );
begin
  inherited Create( AOwner );
  FControlType    := TStringList.create;
  FPictureMasks   := TStringList.create;
  FUsePictureMask := True;
end;

Destructor TwwIBOTable.Destroy;
begin
  FControlType.Free;
  FPictureMasks.Free;
  FPictureMasks:= NIL;
  Inherited Destroy;
end;

Function TwwIBOTable.GetControltype : TStrings;
begin
  Result := FControlType;
end;

Procedure TwwIBOTable.SetControlType( sel : TStrings );
begin
  FControlType.Assign( sel );
end;

Function TwwIBOTable.GetPictureMasks : TStrings;
begin
  Result:= FPictureMasks;
end;

Procedure TwwIBOTable.SetPictureMasks( sel : TStrings );
begin
  FPictureMasks.Assign( sel );
end;

Procedure TwwIBOTable.DoBeforePost;
begin
  Inherited DoBeforePost;
  if FUsePictureMask then
    wwValidatePictureFields( self, FOnInvalidValue );
end;

{------------------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents('IP Access', [ TwwIBOQuery, TwwIBOTable ]); 
end;

end.
