/// <summary>
/// Codeunit "NumberSequenceMgmt_ANJ" (ID 80806).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 80806 NumberSequenceMgmt_ANJ
{
    Access = Public;

    /// <summary>
    /// Initialize
    /// </summary>
    internal procedure Initialize()
    begin
        if NumberSequence.Exists(NumberSequenceNameTok, true) then
            NumberSequence.Delete(NumberSequenceNameTok, true);

        NumberSequence.Insert(NumberSequenceNameTok, 0001, 1, true);
    end;

    /// <summary>
    /// GetNextNo.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    internal procedure GetNextNo() NewIdentity: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeBuildIdentity(IsHandled);
        NewIdentity := DoBuildIdentity(IsHandled);
        OnAfterBuildIdentity(NewIdentity);
    end;

    /// <summary>
    /// DoBuildIdentity.
    /// </summary>
    /// <param name="IsHandled">Boolean.</param>
    /// <returns>Return value of type Text.</returns>
    local procedure DoBuildIdentity(IsHandled: Boolean): Text
    var
        NewIdentity: Text;
    begin
        if IsHandled then
            exit;

        NewIdentity := StrSubstNo(IdentityLbl, Format(NumberSequence.Next(NumberSequenceNameTok, true)));
        exit(NewIdentity);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeBuildIdentity(var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterBuildIdentity(var NewIdentity: Text)
    begin
    end;

    var
        IdentityLbl: Label 'E%1', Comment = 'Placeholder %1 for the identity label';
        NumberSequenceNameTok: Label 'DependencyGraph', Locked = true;
}