/// <summary>
/// Interface FillingProcessingTables_ANJ.
/// </summary>
interface FillingProcessingTables_ANJ
{
    Access = Public;

    /// <summary>
    /// GetExtensions.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetExtensions(): Text;

    /// <summary>
    /// GetRelations.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetRelations() JsonText: Text;
}