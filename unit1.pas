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
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: PtrInt = 0;
  a: PtrInt = 0;
  s: String = '';
begin
  with BDS do
  begin
    FieldDefs.Add('SQN', ftAutoInc);
    FieldDefs.Add('ID', ftInteger);
    FieldDefs.Add('STR', ftString, 10);
    CreateDataset;
    Active:= True;

    Randomize;

    for i:= 0 to 100 do
    begin
      a:= Random(100);
      s:= FormatDateTime('hh:nn:zzz',Now);
      AppendRecord([Nil,a,s]);
    end;
  end;

  with SpinEdit1 do
  begin
    MinValue:= 0;
    MaxValue:= 100;
  end;

  with SpinEdit2 do
  begin
    MinValue:= 0;
    MaxValue:= 100;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: PtrInt = 0;
begin
  BDS.Filtered:= False;
  BDS.Filter:= 'ID>' + IntToStr(SpinEdit1.Value) + ' and ID<' + IntToStr(SpinEdit2.Value);
  //BDS.Filter:= 'ID>' + IntToStr(SpinEdit1.Value) + ' or ID<' + IntToStr(SpinEdit2.Value);
  BDS.Filtered:= True;
  BDS.DisableControls;

  try
    BDS.First;
    while not BDS.EOF do
    begin
      Inc(i);
      BDS.Next;
    end;
  finally
    BDS.EnableControls;
  end;

  Caption:= IntToStr(i);
end;

end.

