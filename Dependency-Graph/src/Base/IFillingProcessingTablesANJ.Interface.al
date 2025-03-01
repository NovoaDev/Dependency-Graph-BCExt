/// <summary>
/// Interface "FillingProcessingTables_ANJ."
/// </summary>
namespace ANJ.Tools.Graph;
interface IFillingProcessingTables_ANJ
{
    Access = Public;

    /// <summary>
    /// GetExtensions.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetExtensions(): Text

    /// <summary>
    /// GetRelations.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetRelations() JsonText: Text
}