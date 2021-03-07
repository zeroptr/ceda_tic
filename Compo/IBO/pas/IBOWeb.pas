
{                                                                              }
{ IBOWeb                                                                       }
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

{: This unit contains the components for working with the HTML components.}
unit
  IBOWeb;

interface

uses
  SysUtils, Windows, Classes, HTTPApp, DB, DBWeb, 

  IB_Components,
  IBODataset;

{ TIBODatasetTableProducer }

type

{: This component is used in order to make it possible to do everything that the
TQueryTableProducer component does. It processes the input parameters of the
query based on the parameters which were posted from the surfer.
<br><br>
Please refer to the base class or TQueryTableProducer for the necessary help
since it is designed to work exactly like it.} 
TIBODatasetTableProducer = class( TDSTableProducer )
private
  FIBODataset: TIBODataset;
  procedure SetIBODataset( AIBODataset: TIBODataset );
protected
  function GetDataset: TDataset; override;
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation ); override;
  procedure SetDataset( ADataset: TDataset ); override;
public
{: This method has been overriden so that the output of this component can be
customized appropriately.}
  function Content: string; override;
published
{$IFNDEF HELPSCAN}  
  property Caption;
  property CaptionAlignment;
  property Columns;
  property Footer;
  property Header;
  property MaxRows;
{$ENDIF}
{: Reference to the IBODataset from which it will get data to populate the HTML
table with.}
  property IBODataset: TIBODataset read FIBODataset write SetIBODataset;
{$IFNDEF HELPSCAN}
  property RowAttributes;
  property TableAttributes;
  property OnCreateContent;
  property OnFormatCell;
  property OnGetTableCaption;
{$ENDIF}
end;


procedure IBODumpDataset(       ADS: TIBODataset;
                                SingleRecord: boolean;
                          const ACaption,
                                AEofMessage,
                                ATblTags: string;
                          var ARetVal: string );

implementation

uses
  IB_Parse, IB_Utils;

procedure IBODumpDataset(       ADS: TIBODataset;
                                SingleRecord: boolean;
                          const ACaption,
                                AEofMessage,
                                ATblTags: string;
                          var ARetVal: string );
  function GetEofMsg: string;
  begin
                              Result := '<tr><td>';
    if AEofMessage <> '' then Result := Result + AEofMessage
                         else Result := Result + 'End Of File';
                              Result := Result + '</td></tr></table>';
  end;
var
  ii: integer;
  bk: string;
  wa: boolean;
begin
  with ADS do
  begin
    wa := Active;
    try
    if not wa then Open;
    bk := Bookmark;
    ARetVal := ARetVal + #13#10'<table ' + ATblTags + '>'#13#10;
    if ACaption <> '' then
      ARetVal := ARetVal + '<caption>' + ACaption + '</caption>'#13#10;
    if Eof then
      ARetVal := ARetVal + GetEofMsg
    else
    begin
      if SingleRecord then
      begin
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii] do
          begin
            if Visible {and ( Trim( AsString ) <> '' )} then
            begin
              ARetVal := ARetVal + '<tr><th>' + DisplayLabel + '</th>';
              ARetVal := ARetVal + '<td>' + DisplayText + '</td></tr>'#13#10;
            end;
          end;
      end
      else
      begin
        First;
        ARetVal := ARetVal + '<tr>'#13#10;
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii] do
            ARetVal := ARetVal + '<th>' + DisplayLabel + '</th>'#13#10;
        ARetVal := ARetVal + '</tr>'#13#10;
        if Eof then
          ARetVal := ARetVal + GetEofMsg
        else
          while not Eof do
          begin
            ARetVal := ARetVal + '<tr>'#13#10;
            for ii := 0 to FieldCount - 1 do
              with Fields[ii] do
                ARetVal := ARetVal + '<td>' + DisplayText + '</td>'#13#10;
            ARetVal := ARetVal + '</tr>'#13#10;
            Next;
          end;
      end;
    end;
    ARetVal := ARetVal + '</table>'#13#10;
    finally
      if wa then Bookmark := bk else Close;
    end;
  end;
end;

{ TIBODatasetTableProducer }

function TIBODatasetTableProducer.Content: string;
var
  tmpParams: TStrings;
  ii: Integer;
  Name: string;
  tmpS: string;
{$IFDEF IBO_VCL40_OR_GREATER}  
  Param: TParam;
{$ELSE}
  Param: TIB_Column;
{$ENDIF}
begin
  Result := '';
  if Assigned( FIBODataset ) then
  begin
    FIBODataset.Prepare;
    tmpParams := nil;
    if Assigned( Dispatcher ) then
    begin
      if Dispatcher.Request.MethodType = mtPost then
        tmpParams := Dispatcher.Request.ContentFields
      else
      if Dispatcher.Request.MethodType = mtGet then
        tmpParams := Dispatcher.Request.QueryFields;
    end;
    if Assigned( tmpParams ) then
      with FIBODataset.Params do
        try
          BeginUpdate;
          for ii := 0 to tmpParams.Count - 1 do
          begin
            Name := tmpParams.Names[ii];
            Param := FIBODataset.FindParam( Name );
            if Assigned( Param ) then
            begin
              tmpS := stLitCriteria( tmpParams.Values[ Name ] );
              if Param.IsNull or ( Param.AsString <> tmpS ) then
              begin
                FIBODataset.Close;
                Param.AsString := tmpS;
              end;
            end;
          end;
        finally
{$IFDEF IBO_VCL40_OR_GREATER}
          EndUpdate;
{$ELSE}
          if RowState = rsModified then
            FIBODataset.Close;
          EndUpdate( true );
{$ENDIF}
        end;
    FIBODataset.Open;
    if DoCreateContent then
      Result := Header.Text +
                HTMLTable( FIBODataset, Self, MaxRows ) +
                Footer.Text;
  end;
end;

procedure TIBODatasetTableProducer.Notification( AComponent: TComponent;
                                                Operation: TOperation );
begin
  inherited Notification(AComponent, Operation);
  if ( Operation = opRemove ) and ( AComponent = FIBODataset ) then
  begin
    FIBODataset := nil;
    InternalDataSource.Dataset := nil;
  end;
end;

function TIBODatasetTableProducer.GetDataset: TDataset;
begin
  Result := FIBODataset;
end;

procedure TIBODatasetTableProducer.SetDataset( ADataset: TDataset );
begin
  SetIBODataset( ADataset as TIBODataset );
end;

procedure TIBODatasetTableProducer.SetIBODataset( AIBODataset: TIBODataset );
begin
  if FIBODataset <> AIBODataset then
  begin
    if Assigned( AIBODataset ) then
      AIBODataset.FreeNotification(Self);
    FIBODataset := AIBODataset;
    InternalDataSource.Dataset := FIBODataset;
  end;
end;

end.

