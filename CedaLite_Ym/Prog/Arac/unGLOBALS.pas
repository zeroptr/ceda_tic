unit unGLOBALS;

interface

uses SysUtils, GR32;

var
    glb_Base_Color:TColor32; // Resme hakim olan renk
    glb_Average_Color:TColor32; // Ayraç renk
    glb_Even_Color:TColor32; // Farkedilmesi gereken renk
    glb_Rastering : Integer; // Resmin grid satýr ve kolon sayýsý
    glb_PRE_SCAN : Boolean; // Ýþlem yapýlmadan önce resim siyah beyaz ayrýlsýn mý?
    glb_ImageWidth,glb_ImageHeight:Integer; // iþlem yapýlacak bitmap'in boyutu
    glb_ComPort : String; // I2C nin çalýþacaðý ComPort;
    glb_CapturingSource : String; // Capturing iþleminin yapýlacaðý device;

implementation


end.
