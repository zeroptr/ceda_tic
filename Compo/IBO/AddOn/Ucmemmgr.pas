unit ucMemMgr;

interface

//Delphi 2/3 replacement Heap Manager.
// *** Do not include in packages
// *** List this unit first in your projects!

//{DEFINE DEBUGMM} //keep stats

{$IFDEF DEBUGMM}
var
  GetMemCount: Integer;
  FreeMemCount: Integer;
  ReallocMemCount: Integer;
{$ENDIF}

implementation

uses
  Windows;

//------------------------------------------------------------------------------

var
  ProcessHeap: THandle;

function tpGetMem(Size: Integer): Pointer;
//allocate memory and return a pointer to uninitialized memory
begin
{$IFDEF DEBUGMM}
  inc(GetMemCount);
{$ENDIF}
  Result:= HeapAlloc(ProcessHeap, 0, Size);
end;

function tpFreeMem(Ptr: Pointer): Integer;
//free memory allocated for the pointer! (0=ok,1-no)
begin
{$IFDEF DEBUGMM}
  inc(FreeMemCount);
{$ENDIF}
  if HeapFree(ProcessHeap, 0, Ptr) then
    Result:= 0
  else
    Result:= 1;
end;

function tpReallocMem(Ptr: Pointer; Size: Integer): Pointer;
//Reallocate size of memory at pointer. returns new pointer
begin
{$IFDEF DEBUGMM}
  inc(ReallocMemCount);
{$ENDIF}
  Result:= HeapRealloc(ProcessHeap, 0, Ptr, Size);
end;

//------------------------------------------------------------------------------

var
  OrgMemMgr: TMemoryManager;

const
  NewMemMgr: TMemoryManager =
  ( GetMem: tpGetMem;
    FreeMem: tpFreeMem;
    ReallocMem: tpReallocMem);

initialization
  ProcessHeap:= GetProcessHeap;
  GetMemoryManager(OrgMemMgr);
  SetMemoryManager(NewMemMgr);
finalization
  //SetMemoryManager(OrgMemMgr);
end.
