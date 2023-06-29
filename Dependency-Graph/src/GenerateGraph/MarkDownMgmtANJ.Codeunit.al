/// <summary>
/// Codeunit MarkdownMgmt_ANJ (ID 80809).
/// </summary>
codeunit 80809 MarkdownMgmt_ANJ
{
    Access = Public;

    /// <summary>
    /// GenerateGraph.
    /// </summary>
    internal procedure GenerateGraph();
    var
        IsHandled: Boolean;
    begin
        OnBeforeGenerateMarkdown(IsHandled);
        DoGenerateMarkdown(IsHandled);
        OnAfterGenerateMarkdown();
    end;

    /// <summary>
    /// DoGenerateMarkdown.
    /// </summary>
    /// <param name="IsHandled">Boolean.</param>
    local procedure DoGenerateMarkdown(IsHandled: Boolean);
    var
        myText: Text;
        GrapTextBuilder: TextBuilder;
    begin
        if IsHandled then
            exit;

        GrapTextBuilder.AppendLine(Header1Lbl);
        GrapTextBuilder.AppendLine(Header2Lbl);

        InsertRelationships(GrapTextBuilder);
        InsertAppWithoutRelationships(GrapTextBuilder);

        GrapTextBuilder.AppendLine();
        GrapTextBuilder.AppendLine(FooterLbl);
        myText := GrapTextBuilder.ToText();
        if UpdateSetupTable(GrapTextBuilder.ToText()) then
            Acknowledge();
    end;

    /// <summary>
    /// InsertRelationships.
    /// </summary>
    /// <param name="GrapTextBuilder">VAR TextBuilder.</param>
    local procedure InsertRelationships(var GrapTextBuilder: TextBuilder);
    var
        Relations: Record Relations_ANJ;
        AppIdList: List of [Guid];
    begin
        Relations.SetLoadFields(SourceAppID, DestinationAppID, LinkText);
        Relations.SetRange(ShowInGraph, true);
        if Relations.FindSet(false) then
            repeat
                GrapTextBuilder.Append(GetExtensionText(Relations.SourceAppID, AppIdList));
                InsertLinkText(GrapTextBuilder, Relations.LinkText);
                GrapTextBuilder.AppendLine(GetExtensionText(Relations.DestinationAppID, AppIdList));
            until Relations.Next() = 0;
    end;

    /// <summary>
    /// GetExtensionText.
    /// </summary>
    /// <param name="AppGuid">Guid.</param>
    /// <param name="AppIdList">VAR List of [Guid].</param>
    /// <returns>Return value of type Text.</returns>
    local procedure GetExtensionText(AppGuid: Guid; var AppIdList: List of [Guid]): Text;
    var
        Extensions: Record Extensions_ANJ;
    begin

        Extensions.SetLoadFields(Identity, Figure);
        if not Extensions.Get(AppGuid) then
            exit;

        if AppIdList.Contains(AppGuid) then
            exit(Extensions.Identity);

        AppIdList.Add(AppGuid);
        exit(Extensions.Figure);
    end;

    /// <summary>
    /// InsertLinkText.
    /// </summary>
    /// <param name="GrapTextBuilder">VAR TextBuilder.</param>
    /// <param name="LinkText">Text.</param>
    local procedure InsertLinkText(var GrapTextBuilder: TextBuilder; LinkText: Text);
    begin
        if LinkText = '' then begin
            GrapTextBuilder.Append(ArrowLbl);
            exit;
        end;

        GrapTextBuilder.Append(StrSubstNo(LinkArrowLbl, LinkText));
    end;
    /// <summary>
    /// InsertAppWithoutRelationships.
    /// </summary>
    /// <param name="GrapTextBuilder">VAR TextBuilder.</param>
    local procedure InsertAppWithoutRelationships(var GrapTextBuilder: TextBuilder);
    var
        Extensions: Record Extensions_ANJ;
    begin
        Extensions.SetRange(ShowInGraph, true);
        Extensions.SetRange(HasStartRelationships, false);
        Extensions.SetRange(HasRelationships, false);
        if Extensions.FindSet(false) then
            repeat
                GrapTextBuilder.AppendLine(Extensions.Figure);
            until Extensions.Next() = 0;
    end;

    /// <summary>
    /// UpdateSetupTable.
    /// </summary>
    /// <param name="MarkDownText">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    local procedure UpdateSetupTable(MarkDownText: Text): Boolean;
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
    begin
        if MarkDownText = '' then
            exit;

        DependencyGraphSetup.GetInstance();
        DependencyGraphSetup.SetMarkdown(MarkDownText);
        DependencyGraphSetup.Validate(DateLastGenerationMarkdown, Today());
        DependencyGraphSetup.Validate(TimeLastGenerationMarkdown, Time());
        exit(DependencyGraphSetup.Modify(true));
    end;

    /// <summary>
    /// Acknowledge.
    /// </summary>
    local procedure Acknowledge();
    begin
        if not GuiAllowed() then
            exit;

        Message(ProcessFinishMsg);
    end;

    /// <summary>
    /// DownloadMarkdown.
    /// </summary>
    internal procedure DownloadMarkdown();
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
        AuxInStream: InStream;
        FileName: Text;
    begin
        DependencyGraphSetup.SetLoadFields(Markdown);
        DependencyGraphSetup.SetAutoCalcFields(Markdown);
        DependencyGraphSetup.GetInstance();
        DependencyGraphSetup.Markdown.CreateInStream(AuxInStream);

        if not DependencyGraphSetup.Markdown.HasValue() then
            exit;

        FileName := FileNameLbl;
        DownloadFromStream(AuxInStream, '', '', '', FileName);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateMarkdown(var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateMarkdown();
    begin
    end;

    var
        ArrowLbl: Label ' --> ';
        FileNameLbl: Label 'DependencyGraph.md';
        FooterLbl: Label '```';
        Header1Lbl: Label '```mermaid';
        Header2Lbl: Label 'graph LR';
        LinkArrowLbl: Label ' -- %1 --> ';
        ProcessFinishMsg: Label 'Markdown Created Correctly', comment = 'ESP="Markdown creado correctamente"';
}