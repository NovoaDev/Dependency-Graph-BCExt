/// <summary>
/// Enum GeometricFigure_ANJ (ID 80800) implements Interface FigureInGraph_ANJ.
/// </summary>
namespace ANJ.Tools.Graph;
enum 80800 GeometricFigure_ANJ implements IFigureInGraph_ANJ
{
    Access = Public;
    Caption = 'Geometric Figure';
    DefaultImplementation = IFigureInGraph_ANJ = DefaultFigureIMP_ANJ;
    Extensible = true;
    UnknownValueImplementation = IFigureInGraph_ANJ = DefaultFigureIMP_ANJ;

    value(1; Circle)
    {
        Caption = 'Circle';
        Implementation = IFigureInGraph_ANJ = CircleIMP_ANJ;
    }
    value(2; RoundRectangle)
    {
        Caption = 'Round Rectangle';
        Implementation = IFigureInGraph_ANJ = RoundRectangleIMP_ANJ;
    }
    value(3; Rhombus)
    {
        Caption = 'Rhombus';
        Implementation = IFigureInGraph_ANJ = RhombusIMP_ANJ;
    }
    value(4; SquareRectangle)
    {
        Caption = 'Square/Rectangle';
        Implementation = IFigureInGraph_ANJ = SquareRectangleIMP_ANJ;
    }
}