unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBClient, Mask, DBCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    DBEdit1: TDBEdit;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  IntfRegxAgent;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  TRegxEditAgent.Create(self, Edit1, '[\d]{2,5}');

  TRegxDbEditAgent.Create(self, DbEdit1, '[\d]{2,5}');

  TRegxFieldAgent.Create(self, ClientDataset1.FieldByName('ThisField'), '[\d]{2,3}');
end;

end.
 