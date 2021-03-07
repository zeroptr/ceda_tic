{*******************************************************}
{                                                       }
{       TiAboutPanel Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAboutPanel;{$endif}
{$ifdef iCLX}unit QiAboutPanel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}  iTypes, iGPFunctions,   iURLLabel,  iResourceStrings,  Buttons;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QiGPFunctions, QiURLLabel, QiResourceStrings, QButtons;{$ENDIF}

type
  TiAboutPanel = class(TCustomControl)
  private
    FVersionLabel       : TLabel;
    FServicePackLabel   : TLabel;
    FCopyrightLabel     : TLabel;
    FURLLabel           : TiURLLabel;
    FLicenseAgreement   : TLabel;
    FLicenseMemo        : TMemo;
    FSpeedButton        : TSpeedButton;
    FComponentNameLabel : TLabel;
  protected
    function GetComponentName : String;
    function GetComponentGlyph: TBitmap;

    procedure SetComponentGlyph(const Value: TBitmap);
    procedure SetComponentName (const Value: String);

    procedure Resize;  override;
    procedure DoEnter; override;

    procedure LoadLicenseData;

    procedure AdjustLayout;
    procedure Loaded;                       override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

  published
    property Align;

    property ComponentName  : String  read GetComponentName  write SetComponentName;
    property ComponentGlyph : TBitmap read GetComponentGlyph write SetComponentGlyph;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiAboutPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF iCLX}HandleNeeded;{$ENDIF};
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable, csOpaque];

  Width   := 280;
  Height  := 165;


  FVersionLabel      :=TLabel.Create(Self);      FVersionLabel.Parent      :=Self;FVersionLabel.Caption     := SVersionString;
  FServicePackLabel  :=TLabel.Create(Self);      FServicePackLabel.Parent  :=Self;FServicePackLabel.Caption := SServicePackString;
  FCopyrightLabel    :=TLabel.Create(Self);      FCopyrightLabel.Parent    :=Self;FCopyrightLabel.Caption   := SCopyrightString;
  FURLLabel          :=TiURLLabel.Create(Self);  FURLLabel.Parent          :=Self;

  FLicenseAgreement  :=TLabel.Create(Self);      FLicenseAgreement.Parent  :=Self;FLicenseAgreement.Caption := 'License Agreement:';
  FLicenseMemo       :=TMemo.Create(Self);       FLicenseMemo.Parent       :=Self;FLicenseMemo.ReadOnly     := True; FLicenseMemo.ScrollBars := ssVertical;
  FSpeedButton       :=TSpeedButton.Create(Self);FSpeedButton.Parent       :=Self;

  FComponentNameLabel            := TLabel.Create(Self);
  FComponentNameLabel.Parent     := Self;
  FComponentNameLabel.Font.Style := [fsBold];
  FComponentNameLabel.Font.Size  := 10;

  LoadLicenseData;
end;
//****************************************************************************************************************************************************
destructor TiAboutPanel.Destroy;
begin
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiAboutPanel.Loaded;
begin
  inherited;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiAboutPanel.AdjustLayout;
var
  MaxLabelWidth : Integer;
begin

  MaxLabelWidth := 0;

  with Canvas do
    begin
      if TextWidth(FVersionLabel.Caption      ) > MaxLabelWidth then MaxLabelWidth := TextWidth(FVersionLabel.Caption);
      if TextWidth(FServicePackLabel.Caption  ) > MaxLabelWidth then MaxLabelWidth := TextWidth(FServicePackLabel.Caption);
      if TextWidth(FCopyrightLabel.Caption    ) > MaxLabelWidth then MaxLabelWidth := TextWidth(FCopyrightLabel.Caption);
      if TextWidth(FURLLabel.Caption          ) > MaxLabelWidth then MaxLabelWidth := TextWidth(FURLLabel.Caption);
    end;

  FVersionLabel.Top     := 13;
  FServicePackLabel.Top := FVersionLabel.Top     + FVersionLabel.Height     + 3;
  FCopyrightLabel.Top   := FServicePackLabel.Top + FServicePackLabel.Height + 3;
  FURLLabel.Top         := FCopyrightLabel.Top   + FCopyrightLabel.Height   + 3;

  FLicenseAgreement.Top := FURLLabel.Top         + FURLLabel.Height         + 3;
  FLicenseMemo.Top      := FLicenseAgreement.Top + FLicenseAgreement.Height + 3;

  FVersionLabel.Left     := Width - 10 - MaxLabelWidth;
  FServicePackLabel.Left := FVersionLabel.Left;
  FCopyrightLabel.Left   := FVersionLabel.Left;
  FURLLabel.Left         := FVersionLabel.Left;
  FLicenseAgreement.Left := 10;
  FLicenseMemo.Left      := 10;

  FSpeedButton.Left      := 10;
  FSpeedButton.Height    := 28;
  FSpeedButton.Width     := 28;

  FSpeedButton.Top := FLicenseAgreement.Top div 2 - FSpeedButton.Height div 2;

  FLicenseMemo.Height := Height - FLicenseMemo.Top - 5;

  FLicenseMemo.Width := Width - 20;

  FComponentNameLabel.Left := FSpeedButton.Left + FSpeedButton.Width + 12;
  FComponentNameLabel.Top  := FSpeedButton.Top + FSpeedButton.Height div 2 - Canvas.TextHeight(FComponentNameLabel.Caption) div 2;
