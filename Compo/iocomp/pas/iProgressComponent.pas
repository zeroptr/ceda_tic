{*******************************************************}
{                                                       }
{       TiProgressComponent Component                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iProgressComponent;{$endif}
{$ifdef iCLX}unit QiProgressComponent;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iPositionComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiPositionComponent;{$ENDIF}

type
  TiProgressComponent = class(TiPositionComponent)
  private
    FShowOffSegments : Boolean;

    FSectionCount    : Integer;

    FSectionColor1   : TColor;
    FSectionColor2   : TColor;
    FSectionColor3   : TColor;
    FSectionColor4   : TColor;
    FSectionColor5   : TColor;

    FSectionEnd1     : Double;
    FSectionEnd2     : Double;
    FSectionEnd3     : Double;
    FSectionEnd4     : Double;
  protected
    procedure SetSectionColor1  (const Value : TColor);
    procedure SetSectionColor2  (const Value : TColor);
    procedure SetSectionColor3  (const Value : TColor);
    procedure SetSectionColor4  (const Value : TColor);
    procedure SetSectionColor5  (const Value : TColor);

    procedure SetSectionEnd1    (const Value : Double);
    procedure SetSectionEnd2    (const Value : Double);
    procedure SetSectionEnd3    (const Value : Double);
    procedure SetSectionEnd4    (const Value : Double);

    procedure SetSectionCount   (const Value : Integer);
    procedure SetShowOffSegments(const Value : Boolean);

    procedure DefineProperties(Filer : TFiler);   override;

    procedure ReadSectionEnd1 (Reader : TReader);
    procedure ReadSectionEnd2 (Reader : TReader);
    procedure ReadSectionEnd3 (Reader : TReader);
    procedure ReadSectionEnd4 (Reader : TReader);

    procedure WriteSectionEnd1(Writer : TWriter);
    procedure WriteSectionEnd2(Writer : TWriter);
    procedure WriteSectionEnd3(Writer : TWriter);
    procedure WriteSectionEnd4(Writer : TWriter);
  public
    constructor Create(AOwner: TComponent);      override;
  published
    property BackGroundColor;
    property SectionColor1   : TColor  read FSectionColor1   write SetSectionColor1   default clLime;
    property SectionColor2   : TColor  read FSectionColor2   write SetSectionColor2   default clYellow;
    property SectionColor3   : TColor  read FSectionColor3   write SetSectionColor3   default clRed;
    property SectionColor4   : TColor  read FSectionColor4   write SetSectionColor4   default clYellow;
    property SectionColor5   : TColor  read FSectionColor5   write SetSectionColor5   default clYellow;
    property SectionEnd1     : Double  read FSectionEnd1     write SetSectionEnd1;
    property SectionEnd2     : Double  read FSectionEnd2     write SetSectionEnd2;
    property SectionEnd3     : Double  read FSectionEnd3     write SetSectionEnd3;
    property SectionEnd4     : Double  read FSectionEnd4     write SetSectionEnd4;
    property SectionCount    : Integer read FSectionCount    write SetSectionCount    default 1;
    property ShowOffSegments : Boolean read FShowOffSegments write SetShowOffSegments default True;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiProgressComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 16;
  Height := 200;

  FSectionCount    := 1;

  FSectionColor1   := clLime;
  FSectionColor2   := clYellow;
  FSectionColor3   := clRed;
  FSectionColor4   := clYellow;
  FSectionColor5   := clYellow;

  FSectionEnd1     := 50;
  FSectionEnd2     := 75;

  FShowOffSegments := True;
end;
//****************************************************************************************************************************************************
procedure TiProgressComponent.SetSectionColor1  (const Value: TColor );begin SetColorProperty  (Value,FSectionColor1,  irtInvalidate);end;
procedure TiProgressComponent.SetSectionColor2  (const Value: TColor );begin SetColorProperty  (Value,FSectionColor2,  irtInvalidate);end;
procedure TiProgressComponent.SetSectionColor3  (const Value: TColor );begin SetColorProperty  (Value,FSectionColor3,  irtInvalidate);end;
procedure TiProgressComponent.SetSectionColor4  (const Value: TColor );begin SetColorProperty  (Value,FSectionColor4,  irtInvalidate);end;
procedure TiProgressComponent.SetSectionColor5  (const Value: TColor );begin SetColorProperty  (Value,FSectionColor5,  irtInvalidate);end;
procedure TiProgressComponent.SetSectionEnd1    (const Value: Double );begin SetDoubleProperty (Value,FSectionEnd1,    irtInvalidate);end;
procedure TiProgressComponent.SetSectionEnd2    (const Value: Double );begin SetDoubleProperty (Value,FSectionEnd2,    irtInvalidate);end;
procedure TiProgressComponent.SetSectionEnd3    (const Value: Double );begin SetDoubleProperty (Value,FSectionEnd3,    irtInvalidate);end;
procedure TiProgressComponent.SetSectionEnd4    (const Value: Double );begin SetDoubleProperty (Value,FSectionEnd4,    irtInvalidate);end;
procedure TiProgressComponent.SetShowOffSegments(const Value: Boolean);begin SetBooleanProperty(Value,FShowOffSegments,irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiProgressComponent.SetSectionCount(const Value: Integer);
begin
  if (Value < 1) or (Value > 5) then exit;
  if FSectionCount <> Value then
    begin
      FSectionCount := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiProgressComponent.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('SectionEnd1_2', ReadSectionEnd1, WriteSectionEnd1, True);
  Filer.DefineProperty('SectionEnd2_2', ReadSectionEnd2, WriteSectionEnd2, True);
  Filer.DefineProperty('SectionEnd3_2', ReadSectionEnd3, WriteSectionEnd3, True);
  Filer.DefineProperty('SectionEnd4_2', ReadSectionEnd4, WriteSectionEnd4, True);
end;
//****************************************************************************************************************************************************
procedure TiProgressComponent.ReadSectionEnd1(Reader: TReader);begin FSectionEnd1 := Reader.ReadFloat;end;
procedure TiProgressComponent.ReadSectionEnd2(Reader: TReader);begin FSectionEnd2 := Reader.ReadFloat;end;
procedure TiProgressComponent.ReadSectionEnd3(Reader: TReader);begin FSectionEnd3 := Reader.ReadFloat;end;
procedure TiProgressComponent.ReadSectionEnd4(Reader: TReader);begin FSectionEnd4 := Reader.ReadFloat;end;
//****************************************************************************************************************************************************
procedure TiProgressComponent.WriteSectionEnd1(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd1);end;
procedure TiProgressComponent.WriteSectionEnd2(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd2);end;
procedure TiProgressComponent.WriteSectionEnd3(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd3);end;
procedure TiProgressComponent.WriteSectionEnd4(Writer: TWriter);begin Writer.WriteFloat(FSectionEnd4);end;
//****************************************************************************************************************************************************
end.
