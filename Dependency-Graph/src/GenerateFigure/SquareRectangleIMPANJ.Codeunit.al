/// <summary>
/// Codeunit "SquareRectangleIMP_ANJ" (ID 80800) implements Interface FigureInGraph_ANJ.
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80800 SquareRectangleIMP_ANJ implements IFigureInGraph_ANJ
{
    Access = Internal;

    /// <summary>
    /// GenerateFigureText.
    /// </summary>
    /// <param name="Identity">Text.</param>
    /// <param name="Content">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GenerateFigureText(Identity: Text; Content: Text): Text
    begin
        exit(StrSubstNo(FigureLbl, Identity, Content));
    end;

    var
        FigureLbl: Label '%1[%2]', Comment = 'Placeholder %1 represents the Identity, and Placeholder %2 represents the Content.';
}