/// <summary>
/// Codeunit "DefaultFigureIMP_ANJ" (ID 80814) implements Interface FigureInGraph_ANJ.
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80814 DefaultFigureIMP_ANJ implements IFigureInGraph_ANJ
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
        Error(ImpErr);
    end;

    var
        ImpErr: Label 'An implementation should be specified to the related figure.';
}