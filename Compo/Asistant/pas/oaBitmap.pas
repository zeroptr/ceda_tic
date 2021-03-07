{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant                                                            }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{  Special thanks to:                                                          }
{    Roberto Cardentey Ruiz <robe@electrica.ispjae.edu.cu> for fixing          }
{    transparency bug on Windows NT.                                           }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit oaBitmap;

interface

uses
  Windows, Messages, Classes, Graphics;

function CreateBitmapRgn(Bitmap: TBitmap; TransparentColor: TColor): HRgn;
function CreateBitmap1Rgn(Bitmap: TBitmap; TransparentEntry: Boolean): HRgn;
function CreateBitmap256Rgn(Bitmap: TBitmap; TransparentEntry: Byte): HRgn;

{$IFNDEF COMPILER5_UP}
function BytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: DWORD): DWORD;
{$ENDIF}

implementation

const
  AllocBy = 1000; // Rects

{$IFNDEF COMPILER5_UP}
function BytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: DWORD): DWORD;
begin
  Dec(Alignment);
  Result := (((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment) shr 3;
end;
{$ENDIF}

function CreateBitmapRgn(Bitmap: TBitmap; TransparentColor: TColor): HRgn;
var
  BitmapMask: TBitmap;
begin
  if Bitmap.PixelFormat = pf1Bit then
    Result := CreateBitmap1Rgn(Bitmap, Boolean(TransparentColor))
  else if Bitmap.PixelFormat = pf8Bit then
    Result := CreateBitmap256Rgn(Bitmap, Byte(TransparentColor))
  else
  begin
   BitmapMask := TBitmap.Create;
   try
     BitmapMask.Assign(Bitmap);
     BitmapMask.Mask(TransparentColor);
     BitmapMask.PixelFormat := pf1bit;
     Result := CreateBitmap1Rgn(BitmapMask, True);
   finally
     BitmapMask.Free;
   end;
  end;
end;

function CreateBitmap1Rgn(Bitmap: TBitmap; TransparentEntry: Boolean): HRgn;
var
  RectAllocated: Integer;
  RectFound: Integer;
  RgnData: PRgnData;
  RgnSize: Integer;
  Rects: PRect;
  MaxX, MaxY: Integer;
  XR, XL: Integer;
  X, Y: Integer;
  RowBytes: Integer;
  B, Row: PByte;
  Mask: Byte;

  procedure AddRect;
  begin
    if RectFound = RectAllocated then
    begin
      Inc(RectAllocated, AllocBy);
      Inc(RgnSize, AllocBy * SizeOf(TRect));
      ReallocMem(RgnData, RgnSize);
      Rects := PRect(@(RgnData^.Buffer));
      Inc(Rects, RectFound);
    end;
    Rects^.Left := XL;
    Rects^.Top := Y;
    Rects^.Right := XR + 1;
    Rects^.Bottom := Y + 1;
    Inc(RectFound);
    Inc(Rects);
  end;

begin
  if not Bitmap.Empty then
  begin
    RgnData := nil;
    RectFound := 0;
    RectAllocated := AllocBy;
    RgnSize := SizeOf(TRgnData) + (RectAllocated * SizeOf(TRect));
    ReallocMem(RgnData, RgnSize);
    try
      Rects := PRect(@(RgnData^.Buffer));
      MaxX := Bitmap.Width - 1;
      MaxY := Bitmap.Height - 1;
      Row := Bitmap.ScanLine[0];
      RowBytes := BytesPerScanline(MaxX + 1, 1, 32);
      for Y := 0 to MaxY do
      begin
        XL := 0;
        XR := -1;
        B := Row;
        Mask := $80;
        for X := 0 to MaxX do
        begin
          if ByteBool(B^ and Mask) = TransparentEntry then
          begin
            if XR >= XL then AddRect;
            XL := XR + 2;
          end;
          Inc(XR);
          Mask := Mask shr 1;
          if Mask = 0 then
          begin
            Mask := $80;
            Inc(B);
          end;
        end;
        if XR >= XL then AddRect;
        Dec(Row, RowBytes);
      end;
      RgnSize := SizeOf(TRgnData) + (RectFound * SizeOf(TRect));
      with RgnData^.rdh do
      begin
        dwSize := SizeOf(TRgnDataHeader);
        iType := RDH_RECTANGLES;
        nCount := RectFound;
        nRgnSize := SizeOf(TRect);
        rcBound.Left := 0;
        rcBound.Top := 0;
        rcBound.Right := MaxX;
        rcBound.Bottom := MaxY;
      end;
      Result := ExtCreateRegion(nil, RgnSize, RgnData^);
    finally
      ReallocMem(RgnData, 0);
    end;
  end
  else
    Result := CreateRectRgn(0, 0, 0, 0);
end;

function CreateBitmap256Rgn(Bitmap: TBitmap; TransparentEntry: Byte): HRgn;
var
  RectAllocated: Integer;
  RectFound: Integer;
  RgnData: PRgnData;
  RgnSize: Integer;
  Rects: PRect;
  MaxX, MaxY: Integer;
  XR, XL: Integer;
  X, Y: Integer;
  RowBytes: Integer;
  B, Row: PByte;

  procedure AddRect;
  begin
    if RectFound = RectAllocated then
    begin
      Inc(RectAllocated, AllocBy);
      Inc(RgnSize, AllocBy * SizeOf(TRect));
      ReallocMem(RgnData, RgnSize);
      Rects := PRect(@(RgnData^.Buffer));
      Inc(Rects, RectFound);
    end;
    Rects^.Left := XL;
    Rects^.Top := Y;
    Rects^.Right := XR + 1;
    Rects^.Bottom := Y + 1;
    Inc(RectFound);
    Inc(Rects);
  end;

begin
  if not Bitmap.Empty then
  begin
    RgnData := nil;
    RectFound := 0;
    RectAllocated := AllocBy;
    RgnSize := SizeOf(TRgnData) + (RectAllocated * SizeOf(TRect));
    ReallocMem(RgnData, RgnSize);
    try
      Rects := PRect(@(RgnData^.Buffer));
      MaxX := Bitmap.Width - 1;
      MaxY := Bitmap.Height - 1;
      Row := Bitmap.ScanLine[0];
      RowBytes := BytesPerScanline(MaxX + 1, 8, 32);
      for Y := 0 to MaxY do
      begin
        XL := 0;
        XR := -1;
        B := Row;
        for X := 0 to MaxX do
        begin
          if B^ = TransparentEntry then
          begin
            if XR >= XL then AddRect;
            XL := XR + 2;
          end;
          Inc(XR);
          Inc(B);
        end;
        if XR >= XL then AddRect;
        Dec(Row, RowBytes);
      end;
      RgnSize := SizeOf(TRgnData) + (RectFound * SizeOf(TRect));
      with RgnData^.rdh do
      begin
        dwSize := SizeOf(TRgnDataHeader);
        iType := RDH_RECTANGLES;
        nCount := RectFound;
        nRgnSize := SizeOf(TRect);
        rcBound.Left := 0;
        rcBound.Top := 0;
        rcBound.Right := MaxX;
        rcBound.Bottom := MaxY;
      end;
      Result := ExtCreateRegion(nil, RgnSize, RgnData^);
    finally
      ReallocMem(RgnData, 0);
    end;
  end
  else
    Result := CreateRectRgn(0, 0, 0, 0);
end;

end.
