/// <summary>
/// Codeunit "GenerateRelationsTable_ANJ" (ID 80808).
/// </summary>
codeunit 80808 GenerateRelationsTable_ANJ
{
    Access = Public;

    /// <summary>
    /// Generate.
    /// </summary>
    internal procedure Generate();
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
    local procedure DoGenerateRelationsTable(IsHandled: Boolean);
    var
    begin
        if IsHandled then
            exit;

        InsertTableLines();
    end;

    /// <summary>
    /// InsertTableLines.
    /// </summary>
    local procedure InsertTableLines();
    var
        Extensions: Record Extensions_ANJ;
    begin
        Extensions.SetLoadFields(AppID);
        Extensions.SetRange(ShowInGraph, true);
        if Extensions.FindSet(false) then
            repeat
                CheckDependencies(Extensions.AppID);
            until Extensions.Next() = 0;
    end;

    /// <summary>
    /// CheckDependencies.
    /// </summary>
    /// <param name="AppId">Guid.</param>
    local procedure CheckDependencies(AppId: Guid);
    var
        DestinationAppID: Guid;
        ModuleDependencyInfoList: List of [ModuleDependencyInfo];
        SingleModuleDependencyInfo: ModuleDependencyInfo;
        AuxModuleInfo: ModuleInfo;
    begin
        if not NavApp.GetModuleInfo(AppId, AuxModuleInfo) then
            exit;

        ModuleDependencyInfoList := AuxModuleInfo.Dependencies;

        foreach SingleModuleDependencyInfo in ModuleDependencyInfoList do begin
            DestinationAppID := SingleModuleDependencyInfo.Id; //TODO: Armar un JSON Para despues parsearlo.
            if CheckDestinationAppIDShowInGraph(DestinationAppID) then
                InsertNewRelation(AppId, DestinationAppID);
        end;
    end;

    /// <summary>
    /// CheckDestinationAppIDShowInGraph.
    /// </summary>
    /// <param name="AppID">Guid.</param>
    /// <returns>Return value of type Boolean.</returns>
    local procedure CheckDestinationAppIDShowInGraph(AppID: Guid): Boolean;
    var
        Extensions: Record Extensions_ANJ;
    begin
        Extensions.SetRange(AppID, AppID);
        Extensions.SetRange(ShowInGraph, true);
        exit(not Extensions.IsEmpty());
    end;

    /// <summary>
    /// InsertNewRelation.
    /// /// </summary>
    /// <returns>Return variable NewRelationsLine of type Integer.</returns>
    local procedure InsertNewRelation(SourceAppID: Guid; DestinationAppID: Guid);
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
    local procedure GetNewRelationsLineNo() NewRelationsLine: Integer;
    var
        Relations: Record Relations_ANJ;
    begin
        NewRelationsLine := 10000;
        if Relations.FindLast() then
            NewRelationsLine += Relations.RelationNo;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateRelationsTable(var Relations: Record Relations_ANJ; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateRelationsTable(var Relations: Record Relations_ANJ);
    begin
    end;
}