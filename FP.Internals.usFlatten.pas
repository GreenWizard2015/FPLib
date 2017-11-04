unit FP.Internals.usFlatten;

interface

uses
  FP.uIterable;

type
  CsFlatten<T> = class(TInterfacedObject, IIterable<T>)
  strict private
    _iterables: IIterable<IIterable<T>>;
    function GetEnumerator(): IIterator<T>;
  public
    constructor Create(const A_iterables: IIterable<IIterable<T>>);
  end;

  CsFlattenIterator<T> = class(TInterfacedObject, IIterator<T>)
  strict private
    _it: IIterator<T>;
    _iterables: IIterator<IIterable<T>>;
    function getCurrent(): T;
    function MoveNext(): Boolean;
  public
    constructor Create(const A_iterables: IIterator<IIterable<T>>);
  end;

implementation

uses
  FP.Internals.uEmpty;

constructor CsFlatten<T>.Create(const A_iterables: IIterable<IIterable<T>>);
begin
  inherited Create;
  _iterables := A_iterables;
end;

function CsFlatten<T>.GetEnumerator(): IIterator<T>;
begin
  Result := CsFlattenIterator<T>.Create( //
    _iterables.GetEnumerator() //
  );
end;

constructor CsFlattenIterator<T>.Create(const A_iterables: IIterator<IIterable<T>>);
begin
  inherited Create();
  _iterables := A_iterables;
  _it := CEmptyIterator<T>.Create();
end;

function CsFlattenIterator<T>.getCurrent(): T;
begin
  Result := _it.Current;
end;

function CsFlattenIterator<T>.MoveNext(): Boolean;
begin
  while True do
  begin
    if _it.MoveNext() then
      Exit(True);

    if not _iterables.MoveNext() then
      Exit(False);

    _it := _iterables.Current.GetEnumerator();
  end;
end;

end.

