unit FP.Internals.usArray;

interface

uses
  FP.uIterable;

type
  IsArray<T> = interface
    function get(const ind: Integer): T;
    function count(): Integer;
  end;

  CsArray<T> = class(TInterfacedObject, IIterable<T>, IsArray<T>)
  strict private
    _values: TArray<T>;
  public
    constructor Create(const A_values: array of T); overload;
    function GetEnumerator(): IIterator<T>;
    function get(const ind: Integer): T;
    function count(): Integer;
  end;

  CsaIterator<T> = class(TInterfacedObject, IIterator<T>)
  strict private
    _array: IsArray<T>;
    _pos: Integer;
    function getCurrent(): T;
    function MoveNext(): Boolean;
  public
    constructor Create(const A_array: IsArray<T>);
  end;

implementation

constructor CsArray<T>.Create(const A_values: array of T);
var
  i: Integer;
begin
  inherited Create();
  SetLength(_values, Length(A_values));
  for i := Low(A_values) to High(A_values) do
    _values[i] := A_values[i];
end;

function CsArray<T>.get(const ind: Integer): T;
begin
  Exit(_values[ind]);
end;

function CsArray<T>.count(): Integer;
begin
  Result := Length(_values);
end;

function CsArray<T>.GetEnumerator(): IIterator<T>;
begin
  Result := CsaIterator<T>.Create(Self);
end;

constructor CsaIterator<T>.Create(const A_array: IsArray<T>);
begin
  inherited Create;
  _pos := -1;
  _array := A_array;
end;

function CsaIterator<T>.getCurrent: T;
begin
  Result := _array.get(_pos);
end;

function CsaIterator<T>.MoveNext: Boolean;
begin
  Result := _pos < (_array.count() - 1);
  if Result then
    Inc(_pos);
end;

end.

