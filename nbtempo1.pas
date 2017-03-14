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
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
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
    LabeledEdit2: TLabeledEdit;
    ProgressBar1: TProgressBar;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure DirectoryEdit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FileNameEdit1Change(Sender: TObject);
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure StaticText3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  selectedfile: string;
  z,d1,d2,d,macd,dcsv,ctime,fn,dn,zulu,zl,skew: string;
  ActualTime: TDateTime;


implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.FormStartDock(Sender: TObject; var DragObject: TDragDockObject
  );
begin
  zulu:='';
  zl:='';
end;


procedure TForm1.ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.StaticText3Click(Sender: TObject);
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
       macd:=zulu+' -d 0000-00-00';
       dcsv:='All';
     end
     else
     begin
       d1:=FormatDateTime('yyyy-mm-dd', DateTimePicker1.Date);
       d2:=FormatDateTime('yyyy-mm-dd', DateTimePicker2.Date);
       d:=d1+'_'+d2;
       macd:=zulu+' -d '+d1+'..'+d2;
       dcsv:=d;
     end;
     if (LabeledEdit2.Text='') then
     begin
       LabeledEdit2.Text:='0';
     end;

     z:=' -s '+LabeledEdit2.Text+' ';
     skew:='skew'+LabeledEdit2.Text;
     //ProgressBar1.StepIt;
       ExecuteAndWait('cmd /c .\bin\tsk_gettimes.exe '+z+fn+'| .\bin\mactime.exe '+macd+' >'+dn+'\timeline'+dcsv+'_C'+ctime+zl+skew+'.csv');

     Progressbar1.Visible:=False;
     Label2.Visible:=False;
     Edit3.Text:=dn+'\timeline'+dcsv+'_C'+ctime+zl+skew+'.csv';
 end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     Application.terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShellExecute(handle,'open',PChar(dn+'\timeline'+dcsv+'_C'+ctime+zl+skew+'.csv'),'','',1)
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  DateTimePicker1.Date:=1.7E308;
  DateTimePicker2.Date:=1.7E308;
end;


procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if (CheckBox1.Checked) then
  begin
    CheckBox2.Checked:=FALSE;
    CheckBox1.Checked:=TRUE;
   zulu:='-y';
   zl:='ZULU';
   end
   else
   begin
   zulu:='';
   zl:='';
   end;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
  CheckBox1.Checked:=FALSE;
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

