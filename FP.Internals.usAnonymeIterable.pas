unit FP.Internals.usAnonymeIterable;

interface

uses
  FP.uIterable;

type
  CsAnonymeIterable<T> = class(TInterfacedObject, IIterable<T>)
  strict private
    _closure: FnAnonymeIterable<T>;
    function GetEnumerator(): IIterator<T>;
  public
    constructor Create(const A_closure: FnAnonymeIterable<T>);
  end;

implementation

constructor CsAnonymeIterable<T>.Create(const A_closure: FnAnonymeIterable<T>);
begin
  inherited Create;
  _closure := A_closure;
end;

function CsAnonymeIterable<T>.GetEnumerator(): IIterator<T>;
begin
  Result := _closure();
end;

end.

