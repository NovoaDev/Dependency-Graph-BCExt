/// <summary>
/// Codeunit "SquareRectangleIMP_ANJ" (ID 80800) implements Interface FigureInGraph_ANJ.
/// </summary>
codeunit 80800 SquareRectangleIMP_ANJ implements FigureInGraph_ANJ
{
    Access = Internal;

    /// <summary>
    /// GenerateFigureText.
    /// </summary>
    /// <param name="Identity">Text.</param>
    /// <param name="Content">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GenerateFigureText(Identity: Text; Content: Text): Text;
    var
        FigureLbl: Label '%1[%2]', comment = 'ESP="%1[%2]"';
    begin
        exit(StrSubstNo(FigureLbl, Identity, Content));
    end;
}