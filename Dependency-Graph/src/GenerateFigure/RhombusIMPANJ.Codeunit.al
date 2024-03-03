/// <summary>
/// Codeunit "RhombusIMP_ANJ" (ID 80803) implements Interface FigureInGraph_ANJ.
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80803 RhombusIMP_ANJ implements FigureInGraph_ANJ
{
    Access = Internal;

    /// <summary>
    /// GenerateFigureText.
    /// </summary>
    /// <param name="Identity">Text.</param>
    /// <param name="Content">Text.</param>
    /// <returns>Return value of type Text.</returns>
    internal procedure GenerateFigureText(Identity: Text; Content: Text): Text
    begin
        exit(StrSubstNo(FigureLbl, Identity, Content));
    end;

    var
        FigureLbl: Label '%1{%2}';
}