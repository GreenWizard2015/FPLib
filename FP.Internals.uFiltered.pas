unit FP.Internals.uFiltered;

interface

uses
  FP.uIterable;

type
  CfIterable<T> = class(TInterfacedObject, IIterable<T>)
  strict private
    _filter: FnFilter<T>;
    _iterable: IIterable<T>;
  public
    constructor Create(const A_iterable: IIterable<T>; const A_filter: FnFilter<T>);
    function GetEnumerator(): IIterator<T>;
  end;

  CfIterator<T> = class(TInterfacedObject, IIterator<T>)
  strict private
    _filter: FnFilter<T>;
    _iterator: IIterator<T>;
    _value: T;
    function getCurrent(): T;
    function MoveNext(): Boolean;
  public
    constructor Create(const A_iterator: IIterator<T>; const A_filter: FnFilter<T>);
  end;

implementation

constructor CfIterable<T>.Create(const A_iterable: IIterable<T>; const A_filter: FnFilter<T>);
begin
  inherited Create;
  _iterable := A_iterable;
  _filter := A_filter;
end;

function CfIterable<T>.GetEnumerator(): IIterator<T>;
begin
  Result := CfIterator<T>.Create( //
    _iterable.GetEnumerator(), //
    _filter //
  );
end;

constructor CfIterator<T>.Create(const A_iterator: IIterator<T>; const A_filter: FnFilter<T>);
begin
  inherited Create;
  _iterator := A_iterator;
  _filter := A_filter;
end;

function CfIterator<T>.getCurrent(): T;
begin
  Exit(_value);
end;

function CfIterator<T>.MoveNext(): Boolean;
begin
  while _iterator.MoveNext() do
  begin
    _value := _iterator.Current;
    if _filter(_value) then
      Exit(True);
  end;
  Exit(False);
end;

end.

