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
  FP.uIterable, FP.uExtras;

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
  seq := Sequence.Filter<Integer>(FPExtras.range(5), acceptAny);
  for i in seq do
    Inc(sum, i);
  // 0 + 1 + 2 + 3 + 4 = 10
  Assert.AreEqual(10, sum);
end;

initialization
  TDUnitX.RegisterTestFixture(CTestFor_Filter);

end.

