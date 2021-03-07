{**********************************************}
{  TDataTableEditor                            }
{  Copyright (c) 2006-2009 by David Berneda    }
{**********************************************}
unit TeeDataTableEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     TeeDataTableTool, TeeProcs, TeCanvas, TeePenDlg, TeeSymbolEditor, TeeEdiFont;

type
  TDataTableEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ButtonPen1: TButtonPen;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSymbol: TTabSheet;
    CBLegVisible: TCheckBox;
    TabText: TTabSheet;
    ButtonPen2: TButtonPen;
    TabLegendText: TTabSheet;
    CBInverted: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    CBAutoPos: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    UDLeft: TUpDown;
    UDTop: TUpDown;
    CBFontColor: TCheckBox;
    CBOtherSide: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBAutoPosClick(Sender: TObject);
    procedure CBLegVisibleClick(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBFontColorClick(Sender: TObject);
    procedure CBOtherSideClick(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Table        : TDataTableTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TDataTableEditor.FormShow(Sender: TObject);
var tmp : TSymbolEditor;
begin
  Table:=TDataTableTool(Tag);

  if Assigned(Table) then
  begin
    with Table do
    begin
      CBAutoPos.Checked:=AutoPosition;
      CBAutoPosClick(Self);

      ButtonPen1.LinkPen(RowPen);
      ButtonPen2.LinkPen(ColumnPen);
      CBLegVisible.Checked:=Legend.Visible;
      CBInverted.Checked:=Inverted;
      UDLeft.Position:=Left;
      UDTop.Position:=Top;
      CBFontColor.Checked:=Legend.FontSeriesColor;
      CBOtherSide.Checked:=Legend.OtherSide;
    end;

    tmp:=TSymbolEditor.Create(Self);
    AddFormTo(tmp,TabSymbol,Table.Legend.Symbol);
    tmp.RefreshSymbol(Table.Legend.Symbol);

    InsertTeeFontEditor(TabText).RefreshControls(Table.Font);
    InsertTeeFontEditor(TabLegendText).RefreshControls(Table.Legend.Font);
  end;

  PageControl2.ActivePage:=TabSheet4;
  PageControl1.ActivePage:=TabSheet1;

  CreatingForm:=False;
end;

procedure TDataTableEditor.CBAutoPosClick(Sender: TObject);
begin
  Table.AutoPosition:=CBAutoPos.Checked;

  if not Table.AutoPosition then
  begin
    UDLeft.Position:=Table.Left;
    UDTop.Position:=Table.Top;
  end;

  EnableControls(not Table.AutoPosition,[Edit1,Edit2,UDLeft,UDTop]);
end;

procedure TDataTableEditor.CBLegVisibleClick(Sender: TObject);
begin
  Table.Legend.Visible:=CBLegVisible.Checked;
end;

procedure TDataTableEditor.CBInvertedClick(Sender: TObject);
begin
  Table.Inverted:=CBInverted.Checked;
end;

procedure TDataTableEditor.Edit1Change(Sender: TObject);
begin
  if (not CreatingForm) and (not Table.AutoPosition) then
     Table.Left:=UDLeft.Position;
end;

procedure TDataTableEditor.Edit2Change(Sender: TObject);
begin
  if (not CreatingForm) and (not Table.AutoPosition) then
     Table.Top:=UDTop.Position;
end;

procedure TDataTableEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
end;

procedure TDataTableEditor.CBFontColorClick(Sender: TObject);
begin
  Table.Legend.FontSeriesColor:=CBFontColor.Checked;
end;

procedure TDataTableEditor.CBOtherSideClick(Sender: TObject);
begin
  Table.Legend.OtherSide:=CBOtherSide.Checked;
end;

initialization
  RegisterClass(TDataTableEditor);
end.
