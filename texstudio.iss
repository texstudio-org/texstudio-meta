[Setup]
;Change this in every version
AppVerName=TeXstudio 2.8.8
AppVersion=2.8.8

OutputBaseFilename=texstudio2.8.8_win_qt5.3.1
;OutputBaseFilename=texstudio281_snapshot_2014-07-24_win

;#define qt4_build
#define qt5_build

#ifdef qt4_build
  #define DLL_DIR "..\texstudio-build\dlls\qt-4.8.6"
  #define EXE_DIR "..\texstudio-build\exe\qt4"
#endif
#ifdef qt5_build
  #define DLL_DIR "..\texstudio-build\dlls\qt-5.3.1"
  #define EXE_DIR "..\texstudio-build\exe\qt5"
#endif

;Don't change
AppName=TeXstudio
AppPublisher=Benito van der Zander
AppPublisherURL=http://texstudio.sourceforge.net/

DefaultDirName={pf}\TeXstudio
DefaultGroupName=TeXstudio
UninstallDisplayIcon={app}\texstudio.exe
SourceDir=..\texstudio-hg\
OutputDir=..\texstudio-installers

[Files]
Source: {#EXE_DIR}\texstudio.exe; DestDir: {app}\
#ifdef qt4_build
Source: {#DLL_DIR}\mingwm10.dll; DestDir: {app}\
Source: {#DLL_DIR}\iconv.dll; DestDir: {app}\
Source: {#DLL_DIR}\QtCore4.dll; DestDir: {app}\
Source: {#DLL_DIR}\QtGui4.dll; DestDir: {app}\
Source: {#DLL_DIR}\QtNetwork4.dll; DestDir: {app}\
Source: {#DLL_DIR}\QtXml4.dll; DestDir: {app}\
Source: {#DLL_DIR}\QtSvg4.dll; DestDir: {app}\
Source: {#DLL_DIR}\QtScript4.dll; DestDir: {app}\
Source: {#DLL_DIR}\phonon4.dll; DestDir: {app}\
Source: {#DLL_DIR}\iconengines\qsvgicon4.dll; DestDir: {app}\iconengines
Source: {#DLL_DIR}\libcurl.dll; DestDir: {app}
Source: {#DLL_DIR}\libfreetype.dll; DestDir: {app}
Source: {#DLL_DIR}\libgcc_s_dw2-1.dll; DestDir: {app}
Source: {#DLL_DIR}\libgcc_s_sjlj-1.dll; DestDir: {app}
Source: {#DLL_DIR}\liblcms2.dll; DestDir: {app}
Source: {#DLL_DIR}\libopenjpeg.dll; DestDir: {app}
Source: {#DLL_DIR}\libpng15.dll; DestDir: {app}
Source: {#DLL_DIR}\libjpeg.dll; DestDir: {app}
Source: {#DLL_DIR}\libpoppler.dll; DestDir: {app}
Source: {#DLL_DIR}\libpoppler-qt4.dll; DestDir: {app}
Source: {#DLL_DIR}\libtiff3.dll; DestDir: {app}
Source: {#DLL_DIR}\libxml2.dll; DestDir: {app}
Source: {#DLL_DIR}\libz.dll; DestDir: {app}
Source: {#DLL_DIR}\zlib1.dll; DestDir: {app}
Source: {#DLL_DIR}\libeay32.dll; DestDir: {app}
Source: {#DLL_DIR}\ssleay32.dll; DestDir: {app}
Source: {#DLL_DIR}\libwinpthread-1.dll; DestDir: {app}
Source: {#DLL_DIR}\libstdc++-6.dll; DestDir: {app} 
#else
Source: {#DLL_DIR}\*; DestDir: {app}
Source: {#DLL_DIR}\iconengines\*; DestDir: {app}\iconengines
Source: {#DLL_DIR}\imageformats\*; DestDir: {app}\imageformats
Source: {#DLL_DIR}\platforms\*; DestDir: {app}\platforms
Source: {#DLL_DIR}\printsupport\*; DestDir: {app}\printsupport
#endif

Source: utilities\dictionaries\en_GB.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\en_US.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\fr_FR.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\de_DE.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\hu_HU.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\pt_BR.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\de.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\en.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\fr.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\th_en_US_v2.dat.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\th_fr_FR_v2.dat.*; DestDir: {app}\dictionaries
Source: utilities\dictionaries\th_de_DE_v2.dat.*; DestDir: {app}\dictionaries

Source: utilities\AUTHORS; DestDir: {app}\help
Source: utilities\CHANGELOG.txt; DestDir: {app}\help
Source: utilities\COPYING; DestDir: {app}\help
Source: utilities\latex2e.html; DestDir: {app}\help
Source: utilities\latex2e.css; DestDir: {app}\help
Source: utilities\license.txt; DestDir: {app}\help
Source: utilities\manual\*; DestDir: {app}\help

Source: utilities\TexTablet\*; DestDir: {app}\TexTablet
Source: utilities\poppler-data\*; DestDir: {app}\share\poppler; Flags: recursesubdirs
Source: templates\*; DestDir: {app}\templates

; Commented out translations are not packaged because they are stongly incomplete
Source: texstudio_cs.qm; DestDir: {app}\translations
Source: texstudio_de.qm; DestDir: {app}\translations
Source: texstudio_es.qm; DestDir: {app}\translations
Source: texstudio_fr.qm; DestDir: {app}\translations
Source: texstudio_hu.qm; DestDir: {app}\translations
Source: texstudio_ja.qm; DestDir: {app}\translations
Source: texstudio_it.qm; DestDir: {app}\translations
Source: texstudio_pl.qm; DestDir: {app}\translations
Source: texstudio_pt_BR.qm; DestDir: {app}\translations
Source: texstudio_ru.qm; DestDir: {app}\translations
;Source: texstudio_uk.qm; DestDir: {app}\translations
Source: texstudio_zh_CN.qm; DestDir: {app}\translations
Source: qt_cs.qm; DestDir: {app}\translations
Source: qt_de.qm; DestDir: {app}\translations
Source: qt_es.qm; DestDir: {app}\translations
Source: qt_fr.qm; DestDir: {app}\translations
Source: qt_hu.qm; DestDir: {app}\translations
Source: qt_ja.qm; DestDir: {app}\translations
Source: qt_pl.qm; DestDir: {app}\translations
Source: qt_ru.qm; DestDir: {app}\translations
Source: qt_zh.qm; DestDir: {app}\translations

[Icons]
Name: {group}\TeXstudio; Filename: {app}\TeXstudio.exe
Name: {commondesktop}\TeXstudio; Filename: {app}\TeXstudio.exe


[Languages]
Name: en; MessagesFile: compiler:Default.isl
Name: de; MessagesFile: compiler:Languages\German.isl
Name: es; MessagesFile: compiler:Languages\Spanish.isl
Name: fr; MessagesFile: compiler:Languages\French.isl
Name: it; MessagesFile: compiler:Languages\Italian.isl
Name: cz; MessagesFile: compiler:Languages\Czech.isl
Name: pt_BR; MessagesFile: compiler:Languages\BrazilianPortuguese.isl
Name: hu; MessagesFile: compiler:Languages\Hungarian.isl
Name: ja; MessagesFile: compiler:Languages\Japanese.isl


[Tasks]
Name: texAssociation; Description: "Associate .tex files with TeXstudio"; GroupDescription: File extensions:
Name: txssAssociation; Description: "Associate session files (.txss) files with TeXstudio"; GroupDescription: File extensions:

[Registry]
Root: HKCR; Subkey: ".tex"; ValueType: string; ValueName: ""; ValueData: "texfile"; Flags: uninsdeletevalue; Tasks: texAssociation
Root: HKCR; Subkey: "texfile"; ValueType: string; ValueName: ""; ValueData: "LaTeX Document"; Flags: uninsdeletevalue; Tasks: texAssociation
Root: HKCR; Subkey: "texfile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\TeXstudio.exe"" ""%1"""; Flags: uninsdeletevalue; Tasks: texAssociation
Root: HKCR; Subkey: ".txss"; ValueType: string; ValueName: ""; ValueData: "texfile"; Flags: uninsdeletekey; Tasks: txssAssociation
Root: HKCR; Subkey: "txssfile"; ValueType: string; ValueName: ""; ValueData: "LaTeX Document"; Flags: uninsdeletekey; Tasks: txssAssociation
Root: HKCR; Subkey: "txssfile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\TeXstudio.exe"" ""%1"""; Flags: uninsdeletekey; Tasks: txssAssociation


[Run]
Filename: {app}\texstudio.exe; Description: Start TeXstudio; Flags: nowait skipifsilent postinstall

[Code]
// Handle uninstall options (Uninstall currently does not support custom pages so we have to generate a form)
var
  CheckAll, CheckSettings, CheckUserTemplates, CheckCwlFiles: TCheckBox;

procedure AllClicked(Sender: TObject);
begin
  CheckSettings.Checked := CheckAll.Checked;
  CheckUserTemplates.Checked := CheckAll.Checked;
  CheckCwlFiles.Checked := CheckAll.Checked;
end;

procedure OtherClicked(Sender: TObject);
var cb: TCheckBox;
begin
  cb := TCheckBox(Sender);
  if not cb.Checked then
  begin
    CheckAll.OnClick := NIL;
    CheckAll.Checked := False;
    CheckAll.OnClick := @AllClicked;
  end;
end;

Function ParamExists(const Param : String) : Boolean; 
var i: Integer;
begin
  result := false;
  for i := 0 to ParamCount do
  begin
    if LowerCase(Param) = LowerCase(ParamStr(i)) then
    begin
      result := true;
    end;
  end;
end;

procedure QueryUninstallOptions;
var
  Form: TSetupForm;
  Info: TLabel;
  Edit: TNewEdit;
  UninstallButton, CancelButton: TNewButton;
begin
  Form := CreateCustomForm();
  try
    Form.ClientWidth := ScaleX(256);
    Form.ClientHeight := ScaleY(168);
    Form.Caption := 'TeXstudio Uninstall Options';
    Form.Center();

    Info := TLabel.Create(Form);
    Info.Parent := Form;
    Info.Caption := 'Additionally Remove:'
    Info.Top := ScaleY(10);
    Info.Left := ScaleX(10);

    CheckAll := TCheckBox.Create(Form);
    CheckAll.Parent := Form;
    CheckAll.Checked := False;
    CheckAll.Caption := 'User Data Folder';
    CheckAll.Top := ScaleY(Info.Top + Info.Height + 6);
    CheckAll.Left := ScaleX(14);
    CheckAll.Width := Form.ClientWidth - 2*ScaleX(6);
    CheckAll.OnClick := @AllClicked;
    
    CheckSettings := TCheckBox.Create(Form);
    CheckSettings.Parent := Form;
    CheckSettings.Checked := False;
    CheckSettings.Caption := 'Settings';
    CheckSettings.Top := ScaleY(CheckAll.Top + CheckAll.Height + 6);
    CheckSettings.Left := ScaleX(20);
    CheckSettings.Width := Form.ClientWidth - 2*ScaleX(6);
    CheckSettings.OnClick := @OtherClicked;

    CheckUserTemplates := TCheckBox.Create(Form);
    CheckUserTemplates.Parent := Form;
    CheckUserTemplates.Checked := False;
    CheckUserTemplates.Caption := 'User Templates';
    CheckUserTemplates.Top := ScaleY(CheckSettings.Top + CheckSettings.Height + 6);
    CheckUserTemplates.Left := ScaleX(20);
    CheckUserTemplates.Width := Form.ClientWidth - 2*ScaleX(6);
    CheckUserTemplates.OnClick := @OtherClicked;

    CheckCwlFiles := TCheckBox.Create(Form);
    CheckCwlFiles.Parent := Form;
    CheckCwlFiles.Checked := False;
    CheckCwlFiles.Caption := 'User Completion Files';
    CheckCwlFiles.Top := ScaleY(CheckUserTemplates.Top + CheckUserTemplates.Height + 6);
    CheckCwlFiles.Left := ScaleX(20);
    CheckCwlFiles.Width := Form.ClientWidth - 2*ScaleX(6);
    CheckCwlFiles.OnClick := @OtherClicked;

    CancelButton := TNewButton.Create(Form);
    CancelButton.Parent := Form;
    CancelButton.Width := ScaleX(75);
    CancelButton.Height := ScaleY(23);
    CancelButton.Left := Form.ClientWidth - ScaleX(75 + 6 + 75 + 10);
    CancelButton.Top := Form.ClientHeight - ScaleY(23 + 10);
    CancelButton.Caption := 'Cancel';
    CancelButton.ModalResult := mrCancel;
    CancelButton.Cancel := True;

    UninstallButton := TNewButton.Create(Form);
    UninstallButton.Parent := Form;
    UninstallButton.Width := ScaleX(75);
    UninstallButton.Height := ScaleY(23);
    UninstallButton.Left := Form.ClientWidth - ScaleX(75 + 10);
    UninstallButton.Top := Form.ClientHeight - ScaleY(23 + 10);
    UninstallButton.Caption := 'Uninstall';
    UninstallButton.ModalResult := mrOk;
    UninstallButton.Default := True;

    Form.ActiveControl := UninstallButton;

    if Form.ShowModal() = mrCancel then
      Abort
    else if CheckAll.Checked then
      DelTree(ExpandConstant('{userappdata}')+'\texstudio', True, True, True)
    else begin
      if CheckSettings.Checked then
        DeleteFile(ExpandConstant('{userappdata}')+'\texstudio\texstudio.ini');
      if CheckUserTemplates.Checked then
        DelTree(ExpandConstant('{userappdata}')+'\texstudio\templates\user\*', False, True, True);
      if CheckCwlFiles.Checked then
        DelTree(ExpandConstant('{userappdata}')+'\texstudio\*.cwl', False, True, True);
    end;

  finally
    Form.Free();
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall: begin
        if not ParamExists('/SUPPRESSMSGBOXES') then
          QueryUninstallOptions;
      end;
  end;
end;
