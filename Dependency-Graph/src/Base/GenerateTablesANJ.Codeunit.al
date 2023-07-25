/// <summary>
/// Codeunit GenerateTables_ANJ (ID 80807)
/// </summary>
codeunit 80807 GenerateTables_ANJ
{
    Access = Public;

    /// <summary>
    /// GenerateTables.
    /// </summary>
    /// <param name="HideDialog">Boolean.</param>
    procedure Generate(HideDialog: Boolean);
    var
        Extensions: Record Extensions_ANJ;
        IsHandled: Boolean;
    begin
        if not Extensions.IsEmpty() then
            if not ConfirmGenerateTables(HideDialog) then
                exit;

        OnBeforeGenerateTables(IsHandled);
        DoGenerateTables(IsHandled);
        OnAfterGenerateTables();
        UpdateSetupTable();
        AcknowledgeGenerateTables(HideDialog);
    end;

    /// <summary>
    /// ConfirmGenerateTables.
    /// </summary>
    /// <param name="HideDialog">Boolean.</param>
    /// <returns>Return value of type Boolean.</returns>
    local procedure ConfirmGenerateTables(HideDialog: Boolean) Answer: Boolean
    begin
        Answer := true;
        if not HideDialog then
            Answer := ConfirmManagement.GetResponseOrDefault(ConfirmQst, Answer);
    end;

    /// <summary>
    /// DoGenerateTables.
    /// </summary>
    /// <param name="IsHandled">Boolean.</param>
    local procedure DoGenerateTables(IsHandled: Boolean);
    begin
        if IsHandled then
            exit;

        DependencyGraphFacade.CleanExtensionsTable();
        DependencyGraphFacade.CleanRelationsTable();

        DependencyGraphFacade.GenerateExtensionsTable();
        DependencyGraphFacade.GenerateRelationTable();
    end;

    /// <summary>
    /// UpdateSetupTable.
    /// </summary>
    local procedure UpdateSetupTable();
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphSetup.GetInstance();
        DependencyGraphSetup.Validate(DateLastGeneration, Today());
        DependencyGraphSetup.Validate(TimeLastGeneration, Time());
        DependencyGraphSetup.Modify(true);
    end;

    /// <summary>
    /// AcknowledgeGenerateTables.
    /// </summary>
    /// <param name="HideDialog">Boolean.</param>
    local procedure AcknowledgeGenerateTables(HideDialog: Boolean);
    begin
        if (not GuiAllowed()) or (HideDialog) then
            exit;

        Message(ProcessFinishMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateTables(var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateTables();
    begin
    end;

    var
        ConfirmManagement: Codeunit "Confirm Management";
        DependencyGraphFacade: Codeunit DependencyGraphFacade_ANJ;
        ConfirmQst: Label 'When generating the tables again, custom data will be deleted, do you want to continue?', comment = 'ESP="Al generar de nuevo las tablas se eliminaran datos personalizados, ¿Desea continuar?"';
        ProcessFinishMsg: Label 'The tables have been updated correctly.', comment = 'ESP="Las tablas se han actualizado correctamente."';
}