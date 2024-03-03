/// <summary>
/// Codeunit "GenerateRelationsTable_ANJ" (ID 80808).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80808 GenerateRelationsTable_ANJ
{
    Access = Public;

    /// <summary>
    /// Generate.
    /// </summary>
    internal procedure Generate()
    var
        Relations: Record Relations_ANJ;
        IsHandled: Boolean;
    begin
        OnBeforeGenerateRelationsTable(Relations, IsHandled);
        DoGenerateRelationsTable(IsHandled);
        OnAfterGenerateRelationsTable(Relations);
    end;

    /// <summary>
    /// DoGenerateRelationsTable.
    /// </summary>
    /// <param name="IsHandled">Boolean.</param>
    local procedure DoGenerateRelationsTable(IsHandled: Boolean)
    var
        FillingProcessingTables: Interface FillingProcessingTables_ANJ;
        ResponseText: Text;
    begin
        if IsHandled then
            exit;

        DependencyGraphFacade.GetInterfaceFillProcessingTables(FillingProcessingTables);
        ResponseText := FillingProcessingTables.GetRelations();
        ProcessRelationsAndInsertLines(ResponseText);
    end;

    /// <summary>
    /// ProcessRelationsAndInsertLines.
    /// </summary>
    /// <param name="ResponseText">Text.</param>
    local procedure ProcessRelationsAndInsertLines(ResponseText: Text)
    var
        RelationsArry: JsonArray;
        RelationJsonToken: JsonToken;
        JsonText: Text;
    begin
        if ResponseText = '' then
            exit;

        if not RelationsArry.ReadFrom(ResponseText) then
            exit;

        foreach RelationJsonToken in RelationsArry do begin
            RelationJsonToken.WriteTo(JsonText);
            InsertNewRelation(JSONMethods.GetJsonValue(SourceAppIDLbl, JsonText), JSONMethods.GetJsonValue(DestinationAppIDLbl, JsonText));
        end;
    end;

    /// <summary>
    /// InsertNewRelation
    /// </summary>
    /// <param name="SourceAppID"></param>
    /// <param name="DestinationAppID"></param>
    local procedure InsertNewRelation(SourceAppID: Guid; DestinationAppID: Guid)
    var
        Relations: Record Relations_ANJ;
    begin
        Clear(Relations);
        Relations.Init();
        Relations.Validate(RelationNo, GetNewRelationsLineNo());
        Relations.Insert(true);
        Relations.Validate(SourceAppID, SourceAppID);
        Relations.Validate(DestinationAppID, DestinationAppID);
        Relations.Validate(ShowInGraph, true);
        Relations.Modify(true);
    end;

    /// <summary>
    /// GetNewRelationsLineNo.
    /// /// </summary>
    /// <returns>Return variable NewRelationsLine of type Integer.</returns>
    local procedure GetNewRelationsLineNo() NewRelationsLine: Integer
    var
        Relations: Record Relations_ANJ;
    begin
        NewRelationsLine := 10000;
        if Relations.FindLast() then
            NewRelationsLine += Relations.RelationNo;
    end;

    /// <summary>
    /// OnBeforeGenerateRelationsTable.
    /// </summary>
    /// <param name="Relations">VAR Record Relations_ANJ.</param>
    /// <param name="IsHandled">VAR Boolean.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateRelationsTable(var Relations: Record Relations_ANJ; var IsHandled: Boolean)
    begin
    end;

    /// <summary>
    /// OnAfterGenerateRelationsTable.
    /// </summary>
    /// <param name="Relations">VAR Record Relations_ANJ.</param>

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateRelationsTable(var Relations: Record Relations_ANJ)
    begin
    end;

    var
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
        JSONMethods: Codeunit JSONMethods_ANJ;
        DestinationAppIDLbl: Label 'DestinationAppID';
        SourceAppIDLbl: Label 'SourceAppID';
}