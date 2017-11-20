unit FP.Internals.uIndexedIterator;

interface

uses
  FP.uIterators, FP.uIterable;

type
  CIndexedIterator<T> = class(TInterfacedObject, IIterator<T>)
  strict private
    _ind: Integer;
    _storage: IIterableByIndex<T>;
  public
    constructor Create(const A_storage: IIterableByIndex<T>);
    function getCurrent(): T;
    function MoveNext(): Boolean;
  end;

implementation

constructor CIndexedIterator<T>.Create(const A_storage: IIterableByIndex<T>);
begin
  inherited Create();
  _ind := -1;
  _storage := A_storage;
end;

function CIndexedIterator<T>.getCurrent(): T;
begin
  Result := _storage.Item(_ind);
end;

function CIndexedIterator<T>.MoveNext(): Boolean;
begin
  Inc(_ind);
  Result := _ind < _storage.Count();
end;

end.

