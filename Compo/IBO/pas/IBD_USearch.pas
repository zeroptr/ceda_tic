
{                                                                              }
{ IBD_USearch                                                                  }
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
{  © Copyright 1999 Claudio Valderrama C. - Chile.                             }
{                                                                              }
{      Use of this code is restricted to the author's own programs.            }
{      Permission is granted to Jason Wharton to use this unit                 }
{      in his development tools.                                               }
{                                                                              }
{      This unit performs a search of files in a disk. It does not create      }
{      any explicit files neither alters some files. However, the author       }
{      doesn't assume responsability for supposed damaged derived from the     }
{      use of this unit.                                                       }
{                                                                              }
{      Current implementation accepts a wildcard or a path terminated in a     }
{      wildcard.                                                               }
{      If drive and dir are not specified, current path is assumed.            }
{                                                                              }
{      Future extensions: ability to search for several extensions at the      }
{      same time (ie *.gdb;*.dpr;*.cpp) like Explorer's Find Window does.      }
{                                                                              }
{      Modified on 1999.8.13 to retain extension passed to ModalSearchEx.      }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBD_USearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls;

const
  WM_MESSAGEBUSCAR = WM_USER + 3;

type
  TfrmUSearch = class(TForm)
    TreeViewFiles: TTreeView;
    pnHeader: TPanel;
    Label1: TLabel;
    LabelDir: TLabel;
    LabelFiles: TLabel;
    SpeedButtonDir: TSpeedButton;
    ButtonFind: TButton;
    EditFind: TEdit;
    pnFooter: TPanel;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    procedure ButtonFindClick(Sender: TObject);
    procedure TreeViewFilesChange(Sender: TObject; Node: TTreeNode);
    procedure ButtonOkClick(Sender: TObject);
    procedure SpeedButtonDirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure TreeViewFilesDblClick(Sender: TObject);
  private
    { Private declarations }
    NumDir, NumFiles: Integer;
    FFileName: TFileName;
    FAutoSearchPath: String;
    FAutoSearchExt: String;
    Stop: Boolean;
    mylevel: Integer;
    procedure WMMessageBuscar(var Message: TMessage); message WM_MESSAGEBUSCAR;
    procedure DoBuscar(const sFiles: String);
    procedure InitBuscar(const name: String; node: TTreeNode);
    procedure RecursiveBuscar(const n, p: String; node: TTreeNode);
  public
    { Public declarations }
    property Filename: TFileName read FFileName;
    property AutoSearchPath: String write FAutoSearchPath;
  end;

var
  frmUSearch: TfrmUSearch;

function ModalSearch( var rFileName: TFileName ): Boolean;
function ModalSearchEx( const sFiles: String;
                          var rFileName: TFileName ): Boolean;

implementation

{$R *.DFM}

uses
  FileCtrl,
  IB_Utils;

procedure TfrmUSearch.ButtonFindClick(Sender: TObject);
begin
  DoBuscar( EditFind.Text );
end;

procedure TfrmUSearch.DoBuscar(const sFiles: String);
var
  mywildcard, aDrive, aDirPart, aFilePart, e: String;
  aDriveChar: Char;
begin
  FAutoSearchPath := EmptyStr;
  if Stop then With TreeViewFiles.Items do begin
     try
       BeginUpdate;
       Clear;
     finally
       EndUpdate
     end;
     LabelDir.Caption := '0';
     LabelFiles.Caption := '0';
     NumDir := 0;
     NumFiles := 0;
     mywildcard := Trim(sFiles);
     if mywildcard = EmptyStr then Exit;
     //ProcessPath fails when it receives an UNC path
     if Copy(mywildcard, 1, 2) <> '\\' then begin
       // aDriveChar and aDirPart filled by current dir if missing.
       ProcessPath(mywildcard, aDriveChar, aDirPart, aFilePart);
       aDrive := aDriveChar + ':';
     end else begin
       aDrive := EmptyStr; //ExtractFileDrive(mywildcard);
       aDirPart := ExtractFilePath(mywildcard);
       aFilePart := ExtractFileName(mywildcard)
     end;
     if aFilePart = EmptyStr then Exit;
     e := ExtractFileExt( aFilePart );
     if (e = EmptyStr) or
        (e = '.') or
        (e = '.*') or
        (e = '.???') then Exit;
     if aDirPart = EmptyStr then begin
       aDirPart := GetCurrentDir;
        if AnsiLastChar(aDirPart)^ <> '\' then aDirPart := aDirPart + '\';
        aDirPart := ExtractFilePath(AdirPart);
     end;
       BeginUpdate;
     ButtonFind.Caption := 'Stop';
     Stop := False;
     try
       if AnsiLastChar(aDirPart)^ <> '\'
         then InitBuscar(aDrive + aDirPart + '\' + aFilePart, nil)
         else InitBuscar(aDrive + aDirPart + aFilePart, nil);
        if Count > 0 then Item[0].Expand(false)
     finally
               EndUpdate;
        ButtonFind.Caption := 'Find';
        Stop := True;
     end;
     LabelDir.Caption := IntToStr(NumDir);
     LabelFiles.Caption := IntToStr(NumFiles);
  end else Stop := True
end;

procedure TfrmUSearch.InitBuscar(const name: String; node: TTreeNode);
var
   p, n: String;
   OldErrorMode: Integer;
   NotUsed, VolFlags: DWORD;
   Buf: array [0..MAX_PATH] of Char;
begin
   p := ExtractFilePath(name);
   if AnsiLastChar(p)^ <> '\' then p := p + '\';
   n := ExtractFileName(name);
   if not DirectoryExists(p) then Exit;
   node := TreeViewFiles.Items.Add(node, p);
   mylevel := node.Level;
   RecursiveBuscar(n, p, node);
   // if not NTFS filesystemtype
  	OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  	try
    	Buf[0] := #$00;
    	GetVolumeInformation(
        PChar(ExtractFileDrive(p) + '\'),
        nil,
        0,
   	nil,
        NotUsed,
        VolFlags,
        Buf,
        sizeof(Buf));
  	finally
    	SetErrorMode(OldErrorMode);
  	end;
  	if AnsiStrIComp(Buf, 'NTFS') <> 0 then node.AlphaSort
end;

procedure TfrmUSearch.RecursiveBuscar(const n, p: String; node: TTreeNode);
var
   FindHandle: THandle;
   FindData: TWin32FindData;
   newnode: TTreeNode;
   oldNumDir: Integer;
begin
   FindData.dwFileAttributes := FILE_ATTRIBUTE_READONLY or
                                FILE_ATTRIBUTE_COMPRESSED;
   FindHandle := FindFirstFile(PChar(p + n), FindData);
   if FindHandle <> INVALID_HANDLE_VALUE then With TreeViewFiles.Items do
   try
      AddChild(node, {p +} FindData.cFileName);
      Inc(NumFiles);
      Inc(NumDir);
   	While FindNextFile(FindHandle, FindData) = TRUE do begin
         AddChild(node, {p +} FindData.cFileName);
         Inc(NumFiles)
      end
   finally
      Windows.FindClose(Findhandle)
   end;

   With Application do begin
     ProcessMessages;
     if Stop or Terminated then Exit;
   end;

  FindData.dwFileAttributes := FILE_ATTRIBUTE_READONLY or
                               FILE_ATTRIBUTE_COMPRESSED or
                               FILE_ATTRIBUTE_DIRECTORY;
   FindHandle := FindFirstFile(PChar(p + '*.*'), FindData);
   if FindHandle <> INVALID_HANDLE_VALUE then With TreeViewFiles.Items do
   try
      if (AnsiStrComp(FindData.cFilename, '.') <> 0)
      	and (FindData.dwFileAttributes and
             FILE_ATTRIBUTE_DIRECTORY <> 0) then begin
        	newnode := AddChild(node, FindData.cFileName);
         OldNumDir := NumDir;
       	RecursiveBuscar(n, p + FindData.cFileName + '\', newnode);
        if NumDir = oldNumDir then newnode.Delete
      end;
      while FindNextFile(FindHandle, FindData) = TRUE do
         if (AnsiStrComp(FindData.cFileName, '..') <> 0)
         	and (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0)
         then begin
         	newnode := AddChild(node, FindData.cFileName);
            OldNumDir := NumDir;
         	RecursiveBuscar(n, p + FindData.cFileName + '\', newnode);
            if NumDir = oldNumDir
      		then newnode.Delete
         end
   finally
      Windows.FindClose(FindHandle)
   end;
end;

procedure TfrmUSearch.TreeViewFilesChange(Sender: TObject;
  Node: TTreeNode);
begin
  ButtonOk.Enabled := (not Node.HasChildren) and (Node.Level > mylevel)
end;

procedure TfrmUSearch.ButtonOkClick(Sender: TObject);
var
  node: TTreenode;
begin
  node := TreeViewFiles.Selected;
  FFileName := node.Text;
  node := node.Parent;
  While (node <> nil) and (node.Level > mylevel) do Begin
    Insert(node.Text + '\', FFileName, 1);
    node := node.Parent
  end;
  Insert( node.Text, FFileName, 1 );
  //ShowMessage(FFileName)
end;

procedure TfrmUSearch.SpeedButtonDirClick(Sender: TObject);
var
  Dir: string;
begin
  GetDir( 0, Dir );
  Dir := ExtractFileDrive(Dir) + '\';
// Bug in D3 TSelectDirDlg.SetDirectory: cannot select root directory

  if SelectDirectory( Dir, [], 0 ) then
  begin
  // Modified on 1999.8.13 to retain extension passed to ModalSearchEx
  		if FAutoSearchExt = EmptyStr
      then EditFind.Text := Dir
  		else if AnsiLastChar(Dir)^ <> '\'
      then EditFind.Text := Dir + '\*' + FAutoSearchExt
  		else EditFind.Text := Dir + '*' + FAutoSearchExt
  end
end;

procedure TfrmUSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Stop := True;
  if ModalResult <> mrOk then FFileName := EmptyStr
end;

procedure TfrmUSearch.FormShow(Sender: TObject);
begin
  ButtonOk.Enabled := False;
  EditFind.Clear;
  Stop := True;
  if FAutoSearchPath <> EmptyStr then begin
    EditFind.Text := FAutoSearchPath;
    FAutoSearchExt := ExtractFileExt(FAutoSearchPath);
    PostMessage(Self.Handle, WM_MESSAGEBUSCAR, 0, 0)
  end
  else FAutoSearchExt := EmptyStr
end;

procedure TfrmUSearch.WMMessageBuscar(var Message: TMessage);
begin
  DoBuscar(FAutoSearchPath);
end;

function ModalSearch(var rFileName: TFileName): Boolean;
begin
  Result := ModalSearchEx(EmptyStr, rFileName)
end;

function ModalSearchEx(const sFiles: String; var rFileName: TFileName): Boolean;
begin
  with TfrmUSearch.Create(Application) do
    try
      AutoSearchPath := sFiles;
      Result := ShowModal = mrOk;
      if Result then rFileName := FileName
                else rFileName := EmptyStr;
    finally
      Release;
    end;
end;

procedure TfrmUSearch.ButtonCancelClick(Sender: TObject);
begin
  Stop := True
end;

procedure TfrmUSearch.TreeViewFilesDblClick(Sender: TObject);
begin
  if ButtonOk.Enabled then ButtonOk.Click
end;

end.
