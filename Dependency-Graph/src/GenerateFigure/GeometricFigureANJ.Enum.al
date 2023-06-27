/// <summary>
/// Enum GeometricFigure_ANJ (ID 80800) implements Interface FigureInGraph_ANJ.
/// </summary>
enum 80800 GeometricFigure_ANJ implements FigureInGraph_ANJ
{
    Caption = 'Geometric Figure', Comment = 'ESP="Figura Geométrica"';
    Extensible = true;

    value(0; SquareRectangle)
    {
        Caption = 'Square/Rectangle', Comment = 'ESP="Cuadrado/Rectángulo"';
        Implementation = FigureInGraph_ANJ = SquareRectangleIMP_ANJ;
    }
    value(1; Circle)
    {
        Caption = 'Circle', Comment = 'ESP="Círculo"';
        Implementation = FigureInGraph_ANJ = CircleIMP_ANJ;
    }
    value(2; RoundRectangle)
    {
        Caption = 'Round Rectangle', Comment = 'ESP="Rectángulo Redondeado"';
        Implementation = FigureInGraph_ANJ = RoundRectangleIMP_ANJ;
    }
    value(3; Rhombus)
    {
        Caption = 'Rhombus', Comment = 'ESP="Rombo"';
        Implementation = FigureInGraph_ANJ = RhombusIMP_ANJ;
    }
}