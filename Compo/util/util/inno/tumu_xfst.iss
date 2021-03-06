; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=FLORIST
AppVerName=FLORIST 2.03
AppPublisher=Pi Tasar?m Organizasyon Mobilya Bilisim ve Cam San.Tic.Ltd.Sti.
AppPublisherURL=http://www.pitasarim.com.tr
AppSupportURL=http://www.pitasarim.com.tr
AppUpdatesURL=http://www.pitasarim.com.tr
DefaultDirName={pf}\FLORIST
DefaultGroupName=FLORIST
LicenseFile=D:\pikareyenidata\lisans.rtf
OutputDir=D:\pikareyenidata\setup
OutputBaseFilename=florist_setup
SetupIconFile=D:\pikareyenidata\pi2.ico
Compression=lzma
SolidCompression=true

[Languages]
Name: tur; MessagesFile: compiler:Languages\turkish.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}

[Files]
Source: pi2.exe; DestDir: {app}; Flags: ignoreversion
Source: yedekle.bat; DestDir: {app}; Flags: onlyifdoesntexist
Source: webbc.txt; DestDir: {app}; Flags: onlyifdoesntexist
Source: D:\pikareyenidata\anascreen.jpg; DestDir: {app}; Flags: ignoreversion
Source: ftdizayn2.fr3; DestDir: {app}; Flags: onlyifdoesntexist
Source: ftdizayn_coklu.fr3; DestDir: {app}; Flags: onlyifdoesntexist
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: Bosdata\cicek2008.FDB; DestDir: {app}; Flags: onlyifdoesntexist
Source: desen\1.jpg; DestDir: {app}\desen\
Source: desen\2.jpg; DestDir: {app}\desen\
Source: desen\3.jpg; DestDir: {app}\desen\
Source: desen\4.jpg; DestDir: {app}\desen\
Source: desen\5.jpg; DestDir: {app}\desen\
Source: desen\6.jpg; DestDir: {app}\desen\
Source: desen\7.jpg; DestDir: {app}\desen\
Source: desen\8.jpg; DestDir: {app}\desen\
Source: midas.dll; DestDir: {sys}
Source: midas.dll; DestDir: {app}
Source: Setup\PDFCreatorPilot2.dll; DestDir: {sys}
Source: Setup\PDFCreatorPilot2.dll; DestDir: {app}
Source: Setup\Firebird.exe; DestDir: {app}
Source: Setup\Acrobat.exe; DestDir: {app}


[Icons]
Name: {group}\FLORIST; Filename: {app}\pi2.exe
Name: {userdesktop}\FLORIST; Filename: {app}\pi2.exe; Tasks: desktopicon

[Run]
Filename: {app}\pi2.exe; Description: {cm:LaunchProgram,FLORIST}; Flags: nowait postinstall skipifsilent
Filename: {app}\Acrobat.exe; Flags: hidewizard runhidden
Filename: {sys}\regsvr32.exe; Flags: nowait runhidden 32bit; Tasks: ; Languages: ; Parameters: /s {sys}\PDFCreatorPilot2.dll
Filename: {app}\Firebird.exe; Parameters: "/SILENT /DIR=""{app}\Fb21\"""; WorkingDir: {app}; Flags: hidewizard runhidden

[INI]
Filename: {app}\Ayarlar.Ini; Section: Genel; Key: data; String: {app}\CICEK2008.FDB; Flags: createkeyifdoesntexist; Tasks: ; Languages: 
[Dirs]
Name: {app}\Resim
Name: {app}\Yedekler
