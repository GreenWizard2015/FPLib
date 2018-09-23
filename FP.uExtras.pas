unit FP.uExtras;

interface

uses
  FP.uIterable;

type
  FPExtras = class sealed
  public
    class function range(maxN: Integer): IIterable<Integer>; overload; static;
    class function range(minN, maxN: Integer): IIterable<Integer>; overload; static;
  end;

implementation

type
  CRangeIterator = class(TInterfacedObject, IIterator<Integer>)
  strict private
    _max: Integer;
    _N: Integer;
  public
    constructor Create(AN, A_max: Integer);
    function getCurrent(): Integer;
    function MoveNext(): Boolean;
  end;

constructor CRangeIterator.Create(AN, A_max: Integer);
begin
  inherited Create();
  _N := AN;
  _max := A_max;
end;

function CRangeIterator.getCurrent(): Integer;
begin
  Result := _N;
  Inc(_N);
end;

function CRangeIterator.MoveNext(): Boolean;
begin
  Result := _N < _max;
end;

class function FPExtras.range(maxN: Integer): IIterable<Integer>;
begin
  Result := range(0, maxN);
end;

class function FPExtras.range(minN, maxN: Integer): IIterable<Integer>;
begin
  Result := Sequence.Of_<Integer>(
    function(): IIterator<Integer>
    begin
      Result := CRangeIterator.Create(minN, maxN);
    end);
end;

end.

