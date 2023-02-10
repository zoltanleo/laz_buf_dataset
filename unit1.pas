unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, BufDataset, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    BDS: TBufDataset;
    btnSave: TButton;
    btnLoad: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure InitBDS(Sender: TBufDataset);
  end;

const
  DataFile = 'c:\proj\buf_dataset\data\BufData.dat';
  FieldDataFile = 'c:\proj\buf_dataset\data\FieldData.dat';
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: PtrInt = 0;
begin
  InitBDS(BDS);
  Randomize;

  BDS.Active:= True;

  for i:= 0 to 99 do
    BDS.AppendRecord([Nil,Random(100),FormatDateTime('hh:nn:zzz',Now)]);
end;

procedure TForm1.InitBDS(Sender: TBufDataset);
begin
  with TBufDataset(Sender) do
  begin
    Clear;
    FieldDefs.Add('SQN', ftAutoInc);
    FieldDefs.Add('ID', ftInteger);
    FieldDefs.Add('STR', ftString, 10);
    CreateDataset;
    //Active:= True;
  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if BDS.Active then
    if not BDS.IsEmpty then
      BDS.SaveToFile(DataFile,dfDefault);
end;

procedure TForm1.btnLoadClick(Sender: TObject);
begin
  BDS.Clear;
  BDS.LoadFromFile(DataFile);
end;

end.

