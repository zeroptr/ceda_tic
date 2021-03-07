unit unGLOBALS;

interface

uses SysUtils, GR32;

var
    glb_Base_Color:TColor32; // Resme hakim olan renk
    glb_Average_Color:TColor32; // Ayra� renk
    glb_Even_Color:TColor32; // Farkedilmesi gereken renk
    glb_Rastering : Integer; // Resmin grid sat�r ve kolon say�s�
    glb_PRE_SCAN : Boolean; // ��lem yap�lmadan �nce resim siyah beyaz ayr�ls�n m�?
    glb_ImageWidth,glb_ImageHeight:Integer; // i�lem yap�lacak bitmap'in boyutu
    glb_ComPort : String; // I2C nin �al��aca�� ComPort;
    glb_CapturingSource : String; // Capturing i�leminin yap�laca�� device;

implementation


end.
