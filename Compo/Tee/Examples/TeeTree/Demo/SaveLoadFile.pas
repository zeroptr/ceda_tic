unit SaveLoadFile;

interface

uses
  Windows, Messages,
  SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  Base, TeeTree, TreeEd, TeeProcs;

type
  TSaveLoadFileForm = class(TBaseForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

{$IFDEF CLR}
uses
  System.Text;
{$ENDIF}

procedure TSaveLoadFileForm.FormCreate(Sender: TObject);
var St: {$IFDEF CLR}StringBuilder{$ELSE}Array[0..255] of Char{$ENDIF};
begin
  inherited;

  // Set Edit1 to a temporary file name, with TTR extension:

  if GetTempPath(SizeOf(St),St)>0 then
  begin
    Edit1.Text:=St{$IFDEF CLR}.ToString{$ENDIF};
    if Edit1.Text[Length(Edit1.Text)]<>'\' then Edit1.Text:=Edit1.Text+'\';
  end
  else
     Edit1.Text:='c:\';

  Edit1.Text:=Edit1.Text+'Tree1.ttr';
end;

procedure TSaveLoadFileForm.Button1Click(Sender: TObject);
var MyTree : TTree;
    {$IFDEF CLR}
    tmp    : TCustomTree;
    {$ENDIF}
begin

  // Create a hidden Tree, and then save it to a file.
  MyTree:=TTree.Create(Self);

  try

    // Important:
    // At runtime, set this property to False so new nodes are owned
    // by the Tree. Owned nodes will then be saved, otherwise not.

    MyTree.NoOwnerShapes:=False;

    // Add sample nodes:
    MyTree.Add('Hello');
    MyTree.Add('World');

    // Cosmetic:
    MyTree.Color:=clAqua;

    // Save tree:
    SaveTreeToFile(MyTree,Edit1.Text);

  finally
    MyTree.Free; // destroy temporary Tree
  end;


  // After saving the Tree to a file, load it back into
  // the existing Tree1 :

  {$IFDEF CLR}
  tmp:=TCustomTree(Tree1);
  LoadTreeFromFile(tmp,Edit1.Text);
  {$ELSE}
  LoadTreeFromFile(TCustomTree(Tree1),Edit1.Text);
  {$ENDIF}

  // See also:

  //  LoadTreeFromFileDialog(TCustomTree(Tree1));

  //  LoadTreeChildsFromFile(Tree1.Roots[0],'c:\Sample.ttr');

  //  LoadTreeFromStream(TCustomTree(Tree1),MyStream);

  //  SaveTeeToStream(Tree1,MyStream);
end;

initialization
  RegisterClass(TSaveLoadFileForm);
end.
