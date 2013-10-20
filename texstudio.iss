[Setup]
;Change this in every version
AppVerName=TeXstudio 2.6.4
AppVersion=2.6.4

OutputBaseFilename=texstudio264_win32

;Don't change
AppName=TeXstudio
AppPublisher=Benito van der Zander
AppPublisherURL=http://texstudio.sourceforge.net/

DefaultDirName={pf}\TeXstudio
DefaultGroupName=TeXstudio
UninstallDisplayIcon={app}\texstudio.exe
SourceDir=..\texstudio-hg\

[Files]
Source: texstudio.exe; DestDir: {app}\
Source: mingwm10.dll; DestDir: {app}\
Source: iconv.dll; DestDir: {app}\
Source: QtCore4.dll; DestDir: {app}\
Source: QtGui4.dll; DestDir: {app}\
Source: QtNetwork4.dll; DestDir: {app}\
Source: QtXml4.dll; DestDir: {app}\
Source: QtSvg4.dll; DestDir: {app}\
Source: QtScript4.dll; DestDir: {app}\
Source: phonon4.dll; DestDir: {app}\
Source: iconengines\qsvgicon4.dll; DestDir: {app}\iconengines

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
Source: utilities\*.png; DestDir: {app}\help
Source: utilities\latexhelp.html; DestDir: {app}\help
Source: utilities\license.txt; DestDir: {app}\help
Source: utilities\usermanual_en.html; DestDir: {app}\help
Source: utilities\usermanual.css; DestDir: {app}\help

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
;Source: texstudio_it.qm; DestDir: {app}\translations
Source: texstudio_pt_BR.qm; DestDir: {app}\translations
;Source: texstudio_uk.qm; DestDir: {app}\translations
Source: texstudio_zh_CN.qm; DestDir: {app}\translations
Source: qt_cs.qm; DestDir: {app}\translations
Source: qt_de.qm; DestDir: {app}\translations
Source: qt_es.qm; DestDir: {app}\translations
Source: qt_fr.qm; DestDir: {app}\translations
Source: qt_hu.qm; DestDir: {app}\translations
Source: qt_ja.qm; DestDir: {app}\translations
Source: qt_zh.qm; DestDir: {app}\translations

Source: libcurl.dll; DestDir: {app}
Source: libfreetype.dll; DestDir: {app}
Source: libgcc_s_dw2-1.dll; DestDir: {app}
Source: libgcc_s_sjlj-1.dll; DestDir: {app}
Source: liblcms2.dll; DestDir: {app}
Source: libopenjpeg.dll; DestDir: {app}
Source: libpng15.dll; DestDir: {app}
Source: libjpeg.dll; DestDir: {app}
Source: libpoppler.dll; DestDir: {app}
Source: libpoppler-qt4.dll; DestDir: {app}
Source: libtiff3.dll; DestDir: {app}
Source: libxml2.dll; DestDir: {app}
Source: libz.dll; DestDir: {app}
Source: zlib1.dll; DestDir: {app}
Source: libeay32.dll; DestDir: {app}
Source: ssleay32.dll; DestDir: {app}

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
Filename: {app}\texstudio.exe; Description: Start TeXstudio; Flags: nowait postinstall

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
    usUninstall:
      begin
        QueryUninstallOptions;
      end;
  end;
end;