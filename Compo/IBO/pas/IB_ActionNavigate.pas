{                                                                              }
{ IB_ActionNavigate                                                            }
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
{  Guido Klapperich <guido.klapperich@t-online.de>	                           }
{  10/31/2001                                                                  }
{     I have fixed a bug in TIB_ActionNext and TIB_ActionPrior                 }
{                                                                              }
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  30-Oct-2001                                                                 }
{     I've made this Actions "focused dataset" enabled like IB_xxxBars are.    }
{     So there is a ReceiveFocus property and an OnReceiveFocus event added    }
{                                                                              }
{  Guido Klapperich <guido.klapperich@t-online.de>	                           }
{  10/28/2001                                                                  }
{     Update to IBO4, because the behaviour of the IB_NavigationBar            }
{     has changed a little bit                                                 }
{                                                                              }
{  Guido Klapperich <guido.klapperich@t-online.de>	                           }
{  05/04/2001                                                                  }
{     I have changed the IB_Navigation-Actions in that way, that the           }
{     Enabled-Property of the Actions behave now exactly like the              }
{     the Buttons of the IB_NavigationBar                                      }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_ActionNavigate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList,

  IB_Components, IB_Constants;

type
  TIB_CustomActionNavigate = class(TAction)
{$I IB_DataLink.INT}
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure SysStateChanged; virtual;
    procedure Loaded; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HandlesTarget(Target: TObject): Boolean; override;
  published
    { Published-Deklarationen }
  end;

  TIB_ActionFirst = class(TIB_CustomActionNavigate)
  private
    { Private Declarations }
  protected
    { Protected Declarations }
    procedure SysStateChanged; override;
  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published Declarations }
    property DataSource;
  end;

  TIB_ActionPrior = class(TIB_CustomActionNavigate)
  private
    { Private Declarations }
  protected
    { Protected Declarations }
    procedure SysStateChanged; override;
  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published Declarations }
    property DataSource;
  end;

  TIB_ActionNext = class(TIB_CustomActionNavigate)
  private
    { Private Declarations }
  protected
    { Protected Declarations }
    procedure SysStateChanged; override;
  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published Declarations }
    property DataSource;
  end;

  TIB_ActionLast = class(TIB_CustomActionNavigate)
  private
    { Private Declarations }
  protected
    { Protected Declarations }
    procedure SysStateChanged; override;
  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    { Published Declarations }
    property DataSource;
  end;

implementation

{ TIB_CustomActionNavigate }

constructor TIB_CustomActionNavigate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIB_DataLink := TIB_DataLink.Create(Self);
  with DataLink do
  begin
    AfterAssignment := IB_DatasetStateChanged;
    OnPreparedChanged := IB_DatasetStateChanged;
    OnActiveChange := IB_DatasetStateChanged;
    OnStateChanged := IB_DatasetStateChanged;
    OnDataChange := IB_DatasetDataChange;
  end;
end;

destructor TIB_CustomActionNavigate.Destroy;
begin
  with DataLink do
  begin
    AfterAssignment := nil;
    OnPreparedChanged := nil;
    OnActiveChange := nil;
    OnStateChanged := nil;
    OnDataChange := nil;
  end;
  inherited Destroy;
end;

function TIB_CustomActionNavigate.GetDataSource: TIB_DataSource;
begin
  Result := FIB_DataLink.DataSource;
end;

function TIB_CustomActionNavigate.GetReceiveFocus: boolean;
begin
  Result := DataLink.ReceiveFocus;
end;

procedure TIB_CustomActionNavigate.SetReceiveFocus(AValue: boolean);
begin
  DataLink.ReceiveFocus := AValue;
end;

function TIB_CustomActionNavigate.HandlesTarget(Target: TObject): Boolean;
begin
  Result := True;
end;

procedure TIB_CustomActionNavigate.SetDataSource(AValue: TIB_DataSource);
begin
  FIB_DataLink.DataSource := AValue;
  SysStateChanged;
end;

procedure TIB_CustomActionNavigate.SysStateChanged;
begin
  // do nothing
end;

procedure TIB_CustomActionNavigate.IB_DatasetStateChanged( Sender: TIB_DataLink;
  DataSource: TIB_DataSource );
begin
  SysStateChanged;
end;

procedure TIB_CustomActionNavigate.IB_DatasetDataChange( Sender: TIB_DataLink;
  DataSource: TIB_DataSource; IB_Field: TIB_Column );
begin
  SysStateChanged;
end;

function TIB_CustomActionNavigate.GetOnReceiveFocus: TIB_DataLinkEvent;
begin
  Result := DataLink.OnReceiveFocus;
end;

procedure TIB_CustomActionNavigate.SetOnReceiveFocus( AValue: TIB_DataLinkEvent );
begin
  DataLink.OnReceiveFocus := AValue;
end;

procedure TIB_CustomActionNavigate.Loaded;
begin
  inherited Loaded;
  SysStateChanged;
