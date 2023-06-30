/// <summary>
/// Codeunit "NumberSequenceMgmt_ANJ" (ID 80806).
/// </summary>
codeunit 80806 NumberSequenceMgmt_ANJ
{
    Access = Public;

    /// <summary>
    /// GetNextNo.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    internal procedure GetNextNo() NewIdentity: Text;
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
    local procedure DoBuildIdentity(IsHandled: Boolean): Text;
    var
        NewIdentity: Text;
    begin
        if IsHandled then
            exit;

        NewIdentity := StrSubstNo(IdentityLbl, Format(NumberSequence.Next(NumberSequenceNameLbl, true)));
        exit(NewIdentity);
    end;

    /// <summary>
    /// Initialize
    /// </summary>
    internal procedure Initialize();
    begin
        if NumberSequence.Exists(NumberSequenceNameLbl, true) then
            NumberSequence.Delete(NumberSequenceNameLbl, true);

        NumberSequence.Insert(NumberSequenceNameLbl, 0001, 1, true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeBuildIdentity(var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterBuildIdentity(var NewIdentity: Text);
    begin
    end;

    var
        IdentityLbl: Label 'E%1';
        NumberSequenceNameLbl: Label 'DependencyGraph';
}