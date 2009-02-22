[Setup]
;Change this in every version
AppVerName=TexMakerX 1.8
AppVersion=1.8

;Don't change
AppName=TexMakerX
AppPublisher=Benito van der Zander
AppPublisherURL=http://texmakerx.sourceforge.net/

OutputBaseFilename=texmakerxwin32-install

DefaultDirName={pf}\TexMakerX
DefaultGroupName=TexMakerX
UninstallDisplayIcon={app}\texmakerx.exe
SourceDir=..\..\

[Files]
Source: "texmakerx.exe"; DestDir: "{app}\";
Source: "..\texmakerx\mingwm10.dll"; DestDir: "{app}\";
Source: "..\texmakerx\QtCore4.dll"; DestDir: "{app}\";
Source: "..\texmakerx\QtGui4.dll"; DestDir: "{app}\";
Source: "..\texmakerx\QtNetwork4.dll"; DestDir: "{app}\";
Source: "..\texmakerx\QtXml4.dll"; DestDir: "{app}\";

Source: "utilities\en_GB.*"; DestDir: "{app}\dictionaries";
Source: "utilities\fr_FR.*"; DestDir: "{app}\dictionaries";

Source: "utilities\AUTHORS"; DestDir: "{app}\help";
Source: "utilities\CHANGELOG.txt"; DestDir: "{app}\help";
Source: "utilities\COPYING"; DestDir: "{app}\help";
Source: "utilities\doc*.png"; DestDir: "{app}\help";
Source: "utilities\latexhelp.html"; DestDir: "{app}\help";
Source: "utilities\license.txt"; DestDir: "{app}\help";
Source: "utilities\usermanual*.html"; DestDir: "{app}\help";

Source: "texmakerx_de.qm"; DestDir: "{app}\translation";
Source: "texmakerx_fr.qm"; DestDir: "{app}\translation";
Source: "utilities\qt_de.qm"; DestDir: "{app}\translation";
Source: "utilities\qt_fr.qm"; DestDir: "{app}\translation";


[Icons]
Name: "{group}\TexMakerX"; Filename: "{app}\TexMakerX.exe";
Name: "{commondesktop}\TexMakerX"; Filename: "{app}\TexMakerX.exe";

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"
Name: "fr"; MessagesFile: "compiler:Languages\French.isl"

[Run]
Filename: "{app}\texmakerx.exe"; Description: "Start TexMakerX"; Flags: nowait postinstall