end;
//****************************************************************************************************************************************************
procedure TiAboutPanel.Resize;
begin
  inherited Resize;
  if Assigned(FVersionLabel) then AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiAboutPanel.DoEnter;
begin
  inherited;
end;
//****************************************************************************************************************************************************
function TiAboutPanel.GetComponentName: String;
begin
  Result := FComponentNameLabel.Caption;
end;
//****************************************************************************************************************************************************
procedure TiAboutPanel.SetComponentName(const Value: String);
begin
  FComponentNameLabel.Caption := Value;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
function TiAboutPanel.GetComponentGlyph: TBitmap;
begin
  Result := FSpeedButton.Glyph;
end;
//****************************************************************************************************************************************************
procedure TiAboutPanel.SetComponentGlyph(const Value: TBitmap);
begin
  FSpeedButton.Glyph.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiAboutPanel.LoadLicenseData;
var
  TempString : String;
begin
  TempString := SLicenseAgreement1  + SLicenseAgreement2  + SLicenseAgreement3  + SLicenseAgreement4  + SLicenseAgreement5  + SLicenseAgreement6  +
                SLicenseAgreement7  + SLicenseAgreement8  + SLicenseAgreement9  + SLicenseAgreement10 + SLicenseAgreement11 + SLicenseAgreement12 +
                SLicenseAgreement13 + SLicenseAgreement14 + SLicenseAgreement15 + SLicenseAgreement16 + SLicenseAgreement17 + SLicenseAgreement18 +
                SLicenseAgreement19 + SLicenseAgreement20 + SLicenseAgreement21 + SLicenseAgreement22 + SLicenseAgreement23 + SLicenseAgreement24 +
                SLicenseAgreement25 + SLicenseAgreement26 + SLicenseAgreement27 + SLicenseAgreement28 + SLicenseAgreement29 + SLicenseAgreement30 +
                SLicenseAgreement31 + SLicenseAgreement32 + SLicenseAgreement33 + SLicenseAgreement34 + SLicenseAgreement35 + SLicenseAgreement36 +
                SLicenseAgreement37 + SLicenseAgreement38 + SLicenseAgreement39 + SLicenseAgreement40 + SLicenseAgreement41 + SLicenseAgreement42 +
                SLicenseAgreement43 + SLicenseAgreement44 + SLicenseAgreement45 + SLicenseAgreement46 + SLicenseAgreement47 + SLicenseAgreement48 +
                SLicenseAgreement49 + SLicenseAgreement50 + SLicenseAgreement51 + SLicenseAgreement52 + SLicenseAgreement53 + SLicenseAgreement54 +
                SLicenseAgreement55 + SLicenseAgreement56 + SLicenseAgreement57 + SLicenseAgreement58 + SLicenseAgreement59 + SLicenseAgreement60 +
                SLicenseAgreement61 + SLicenseAgreement62 + SLicenseAgreement63 + SLicenseAgreement64 + SLicenseAgreement65 + SLicenseAgreement66 +
                SLicenseAgreement67 + SLicenseAgreement68 + SLicenseAgreement69 + SLicenseAgreement70 + SLicenseAgreement71 + SLicenseAgreement72 +
                SLicenseAgreement73 + SLicenseAgreement74 + SLicenseAgreement75 + SLicenseAgreement76 + SLicenseAgreement77 + SLicenseAgreement78 +
                SLicenseAgreement79 + SLicenseAgreement80 + SLicenseAgreement81 + SLicenseAgreement82 + SLicenseAgreement83 + SLicenseAgreement84 +
                SLicenseAgreement85 + SLicenseAgreement86 + SLicenseAgreement87 + SLicenseAgreement88 + SLicenseAgreement89 + SLicenseAgreement90 +
                SLicenseAgreement91 + SLicenseAgreement92 + SLicenseAgreement93 + SLicenseAgreement94 + SLicenseAgreement95 + SLicenseAgreement96 +
                SLicenseAgreement97 + SLicenseAgreement98 + SLicenseAgreement99 + SLicenseAgreement100+ SLicenseAgreement101;

  FLicenseMemo.Text := TempString;
end;
//****************************************************************************************************************************************************
end.


