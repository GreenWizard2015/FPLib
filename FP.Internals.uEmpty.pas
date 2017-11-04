unit FP.Internals.uEmpty;

interface

uses
  FP.uIterable, System.SysUtils;

type
  CEmptyIterable<T> = class(TInterfacedObject, IIterable<T>)
  public
    function GetEnumerator(): IIterator<T>;
  end;

  CEmptyIterator<T> = class(TInterfacedObject, IIterator<T>)
  strict private
    function getCurrent(): T;
    function MoveNext(): Boolean;
  end;

implementation

function CEmptyIterator<T>.getCurrent(): T;
begin
  raise Exception.Create('Empty.');
end;

function CEmptyIterator<T>.MoveNext(): Boolean;
begin
  Result := False;
end;

function CEmptyIterable<T>.GetEnumerator(): IIterator<T>;
begin
  Result := CEmptyIterator<T>.Create();
end;

end.

