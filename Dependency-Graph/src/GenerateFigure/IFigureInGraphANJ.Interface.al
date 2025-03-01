/// <summary>
/// Interface "FigureInGraph_ANJ."
/// </summary>
namespace ANJ.Tools.Graph;
interface IFigureInGraph_ANJ
{
    Access = Public;

    /// <summary>
    /// GenerateFigureText.
    /// </summary>
    /// <param name="Identity">Text.</param>
    /// <param name="Content">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GenerateFigureText(Identity: Text; Content: Text): Text
}