/// <summary>
/// Codeunit "CleanTemporaryTables_ANJ" (ID 80811).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80811 CleanTemporaryTables_ANJ
{
    Access = Public;

    internal procedure Clean(ExtensionsTable: Boolean; RelationsTable: Boolean)
    var
        IsHandled: Boolean;
    begin
        OnBeforeClean(ExtensionsTable, RelationsTable, IsHandled);
        DoClean(ExtensionsTable, RelationsTable, IsHandled);
        OnAfterClean(ExtensionsTable, RelationsTable);
    end;

    local procedure DoClean(ExtensionsTable: Boolean; RelationsTable: Boolean; IsHandled: Boolean)
    begin
        if IsHandled then
            exit;

        if ExtensionsTable then
            CleanExtensionsTable();

        if RelationsTable then
            CleanRelationsTable();
    end;

    local procedure CleanExtensionsTable()
    var
        Extensions: Record Extensions_ANJ;
    begin
        if not Extensions.IsEmpty() then
            Extensions.DeleteAll(true);
    end;

    local procedure CleanRelationsTable()
    var
        Relations: Record Relations_ANJ;
    begin
        if not Relations.IsEmpty() then
            Relations.DeleteAll(true);
    end;

    /// <summary>
    /// OnBeforeClean.
    /// </summary>
    /// <param name="ExtensionsTable">VAR Boolean.</param>
    /// <param name="RelationsTable">VAR Boolean.</param>
    /// <param name="IsHandled">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeClean(var ExtensionsTable: Boolean; var RelationsTable: Boolean; var IsHandled: Boolean)
    begin
    end;

    /// <summary>
    /// OnAfterClean.
    /// </summary>
    /// <param name="ExtensionsTable">Boolean.</param>
    /// <param name="RelationsTable">Boolean.</param>
    [IntegrationEvent(false, false)]
    local procedure OnAfterClean(ExtensionsTable: Boolean; RelationsTable: Boolean)
    begin
    end;
}