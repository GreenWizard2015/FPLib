unit FP.Internals.uMapped;

interface

uses
  FP.uIterable;

type
  CMapped<T, R> = class(TInterfacedObject, IIterable<R>)
  strict private
    _map: FnMap<T, R>;
    _ittr: IIterable<T>;
    function GetEnumerator(): IIterator<R>;
  public
    constructor Create(const A_ittr: IIterable<T>; const A_map: FnMap<T, R>);
  end;

  CMappedIterator<T, R> = class(TInterfacedObject, IIterator<R>)
  strict private
    _map: FnMap<T, R>;
    _ittr: IIterator<T>;
    function getCurrent(): R;
    function MoveNext(): Boolean;
  public
    constructor Create(const A_ittr: IIterator<T>; const A_map: FnMap<T, R>);
  end;

implementation

constructor CMapped<T, R>.Create(const A_ittr: IIterable<T>; const A_map: FnMap<T, R>);
begin
  inherited Create;
  _map := A_map;
  _ittr := A_ittr;
end;

function CMapped<T, R>.GetEnumerator(): IIterator<R>;
begin
  Result := CMappedIterator<T, R>.Create( //
    _ittr.GetEnumerator(), _map //
  );
end;

constructor CMappedIterator<T, R>.Create(const A_ittr: IIterator<T>; const A_map: FnMap<T, R>);
begin
  inherited Create;
  _ittr := A_ittr;
  _map := A_map;
end;

function CMappedIterator<T, R>.getCurrent(): R;
begin
  Result := _map(_ittr.Current);
end;

function CMappedIterator<T, R>.MoveNext(): Boolean;
begin
  Result := _ittr.MoveNext();
end;

end.

