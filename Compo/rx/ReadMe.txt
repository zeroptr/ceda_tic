RxLib ���������� ����������� Delphi VCL Extensions (RX) Library, 
������������� ������� ������������, ������� ��������� � ������ 
��������, ������������ ����� ���������� �������� ���������������� 
(freeware) �������, ������������ ����������� ������������� ��� � 
����� ������, ��� � �� �������.

������ ��������� ���� ��������. ���������� ���� �������� � ������ 
JEDI Visual Component Library. 
�������� �������� http://homepages.borland.com/jedi/jvcl/

��� ����������� ��������� ��� Delphi 2009-2010. �������� �������.
=====================================================================

� �� ����������, ��� ������������ �Ѩ!!! �� ��� �� ...

����� ��� ������� �������� ������������ ������������� ��������� ����� 
string, Char, PChar. �������� � ������ ������������� �� ��� �������.
�������� ����������� ��������� ��������� ������: 

1. ������ RxRichEd.pas:
  - ��������� ������������ ������ ����������� ������ TRichEditStrings 
    ��� ������ � �������/�������� LoadFromFile, LoadFromStream, 
    SaveToFile, SaveToStream � ������������ � ������ �������� CG2009 
    (��������� ��������������� ���������������� ������� � 
    ���������� Encoding: TEncoding)
  - �������� TRxCustomRichEdit.StreamMode - ��� CG2009 �������� �� 
    ��������� ��������� ������ ���� smUnicode:   
    TRichStreamMode = (smSelection, smPlainRtf, 
                       smNoObjects{$IFNDEF RX_D12}, smUnicode{$ENDIF});
    TRichStreamModes = set of TRichStreamMode;
    ��� ���� �������������� ����� � ������ TRichEditStrings ������� 
    �� ���������.

2. ������ rxDbutils.pas:
  - �������� ����:
    TBookmark ������� �� Pointer;
    TBookmarkStr ������� �� TBookmark;
    PChar ������� �� TRecordBuffer (�� �����, � �� ������). 
    ���������:
    {$IFDEF RX_D12}
      TBookmarkType = TBookmark;
      TBookmarkPointerType = Pointer;
      TBuffer = TRecordBuffer;
    {$ELSE}
      TBookmarkType = TBookmarkStr;
      TBookmarkPointerType = TBookmark;
      TBuffer = PChar;
    {$ENDIF}
    ����� �� ������ ��������������� ���� �������� �� TBookmarkType, 
    TBuffer, TBookmarkPointerType ��� ������������� � �������� 
    �������� Delphi.

3. ������ RxMemDS.pas:
  - �������� ���� (���������� ������ 2):
    {$IFDEF RX_D12}
      TBlobDataArray = array of TBlobData;
      TBlobDataArrayType = TBlobDataArray;
      TBlobDataType = TBlobData;
    {$ELSE}
      TMemBlobData = AnsiString;
      TMemBlobArray = array[0..0] of TMemBlobData;
      TBlobDataArrayType = ^TMemBlobArray;
      TBlobDataType = TMemBlobData;
      PMemBlobArray = ^TMemBlobArray;
    {$ENDIF}   
    
4. ������ rxCheckItm.pas:
  - ���������� ������ � ��������� �������� Items ���������� CheckListBox.

���������: 
- ������ ������������� ��� ������, ������ � ���������. 
- ������ �� ����������� �������� Rxdemo, Riched2, Gifanm32 
  ������������� � ��������� ��������. ��������� ������ ��������� 
  �������� ��������, ��� �� ���� ��������...
- ��� ������� ������� ��������. 

===============================================================
������������: psa1974 
�������� �����:
http://forum.ru-board.com/
http://www.dumpz.ru/
http://www.nowa.cc
