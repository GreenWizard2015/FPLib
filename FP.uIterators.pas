unit FP.uIterators;

interface

uses
  FP.uIterable;

type
  Iterators = class sealed
  public
    class function ittr<T>(const IBI: IIterableByIndex<T>): IIterator<T>; overload; static;
  end;

implementation

uses
  FP.Internals.uIndexedIterator;

class function Iterators.ittr<T>(const IBI: IIterableByIndex<T>): IIterator<T>;
begin
  Result := CIndexedIterator<T>.Create(IBI);
end;

end.

