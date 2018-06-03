unit Test.Filter;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  CTestFor_Filter = class
  public
    [Test]
    procedure touchStreamOnlyOnce();
  end;

implementation

uses
  FP.uIterable;

type
  CTestIterator = class(TInterfacedObject, IIterator<Integer>)
  strict private
    _N: Integer;
  public
    constructor Create();
    function getCurrent(): Integer;
    function MoveNext(): Boolean;
  end;

constructor CTestIterator.Create();
begin
  inherited Create();
  _N := 0;
end;

function CTestIterator.getCurrent(): Integer;
begin
  Result := _N;
  Inc(_N);
end;

function CTestIterator.MoveNext(): Boolean;
begin
  Result := _N < 5;
end;

/////////////////////////////////////////

function testSequence(): IIterable<Integer>;
begin
  Result := Sequence.Of_<Integer>(
    function(): IIterator<Integer>
    begin
      Result := CTestIterator.Create();
    end);
end;

function acceptAny(const val: Integer): Boolean;
begin
  Result := True;
end;

procedure CTestFor_Filter.touchStreamOnlyOnce();
var
  i, sum: Integer;
  seq: IIterable<Integer>;
begin
  sum := 0;
  seq := Sequence.Filter<Integer>(testSequence(), acceptAny);
  for i in seq do
    Inc(sum, i);
  // 0 + 1 + 2 + 3 + 4 = 10
  Assert.AreEqual(10, sum);
end;

initialization
  TDUnitX.RegisterTestFixture(CTestFor_Filter);

end.