end;

{ TIB_CustomActionFirst }

constructor TIB_ActionFirst.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := C_NB_FIRST;
  Hint := H_NB_FIRST;
end;

procedure TIB_ActionFirst.ExecuteTarget(Target: TObject);
begin
  if FIB_DataLink.Prepared then
    FIB_DataLink.Dataset.First;
end;

procedure TIB_ActionFirst.SysStateChanged;
begin
  inherited;
  if FIB_DataLink.Prepared and
     (( FIB_DataLink.Dataset.StatementType = stSelect ) or
      ( FIB_DataLink.Dataset.StatementType = stSelectForUpdate )) and
     FIB_DataLink.Dataset.CanScroll then
  begin
    if DataSource.Dataset is TIB_BDataset then
    begin
      with DataSource.Dataset as TIB_BDataset do
      begin
        if BufferHasBof then
          Enabled := RowNum <> (BofRowNum + 1)
        else
          Enabled := True;
      end;
    end
    else
    with DataSource.Dataset do
      Enabled := CanScroll or ( Unidirectional and Prepared );
  end
  else
    Enabled := False;
end;

{ TIB_CustomActionPrior }

constructor TIB_ActionPrior.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := C_NB_PRIOR;
  Hint := H_NB_PRIOR;
end;

procedure TIB_ActionPrior.ExecuteTarget(Target: TObject);
begin
  if FIB_DataLink.Prepared then
    with FIB_DataLink.Dataset do
    begin
      if RowNum = BofRowNum + 1 then
      begin
        if not Unidirectional then ValidateRows( BofRowNum, BofRowNum );
      end;
      if Unidirectional or ( RowNum > BofRowNum + 1 ) then
        Prior
      else
        SysStateChanged;
    end;
end;

procedure TIB_ActionPrior.SysStateChanged;
begin
  inherited;
  if FIB_DataLink.Prepared and
     (( FIB_DataLink.Dataset.StatementType = stSelect ) or
      ( FIB_DataLink.Dataset.StatementType = stSelectForUpdate )) and
     FIB_DataLink.Dataset.CanScroll then
  begin
    if DataSource.Dataset is TIB_BDataset then
    begin
      with DataSource.Dataset as TIB_BDataset do
      begin
        if BufferHasBof then
          Enabled := RowNum  > (BofRowNum + 1)
        else
          Enabled := True;
      end;
    end
    else
    with DataSource.Dataset do
      Enabled := False;
  end
  else
    Enabled := False;
end;

{ TIB_CustomActionNext }

constructor TIB_ActionNext.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := C_NB_NEXT;
  Hint := H_NB_NEXT;
end;

procedure TIB_ActionNext.ExecuteTarget(Target: TObject);
begin
  if FIB_DataLink.Prepared then
    with FIB_DataLink.Dataset do
    begin
      if RowNum = EofRowNum - 1 then
      begin
        if not Unidirectional then ValidateRows( EofRowNum, EofRowNum );
      end;
      if Unidirectional or ( RowNum < EofRowNum - 1 ) then
        Next
      else
        SysStateChanged;
    end;
end;


procedure TIB_ActionNext.SysStateChanged;
begin
  inherited;
  if FIB_DataLink.Prepared and
     (( FIB_DataLink.Dataset.StatementType = stSelect ) or
      ( FIB_DataLink.Dataset.StatementType = stSelectForUpdate )) and
     FIB_DataLink.Dataset.CanScroll then
  begin
    if DataSource.Dataset is TIB_BDataset then
    begin
      with DataSource.Dataset as TIB_BDataset do
      begin
        if BufferHasEof then
          Enabled := RowNum <  (EofRowNum - 1)
        else
          Enabled := True;
      end;
    end
    else
    with DataSource.Dataset do
      Enabled := not Eof;
  end
  else
    Enabled := False;
end;

{ TIB_CustomActionLast }

constructor TIB_ActionLast.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := C_NB_LAST;
  Hint := H_NB_LAST;
end;

procedure TIB_ActionLast.ExecuteTarget(Target: TObject);
begin
  if FIB_DataLink.Prepared then
    FIB_DataLink.Dataset.Last;
end;


procedure TIB_ActionLast.SysStateChanged;
begin
  inherited;
  if FIB_DataLink.Prepared and
     (( FIB_DataLink.Dataset.StatementType = stSelect ) or
      ( FIB_DataLink.Dataset.StatementType = stSelectForUpdate )) and
     FIB_DataLink.Dataset.CanScroll then
  begin
    if DataSource.Dataset is TIB_BDataset then
    begin
      with DataSource.Dataset as TIB_BDataset do
      begin
        if BufferHasEof then
          Enabled := RowNum <> (EofRowNum - 1)
        else
          Enabled := True;
      end;
    end
    else
    with DataSource.Dataset do
      Enabled := not Eof;
  end
  else
    Enabled := False;
end;

end.
