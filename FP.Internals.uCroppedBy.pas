unit FP.Internals.uCroppedBy;

interface

uses
  FP.uIterable;

type
  CCroppedBy<T> = class(TInterfacedObject, IIterable<T>)
  strict private
    _ittr: IIterable<T>;
    _limit: Integer;
  public
    constructor Create(const A_ittr: IIterable<T>; const A_limit: Integer);
    function GetEnumerator(): IIterator<T>;
  end;

  CCroppedIterator<T> = class(TInterfacedObject, IIterator<T>)
  strict private
    _ittr: IIterator<T>;
    _leftN: Integer;
  public
    constructor Create(const A_ittr: IIterator<T>; const A_Limit: Integer);
    function getCurrent(): T;
    function MoveNext(): Boolean;
  end;

implementation

constructor CCroppedBy<T>.Create(const A_ittr: IIterable<T>; const A_limit: Integer);
begin
  inherited Create;
  _ittr := A_ittr;
  _limit := A_limit;
end;

function CCroppedBy<T>.GetEnumerator(): IIterator<T>;
begin
  Result := CCroppedIterator<T>.Create( //
    _ittr.GetEnumerator(), _limit //
  );
end;

constructor CCroppedIterator<T>.Create(const A_ittr: IIterator<T>; const A_Limit: Integer);
begin
  inherited Create;
  _ittr := A_ittr;
  _leftN := A_Limit;
end;

function CCroppedIterator<T>.getCurrent(): T;
begin
  Result := _ittr.Current;
end;

function CCroppedIterator<T>.MoveNext(): Boolean;
begin
  Result := 0 < _leftN;
  if Result then
    Result := _ittr.MoveNext();
  if Result then
    Dec(_leftN);
end;

end.

