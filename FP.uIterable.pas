unit FP.uIterable;

interface

uses
  System.Generics.Collections;

type
  IIterator<T> = interface
    function getCurrent(): T;
    function MoveNext(): Boolean;
    property Current: T read getCurrent;
  end;

  IIterable<T> = interface
    function GetEnumerator(): IIterator<T>;
  end;

  IIterableByIndex<T> = interface(IIterable<T>)
    function Count(): Integer;
    function Item(const ind: Integer): T;
  end;

//////////////////////////////////////
  FnMap<T, R> = reference to function(const Val: T): R;

  FnFilter<T> = reference to function(const Val: T): Boolean;

  FnAnonymeIterable<T> = reference to function(): IIterator<T>;

  FnGenerator<T> = reference to function(out Val: T): Boolean;

  Sequence = class sealed
  public
    class function Of_<T>(const A: TEnumerable<T>): IIterable<T>; overload; static;
    class function Of_<T>(const A: T): IIterable<T>; overload; static;
    class function Of_<T>(const A, B: T): IIterable<T>; overload; static;
    class function Of_<T>(const A, B, C: T): IIterable<T>; overload; static;
    class function Of_<T>(const values: array of T): IIterable<T>; overload; static;
    class function Of_<T>(const F: FnAnonymeIterable<T>): IIterable<T>; overload; static;
    // ugly, but ok for now
    class function Of_<T>(const F: FnGenerator<T>): IIterable<T>; overload; static;
    /////////////////////////////////////////
    class function Empty<T>(): IIterable<T>; overload; static;
    /////////////////////////////////////////
    class function Concat<T>(const A, B: IIterable<T>): IIterable<T>; overload; static;
    class function Flatten<T>(const ittr: IIterable<IIterable<T>>): IIterable<T>; overload; static;
    class function Filter<T>(const ittr: IIterable<T>; const F: FnFilter<T>): IIterable<T>; overload; static;
    class function Map<T, R>(const ittr: IIterable<T>; const F: FnMap<T, R>): IIterable<R>; overload; static;
    class function Limit<T>(const ittr: IIterable<T>; const N: Integer): IIterable<T>; overload; static;
  end;

implementation

uses
  FP.Internals.usArray, FP.Internals.usFlatten, FP.Internals.uEmpty, FP.Internals.usAnonymeIterable,
  FP.Internals.uFiltered, FP.Internals.uMapped, FP.Internals.uCroppedBy,
  FP.Internals.uGenerated;

class function Sequence.Of_<T>(const A: T): IIterable<T>;
begin
  Exit(Of_<T>([A]));
end;

class function Sequence.Of_<T>(const A, B: T): IIterable<T>;
begin
  Exit(Of_<T>([A, B]));
end;

class function Sequence.Of_<T>(const A, B, C: T): IIterable<T>;
begin
  Exit(Of_<T>([A, B, C]));
end;

class function Sequence.Of_<T>(const values: array of T): IIterable<T>;
begin
  Exit(CsArray<T>.Create(values));
end;

class function Sequence.Of_<T>(const F: FnAnonymeIterable<T>): IIterable<T>;
begin
  Exit(CsAnonymeIterable<T>.Create(F));
end;

class function Sequence.Concat<T>(const A, B: IIterable<T>): IIterable<T>;
begin
  Exit(Flatten<T>(Of_<IIterable<T>>(A, B)));
end;

class function Sequence.Flatten<T>(const ittr: IIterable<IIterable<T>>): IIterable<T>;
begin
  Exit(CsFlatten<T>.Create(ittr));
end;

class function Sequence.Empty<T>(): IIterable<T>;
begin
  Exit(CEmptyIterable<T>.Create());
end;

class function Sequence.Filter<T>(const ittr: IIterable<T>; const F: FnFilter<T>): IIterable<T>;
begin
  Exit(CfIterable<T>.Create(ittr, F));
end;

class function Sequence.Limit<T>(const ittr: IIterable<T>; const N: Integer): IIterable<T>;
begin
  Result := CCroppedBy<T>.Create(ittr, N);
end;

class function Sequence.Map<T, R>(const ittr: IIterable<T>; const F: FnMap<T, R>): IIterable<R>;
begin
  Result := CMapped<T, R>.Create(ittr, F);
end;

class function Sequence.Of_<T>(const A: TEnumerable<T>): IIterable<T>;
begin
  Result := Of_<T>(A.ToArray());
end;

class function Sequence.Of_<T>(const F: FnGenerator<T>): IIterable<T>;
begin
  Result := CGenerated<T>.Create(F);
end;

end.

