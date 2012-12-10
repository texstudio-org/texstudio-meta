[Setup]
;Change this in every version
AppVerName=TeXstudio 2.5.2
AppVersion=2.5.2

OutputBaseFilename=texstudio252_win32

;Don't change
AppName=TeXstudio
AppPublisher=Benito van der Zander
AppPublisherURL=http://texstudio.sourceforge.net/

DefaultDirName={pf}\TeXstudio
DefaultGroupName=TeXstudio
UninstallDisplayIcon={app}\texstudio.exe
SourceDir=..\..\

[Files]
Source: texstudio.exe; DestDir: {app}\
Source: mingwm10.dll; DestDir: {app}\
Source: iconv.dll; DestDir: {app}\
Source: QtCore4.dll; DestDir: {app}\
Source: QtGui4.dll; DestDir: {app}\
Source: QtNetwork4.dll; DestDir: {app}\
Source: QtXml4.dll; DestDir: {app}\
Source: QtScript4.dll; DestDir: {app}\
Source: phonon4.dll; DestDir: {app}\

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
Source: utilities\poppler-data\*; DestDir: {app}\share\poppler Flags: recursesubdirs
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

Source: libfreetype.dll; DestDir: {app}
Source: libgcc_s_dw2-1.dll; DestDir: {app}
Source: liblcms-1.dll; DestDir: {app}
Source: libopenjpeg.dll; DestDir: {app}
Source: libpng14.dll; DestDir: {app}
Source: libjpeg.dll; DestDir: {app}
Source: libpoppler.dll; DestDir: {app}
Source: libpoppler-qt4.dll; DestDir: {app}
Source: libxml2.dll; DestDir: {app}
Source: libzlib1.dll; DestDir: {app}
Source: zlib1.dll; DestDir: {app}

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
Name: txssAssociation; Description: "Associate Session files (.txss) files with TeXstudio"; GroupDescription: File extensions:

[Registry]
Root: HKCR; Subkey: ".tex"; ValueType: string; ValueName: ""; ValueData: "texfile"; Flags: uninsdeletevalue; Tasks: texAssociation
Root: HKCR; Subkey: "texfile"; ValueType: string; ValueName: ""; ValueData: "LaTeX Document"; Flags: uninsdeletevalue; Tasks: texAssociation
Root: HKCR; Subkey: "texfile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\TeXstudio.exe"" ""%1"""; Flags: uninsdeletevalue; Tasks: texAssociation
Root: HKCR; Subkey: ".txss"; ValueType: string; ValueName: ""; ValueData: "texfile"; Flags: uninsdeletekey; Tasks: txssAssociation
Root: HKCR; Subkey: "txssfile"; ValueType: string; ValueName: ""; ValueData: "LaTeX Document"; Flags: uninsdeletekey; Tasks: txssAssociation
Root: HKCR; Subkey: "txssfile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\TeXstudio.exe"" ""%1"""; Flags: uninsdeletekey; Tasks: txssAssociation


[Run]
Filename: {app}\texstudio.exe; Description: Start TeXstudio; Flags: nowait postinstall
