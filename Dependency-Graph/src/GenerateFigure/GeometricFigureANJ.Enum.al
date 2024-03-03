/// <summary>
/// Enum GeometricFigure_ANJ (ID 80800) implements Interface FigureInGraph_ANJ.
/// </summary>
namespace ANJ.Tools.Graph;
enum 80800 GeometricFigure_ANJ implements FigureInGraph_ANJ
{
    Access = Public;
    Caption = 'Geometric Figure';
    DefaultImplementation = FigureInGraph_ANJ = DefaultFigureIMP_ANJ;
    Extensible = true;
    UnknownValueImplementation = FigureInGraph_ANJ = DefaultFigureIMP_ANJ;

    value(1; Circle)
    {
        Caption = 'Circle';
        Implementation = FigureInGraph_ANJ = CircleIMP_ANJ;
    }
    value(2; RoundRectangle)
    {
        Caption = 'Round Rectangle';
        Implementation = FigureInGraph_ANJ = RoundRectangleIMP_ANJ;
    }
    value(3; Rhombus)
    {
        Caption = 'Rhombus';
        Implementation = FigureInGraph_ANJ = RhombusIMP_ANJ;
    }
    value(4; SquareRectangle)
    {
        Caption = 'Square/Rectangle';
        Implementation = FigureInGraph_ANJ = SquareRectangleIMP_ANJ;
    }
}