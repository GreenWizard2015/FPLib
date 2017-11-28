unit FP.Internals.uGenerated;

interface

uses
  FP.uIterable;

type
  CGenerated<T> = class(TInterfacedObject, IIterable<T>)
  strict private
    _generator: FnGenerator<T>;
  public
    constructor Create(const A_generator: FnGenerator<T>);
    function GetEnumerator(): IIterator<T>;
  end;

  CGeneratedIterator<T> = class(TInterfacedObject, IIterator<T>)
  strict private
    _generator: FnGenerator<T>;
    _current: T;
    function getCurrent(): T;
    function MoveNext(): Boolean;
  public
    constructor Create(const A_generator: FnGenerator<T>);
  end;

implementation

constructor CGenerated<T>.Create(const A_generator: FnGenerator<T>);
begin
  inherited Create();
  _generator := A_generator;
end;

function CGenerated<T>.GetEnumerator(): IIterator<T>;
begin
  Result := CGeneratedIterator<T>.Create(_generator);
  _generator := nil;
end;

constructor CGeneratedIterator<T>.Create(const A_generator: FnGenerator<T>);
begin
  inherited Create();
  _generator := A_generator;
end;

function CGeneratedIterator<T>.getCurrent(): T;
begin
  Exit(_current);
end;

function CGeneratedIterator<T>.MoveNext(): Boolean;
begin
  Exit(_generator(_current));
end;

end.

