using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

//
// Die allgemeinen Assemblierungsinformationen werden durch die folgenden
// Attribute gesteuert. ?ndern Sie die Attributwerte, um die zu einer
// Assemblierung geh?renden Informationen zu modifizieren.
//
[assembly: AssemblyTitle("")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("")]
[assembly: AssemblyProduct("")]
[assembly: AssemblyCopyright("")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]	
	
// Die Versionsinformation einer Assemblierung enth?lt die folgenden vier Werte:
//      Hauptversion
//      Nebenversion
//      Build-Nummer
//      Revision
// Sie k?nnen alle vier Werte festlegen oder f?r Revision und Build-Nummer die
// Standardwerte mit '*' - wie nachfolgend gezeigt - verwenden:

[assembly: AssemblyVersion("1.0.*")]

//
// Zum Signieren einer Assemblierung m?ssen Sie einen Schl?ssel angeben. Weitere Informationen
// ?ber das Signieren von Assemblierungen finden Sie in der Microsoft .NET Framework-Dokumentation.
// Mit den folgenden Attributen steuern Sie, welcher Schl?ssel f?r die Signatur verwendet wird.
// Hinweise:
//   (*) Wenn kein Schl?ssel angegeben wird, ist die Assemblierung nicht signiert.
//   (*) KeyName verweist auf einen Schl?ssel, der im Crypto Service Provider
//      (CSP) auf Ihrem Rechner installiert wurde. KeyFile verweist auf eine
//       Datei, die einen Schl?ssel enth?lt.
//   (*) Wenn sowohl der KeyFile- als auch der KeyName-Wert angegeben ist, wird
//      die folgende Verarbeitung durchgef?hrt:
//       (1) Wenn KeyName in dem CSP gefunden wird, wird dieser Schl?ssel verwendet.
//       (2) Wenn KeyName nicht, aber KeyFile vorhanden ist, wird der Schl?ssel
//           in KeyFile im CSP installiert und verwendet.
//   (*) Ein KeyFile k?nnen Sie mit dem Utility sn.exe (Starker Name) erzeugen.
//       Der Speicherort von KeyFile sollte relativ zum Projektausgabeverzeichnis
//       %Projektverzeichnis%\bin\<Konfiguration> angegeben werden. Wenn sich Ihr
//       KeyFile z.B. im Projektverzeichnis befindet, w?rden Sie das Attribut
//       AssemblyKeyFile folgenderma?en festlegen:
//       [assembly: AssemblyKeyFile("..\\..\\mykey.snk")]
//   (*) Verz?gerte Signatur ist eine erweiterte Option; n?here Informationen
//       dazu finden Sie in der Microsoft .NET Framework-Dokumentation.
//
[assembly: AssemblyDelaySign(false)]
[assembly: AssemblyKeyFile("")]
[assembly: AssemblyKeyName("")]

//
// Verwenden Sie die folgenden Attribute zur Steuerung der COM-Sichtbarkeit Ihrer Assemblierung.
// Standardm??ig ist die gesamte Assemblierung f?r COM sichtbar. Die Einstellung false f?r ComVisible
// ist die f?r Ihre Assemblierung empfohlene Vorgabe. Um dann eine Klasse und ein Interface f?r COM
// bereitzustellen, setzen Sie jeweils ComVisible auf true. Es wird auch empfohlen das Attribut
// Guid hinzuzuf?gen.
//

[assembly: ComVisible(false)]
//[assembly: Guid("")]
//[assembly: TypeLibVersion(1, 0)]

