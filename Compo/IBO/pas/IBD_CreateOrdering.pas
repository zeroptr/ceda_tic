
{                                                                              }
{ IBD_CreateOrdering                                                           }
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
  IBD_CreateOrdering;

interface

uses
	Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
	Buttons, Dialogs, ExtCtrls, CheckLst, ComCtrls,
  
	IB_Components,

	IBF_Base, XSpin;

type
	TdlgCLBoxEdit = class(TForm)
		pnMemoEditBottom: TPanel;
		pnMemoEditButtons: TPanel;
		btMemoEditOK: TButton;
		btMemoEditCancel: TButton;
		cboxDesc: TCheckBox;
		cboxDisplayNames: TCheckBox;
		Bevel1: TBevel;
		Bevel2: TBevel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lbCount: TListBox;
    clbOrder: TCheckListBox;
    Bevel3: TBevel;
    Label3: TLabel;
    seRefine: TXSpinEdit;
		procedure btMemoEditOKClick(Sender: TObject);
		procedure btMemoEditCancelClick(Sender: TObject);
		procedure clbOrderDragDrop(Sender, Source: TObject; X, Y: Integer);
		procedure clbOrderDragOver(Sender, Source: TObject; X, Y: Integer;
			State: TDragState; var Accept: Boolean);
		procedure clbOrderClickCheck(Sender: TObject);
	private
		{ Private declarations }
		FLinkList				: TIB_StringList;
		FChanged				: boolean;
		FSourceList			: TIB_StringList;
		FOrderList			: TIB_StringList;
		FUseDesc				: Boolean;
		FUseDisplayNames: Boolean;
		noClick					: Boolean;
		function SaveNewStringList: Boolean;
		procedure SetLinkList( AValue: TIB_StringList );
		procedure SetSourceList( AValue: TIB_StringList );
		procedure SetOrderList( AValue: TIB_StringList );
		procedure RenumberItems;
	public
		{ Public methods }
		constructor Create( AOwner: TComponent ); override;
		destructor Destroy; override;
		{ Public declarations }
		property LinkList: TIB_StringList read FLinkList write SetLinkList;
		property SourceList: TIB_StringList read FSourceList write SetSourceList;
		property CurrentOrderBy: TIB_StringList read FOrderList write SetOrderList;
		property AddDescLinks: Boolean read FUseDesc;
		property useDisplayNames: Boolean read FUseDisplayNames;
	end;

var
	dlgCLBoxEdit: TdlgCLBoxEdit;

implementation

{$R *.DFM}

uses
  IB_Constants;
  
constructor TdlgCLBoxEdit.Create( AOwner: TComponent );
begin
	inherited Create( AOwner );
	clbOrder.Items.Clear;
	lbCount.Clear;
	FLinkList := TIB_StringList.Create;

	noClick := TRUE;
end;

destructor TdlgCLBoxEdit.Destroy;
begin
	FLinkList.Free;
	FLinkList := nil;
	inherited Destroy;
end;

procedure TdlgCLBoxEdit.SetLinkList( AValue: TIB_StringList );
begin
	FLinkList.Assign( AValue );
end;

function TdlgCLBoxEdit.SaveNewStringList: Boolean;
var ii: Integer;
begin
	Result := FALSE;
	if Assigned( FSourceList ) then
	begin
		FSourceList.BeginUpdate;
		try
			FSourceList.Clear;

			// the quick way ...
			for ii := 0 to clbOrder.Items.Count - 1 do
			begin
				if clbOrder.Checked[ii] then FSourceList.Add ( clbOrder.Items[ii] );
			end;
		finally
			FSourceList.EndUpdate;
		end;
		if FSourceList.Count > 0
			then Result := TRUE
			else MessageDlg( 'No items were selected!', mtInformation, [mbOK], 0 );
	end;
end;

procedure TdlgCLBoxEdit.SetSourceList( AValue: TIB_StringList );
var
	ii				: integer;
	ixOfCurr	: integer;
	modStrings: TIB_StringList;
	ni				: String;
	doOrder		: Boolean;
