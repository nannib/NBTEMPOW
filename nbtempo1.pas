unit nbtempo1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, EditBtn, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DirectoryEdit1: TDirectoryEdit;
    Edit3: TEdit;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    ProgressBar1: TProgressBar;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DirectoryEdit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FileNameEdit1Change(Sender: TObject);
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  selectedfile: string;
  z,d1,d2,d,macd,dcsv,ctime,fn,dn: string;
  ActualTime: TDateTime;


implementation

{$R *.lfm}

{ TForm1 }



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
     actualtime:= Now;
     ctime:=FormatDateTime('yyyy-mm-dd_hh_nn_ss', actualtime);
     if  (DateTimePicker1.DateIsNull) or (DateTimePicker2.DateIsNull) then
     begin
       DateTimePicker1.Date:=1.7E308;
       DateTimePicker2.Date:=1.7E308;
     end;
     if (DateTimePicker1.DateIsNull) and (DateTimePicker2.DateIsNull) then
     begin
       d:='';
       macd:='-d 0000-00-00';
       dcsv:='All';
     end
     else
     begin
       d1:=FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
       d2:=FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
       d:=d1+'_'+d2;
       macd:='-d '+d1+'..'+d2;
       dcsv:=d;
     end;
     if  (LabeledEdit1.Text='') then
     begin
       z:=' -s '+LabeledEdit2.Text+' ';
     end
     else
     begin
       z:=' -z '+LabeledEdit1.Text+' -s '+LabeledEdit2.Text+' ';
     end;
     //ProgressBar1.StepIt;
       ExecuteAndWait('cmd /c .\bin\tsk_gettimes.exe '+z+fn+'| .\bin\mactime.exe '+macd+' >'+dn+'timeline'+dcsv+'_C'+ctime+'.csv');


     Progressbar1.Visible:=False;
     Label2.Visible:=False;
     Edit3.Text:=dn+'timeline'+dcsv+'_C'+ctime+'.csv';
 end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     Application.terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShellExecute(handle,'open',PChar(dn+'timeline'+dcsv+'_C'+ctime+'.csv'),'','',1)
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  DateTimePicker1.Date:=1.7E308;
  DateTimePicker2.Date:=1.7E308;
end;

procedure TForm1.DirectoryEdit1Change(Sender: TObject);
begin
  dn:=DirectoryEdit1.Directory;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin

end;

procedure TForm1.FileNameEdit1Change(Sender: TObject);
begin
   Edit3.Text:='';
   fn:=FileNameEdit1.Filename;
end;


end.

