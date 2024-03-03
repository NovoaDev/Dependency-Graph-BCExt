/// <summary>
/// Codeunit "DataUpgrades_ANJ" (ID 80816).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80816 DataUpgrades_ANJ
{
    Access = Internal;

    /// <summary>
    /// OnGetPerCompanyUpgradeTags.
    /// </summary>
    /// <param name="PerCompanyUpgradeTags">VAR List of [Code[250]].</param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::System.Upgrade."Upgrade Tag", OnGetPerCompanyUpgradeTags, '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]])
    begin
        PerCompanyUpgradeTags.Add(GetUpgradeTagDataUpgrade1());
    end;

    #region Data Upgrade 1 - Upgrade data from previous versions to version 4.15.0.0. - Change reserved ordinal 0 to another one.
    /// <summary>
    /// GetUpgradeTagDataUpgrade1.
    /// </summary>
    /// <returns>Return value of type Code[250].</returns>
    internal procedure GetUpgradeTagDataUpgrade1(): Code[250]
    begin
        exit(DT1IdTok)
    end;

    /// <summary>
    /// RunDataUpgrade1.
    /// </summary>
    internal procedure RunDataUpgrade1()
    begin
        CheckAndUpdateDependencyGraphSetupFillingProcessingTablesEnum();
        CheckAndUpdateExtensionsExtensionScopeEnum();
        CheckAndUpdateDependencyGraphSetupGeometricFigureEnum();
    end;

    /// <summary>
    /// CheckAndUpdateDependencyGraphSetupFillingProcessingTablesEnum.
    /// </summary>
    local procedure CheckAndUpdateDependencyGraphSetupFillingProcessingTablesEnum()
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphSetup.GetInstance();
        if DependencyGraphSetup.FillingProcessingTables.AsInteger() <> 0 then
            exit;

        DependencyGraphSetup.Validate(FillingProcessingTables, DependencyGraphSetup.FillingProcessingTables::WSAndModuleDependencyInfo);
        DependencyGraphSetup.Modify(false);
    end;

    /// <summary>
    /// CheckAndUpdateExtensionsExtensionScopeEnum.
    /// </summary>
    local procedure CheckAndUpdateExtensionsExtensionScopeEnum()
    var
        Extensions: Record Extensions_ANJ;
    begin
        if Extensions.IsEmpty() then
            exit;

        if Extensions.FindSet(true) then
            repeat
                if Extensions.PublishedAs.AsInteger() = 0 then begin
                    Extensions.Validate(PublishedAs, Extensions.PublishedAs::PTE);
                    Extensions.Modify(false)
                end;
            until Extensions.Next() = 0;
    end;

    /// <summary>
    /// CheckAndUpdateDependencyGraphSetupGeometricFigureEnum.
    /// </summary>
    local procedure CheckAndUpdateDependencyGraphSetupGeometricFigureEnum()
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        DependencyGraphSetup.GetInstance();
        if (DependencyGraphSetup.ScopePTEFigure.AsInteger() <> 0) and
            (DependencyGraphSetup.ScopeGlobalFigure.AsInteger() <> 0) and
            (DependencyGraphSetup.ScopeDevFigure.AsInteger() <> 0) then
            exit;

        if DependencyGraphSetup.ScopePTEFigure.AsInteger() = 0 then
            DependencyGraphSetup.Validate(ScopePTEFigure, DependencyGraphSetup.ScopePTEFigure::SquareRectangle);

        if DependencyGraphSetup.ScopeGlobalFigure.AsInteger() = 0 then
            DependencyGraphSetup.Validate(ScopeGlobalFigure, DependencyGraphSetup.ScopeGlobalFigure::SquareRectangle);

        if DependencyGraphSetup.ScopeDevFigure.AsInteger() = 0 then
            DependencyGraphSetup.Validate(ScopeDevFigure, DependencyGraphSetup.ScopeDevFigure::SquareRectangle);
        DependencyGraphSetup.Modify(false);
    end;
    #endregion

    var
        DT1IdTok: Label 'ANJ-41500-FixEnumsZeroOrdinal-20240303', Locked = true;
}