begin
	FSourceList := AValue;
	if LinkList.Count > 0 then
	begin
		modStrings := TIB_StringList.Create;
		try
			modStrings.Assign( SourceList );
			for ii := 0 to LinkList.Count - 1 do
				modStrings.LinkValues[ LinkList[ ii ]] :=
					modStrings.LinkValues[ LinkList[ ii ]];
			// meMemo.Lines.Assign( modStrings );
			clbOrder.Items.Assign ( modStrings );
		finally
			modStrings.Free;
		end;
	end
	else clbOrder.Items.Assign ( FSourceList );

	doOrder := FALSE;
	// get rid of the "=" at the end of each string ...
	for ii := 0 to clbOrder.Items.Count - 1 do
	begin
		ni := copy ( clbOrder.Items[ii], 1, length ( clbOrder.Items[ii] ) - 1 );
		clbOrder.Items[ii] := ni;

		// mark all items as checked that are in the current order by list
		if FOrderList.IndexOf ( ni ) >= 0 then
		begin
			clbOrder.Checked[ii] := TRUE;
			lbCount.Items.Add ( IntToStr ( FOrderList.IndexOf ( ni ) + 1 ) );
			doOrder := TRUE;
		end
		else lbCount.Items.Add ( '' );
	end;

	if doOrder then
	begin
		// the items are assigned, the ordering value is shown, but not in a sequencial way yet
		for ii := 0 to FOrderList.Count - 1 do
		begin
			ixOfCurr := lbCount.Items.IndexOf ( IntToStr ( ii+1 ) );
			if ixOfCurr >= 0 then
			begin
				clbOrder.Items.Exchange ( ii, ixOfCurr );
				lbCount.Items.Exchange ( ii, ixOfCurr );
			end;
		end;
	end;
	FChanged := false;
end;

procedure TdlgCLBoxEdit.SetOrderList( AValue: TIB_StringList );
begin
	FOrderList := aValue;
end;

procedure TdlgCLBoxEdit.btMemoEditOKClick(Sender: TObject);
begin
	if SaveNewStringList then
	begin
		FChanged := false;
		FUseDesc := cboxDesc.Checked;
		FUseDisplayNames := cboxDisplayNames.Checked;
		ModalResult := mrOk;
	end;
end;

procedure TdlgCLBoxEdit.btMemoEditCancelClick(Sender: TObject);
begin
	if MessageDlg( M_Abort_Changes, mtConfirmation, [mbYes, mbNo], 0 ) <> mrYes then
		SysUtils.Abort;
	FChanged := false;
	ModalResult := mrCancel;
end;

procedure TdlgCLBoxEdit.clbOrderDragDrop(Sender, Source: TObject; X,
	Y: Integer);
var
	newpos: Integer;
	lb: TCheckListBox;
begin
	if NOT ( Sender IS TCheckListBox ) then EXIT;
	lb := TCheckListBox ( Sender );
	if ( Source is TCheckListBox ) then
	begin
		newpos := lb.ItemAtPos(Point(X,Y), true);
		lb.Items.Move(lb.ItemIndex, newpos);
		lb.ItemIndex := newpos;
		clbOrder.ItemIndex := newpos;
	end;
	RenumberItems;
end;

procedure TdlgCLBoxEdit.clbOrderDragOver(Sender, Source: TObject; X,
	Y: Integer; State: TDragState; var Accept: Boolean);
begin
	Accept := noClick AND ( Source is TCheckListBox );
end;

procedure TdlgCLBoxEdit.clbOrderClickCheck(Sender: TObject);
begin
	noClick := FALSE;
	RenumberItems;
end;

procedure TdlgCLBoxEdit.RenumberItems;
var ii, nr: Integer;
begin
	nr := 1;
	for ii := 0 to clbOrder.Items.Count - 1 do
	begin
		if clbOrder.Checked[ii] then
		begin
			lbCount.Items[ii] := IntToStr ( nr );
			inc ( nr );
		end
		else lbCount.Items[ii] := '';
	end;
	noClick := TRUE;
end;

end.
