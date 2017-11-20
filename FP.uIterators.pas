unit FP.uIterators;

interface

uses
  FP.uIterable;

type
  IIterableByIndex<T> = interface
    function Count(): Integer;
    function Item(const ind: Integer): T;
  end;

  Iterators = class sealed
  public
    class function From<T>(const IBI: IIterableByIndex<T>): IIterator<T>; overload; static;
  end;

implementation

uses
  FP.Internals.uIndexedIterator;

class function Iterators.From<T>(const IBI: IIterableByIndex<T>): IIterator<T>;
begin
  Result := CIndexedIterator<T>.Create(IBI);
end;

end.

