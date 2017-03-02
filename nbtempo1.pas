unit nbtempo1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ShellCtrls, ExtCtrls, ComCtrls, StdCtrls, EditBtn,Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    ProgressBar1: TProgressBar;
    ShellListView1: TShellListView;
    ShellTreeView1: TShellTreeView;
    ShellTreeView2: TShellTreeView;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ShellListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ShellListView1Click(Sender: TObject);
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure ShellTreeView1Click(Sender: TObject);
    procedure ShellTreeView2Change(Sender: TObject; Node: TTreeNode);
    procedure TimeEdit1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  selectedfile: string;
  z,d1,d2,t1,t2: string;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ShellListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.FormStartDock(Sender: TObject; var DragObject: TDragDockObject
  );
begin

end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin

end;

procedure TForm1.ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;
procedure ExecuteAndWait(const aCommando: string);
var
  tmpStartupInfo: TStartupInfo;
  tmpProcessInformation: TProcessInformation;
  tmpProgram: String;
begin
  tmpProgram := trim(aCommando);
  FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
  with tmpStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    wShowWindow := SW_HIDE;
  end;

  if CreateProcess(nil, pchar(tmpProgram), nil, nil, true, CREATE_NO_WINDOW,
    nil, nil, tmpStartupInfo, tmpProcessInformation) then
  begin
    // loop every 10 ms
    while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
    end;
    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);
  end
  else
  begin
    RaiseLastOSError;
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
     Edit3.text:='';
     Progressbar1.Visible:=True;
     Label2.Visible:=True;
     d1:=FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
     d2:=FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
     if  (LabeledEdit1.Text='') then
     begin
       z:=' -s '+LabeledEdit2.Text+' ';
     end
     else
     begin
       z:=' -z '+LabeledEdit1.Text+' -s '+LabeledEdit2.Text+' ';
     end;
     //ProgressBar1.StepIt;
       ExecuteAndWait('cmd /c .\bin\tsk_gettimes.exe '+z+Edit1.Text+'| .\bin\mactime.exe -d '+d1+'..'+d2+' >'+Edit2.Text+'timeline'+d1+'_'+d2+'.csv');

  //        0=hide / 1=SW_SHOWNORMAL / 3=max / 7=min)
   // return values 0..32 are errors, over 32 success.
 //    if ShellExecuteEx(0,nil,PChar('cmd'),PChar('/c .\bin\tsk_gettimes.exe '+z+Edit1.Text+'| .\bin\mactime.exe -d '+d1+'..'+d2+' >'+Edit2.Text+'timeline'+d1+'_'+d2+'.csv'),nil,0) > 32 then
 //    begin
     Progressbar1.Visible:=False;
     Label2.Visible:=False;
     Edit3.Text:=Edit2.Text+'timeline'+d1+'_'+d2+'.csv';
 //    end
 //    else
 //    begin
 //    Edit2.Text:='THERE IS AN ERROR!';
 //    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     Application.terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShellExecute(handle,'open',PChar(Edit2.Text+'timeline'+d1+'_'+d2+'.csv'),'','',1)
end;

procedure TForm1.ShellListView1Click(Sender: TObject);
begin
     Edit1.Text := ShellListView1.GetPathFromItem(ShellListView1.Selected);
end;

procedure TForm1.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
begin

end;

procedure TForm1.ShellTreeView1Click(Sender: TObject);
begin
  Edit3.Text:='';
end;

procedure TForm1.ShellTreeView2Change(Sender: TObject; Node: TTreeNode);
begin
     Edit2.Text := ShellTreeView2.Path;
end;

procedure TForm1.TimeEdit1Change(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

end;

end.
