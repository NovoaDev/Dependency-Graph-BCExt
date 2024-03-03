/// <summary>
/// Codeunit "UpgradeCodeunit_ANJ" (ID 80817).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80817 UpgradeCodeunit_ANJ
{
    Access = Internal;
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        DataUpgrade();
    end;

    /// <summary>
    /// DataUpgrade.
    /// </summary>
    local procedure DataUpgrade()
    var
        DataUpgrades: Codeunit DataUpgrades_ANJ;
        UpgradeTag: Codeunit System.Upgrade."Upgrade Tag";
    begin
        if not UpgradeTag.HasUpgradeTag(DataUpgrades.GetUpgradeTagDataUpgrade1()) then begin
            DataUpgrades.RunDataUpgrade1();
            UpgradeTag.SetUpgradeTag(DataUpgrades.GetUpgradeTagDataUpgrade1());
        end;
    end;
}