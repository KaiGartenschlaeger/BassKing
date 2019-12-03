[Setup]
AppId={{F34BAA1D-1F85-41EE-854D-AC575251D1C9}
AppName=BassKing
AppVerName=BassKing 1.32
AppMutex=BASSKING-0000000003-VF1
AppPublisher=Kai Gartenschläger, 2009
AppPublisherURL=http://www.kaisnet.de
AppSupportURL=http://www.kaisnet.de
AppCopyright=Kai Gartenschläger, 2009
AppUpdatesURL=http://www.kaisnet.de
DefaultDirName={pf}\BassKing
DefaultGroupName=BassKing
AllowNoIcons=yes
LicenseFile=E:\Documents\PureBasic\Source\Projekte\BassKing\license.txt
OutputDir=E:\Documents\PureBasic\Source\Projekte\BassKing
OutputBaseFilename=bassking_setup
SetupIconFile=E:\Documents\PureBasic\Source\Projekte\BassKing\Ressource\SFX.ico
WizardImageFile=E:\Documents\PureBasic\Source\Projekte\BassKing\Ressource\install.bmp
Compression=lzma
SolidCompression=yes
ShowComponentSizes=yes

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\BassKing.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\Colors\*"; DestDir: "{app}\Colors\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\Plugins\*"; DestDir: "{app}\Plugins\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\PluginSystem\*"; DestDir: "{app}\PluginSystem\"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\bass.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\bass_aac.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\bass_fx.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\bassflac.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\bassking.chm"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\BassKing.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\bassmidi.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\basswma.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\basswv.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\midi.sf2"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\msvcp71.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\msvcr71.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\tag.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Documents\PureBasic\Source\Projekte\BassKing\tag_c.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\BassKing"; Filename: "{app}\BassKing.exe"
Name: "{group}\{cm:ProgramOnTheWeb,BassKing}"; Filename: "http://www.kaisnet.de"
Name: "{group}\{cm:UninstallProgram,BassKing}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\BassKing"; Filename: "{app}\BassKing.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\BassKing"; Filename: "{app}\BassKing.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\BassKing.exe"; Description: "{cm:LaunchProgram,BassKing}"; Flags: nowait postinstall skipifsilent

