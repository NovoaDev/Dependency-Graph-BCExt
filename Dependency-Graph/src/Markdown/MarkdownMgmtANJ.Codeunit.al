/// <summary>
/// Codeunit MarkdownMgmt_ANJ (ID 80809).
/// </summary>
codeunit 80809 MarkdownMgmt_ANJ
{
    Access = Public;

    /// <summary>
    /// GenerateGraph.
    /// </summary>
    internal procedure GenerateGraph()
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
    local procedure DoGenerateMarkdown(IsHandled: Boolean)
    var
        GrapTextBuilder: TextBuilder;
    begin
        if IsHandled then
            exit;

        GrapTextBuilder.AppendLine(Header2Lbl);
        InsertRelationships(GrapTextBuilder);
        InsertAppWithoutRelationships(GrapTextBuilder);

        UpdateSetupTable(GrapTextBuilder.ToText())
    end;

    /// <summary>
    /// InsertRelationships.
    /// </summary>
    /// <param name="GrapTextBuilder">VAR TextBuilder.</param>
    local procedure InsertRelationships(var GrapTextBuilder: TextBuilder)
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
    local procedure GetExtensionText(AppGuid: Guid; var AppIdList: List of [Guid]): Text
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
    local procedure InsertLinkText(var GrapTextBuilder: TextBuilder; LinkText: Text)
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
    local procedure InsertAppWithoutRelationships(var GrapTextBuilder: TextBuilder)
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
    local procedure UpdateSetupTable(MarkDownText: Text)
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
        GraphTextBuilder: TextBuilder;
    begin
        if MarkDownText = '' then
            exit;

        GraphTextBuilder.AppendLine(Header1Lbl);
        GraphTextBuilder.AppendLine(MarkDownText);
        GraphTextBuilder.AppendLine(FooterLbl);

        DependencyGraphSetup.GetInstance();
        DependencyGraphSetup.SetMarkdown(GraphTextBuilder.ToText(), DependencyGraphSetup.FieldNo(Markdown));
        DependencyGraphSetup.SetMarkdown(MarkDownText, DependencyGraphSetup.FieldNo(MarkdownMermaid));
        DependencyGraphSetup.Validate(DateLastGenerationMarkdown, Today());
        DependencyGraphSetup.Validate(TimeLastGenerationMarkdown, Time());
        DependencyGraphSetup.Modify(true);
    end;

    /// <summary>
    /// DownloadMarkdown.
    /// </summary>
    internal procedure DownloadMarkdown()
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

    /// <summary>
    /// GetMarkdown.
    /// </summary>
    /// <param name="FieldNo">Integer.</param>
    /// <returns>Return value of type Text.</returns>
    internal procedure GetMarkdown(FieldNo: Integer): Text
    var
        DependencyGraphSetup: Record DependencyGraphSetup_ANJ;
        AuxInStream: InStream;
        AuxText: Text;
    begin
        DependencyGraphSetup.SetLoadFields(Markdown, MarkdownMermaid);
        DependencyGraphSetup.SetAutoCalcFields(Markdown, MarkdownMermaid);
        DependencyGraphSetup.GetInstance();
        case FieldNo of
            DependencyGraphSetup.FieldNo(Markdown):
                DependencyGraphSetup.Markdown.CreateInStream(AuxInStream);
            DependencyGraphSetup.FieldNo(MarkdownMermaid):
                DependencyGraphSetup.MarkdownMermaid.CreateInStream(AuxInStream);
        end;

        AuxInStream.Read(AuxText);
        exit(AuxText);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGenerateMarkdown(var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGenerateMarkdown()
    begin
    end;

    var
        ArrowLbl: Label ' --> ';
        FileNameLbl: Label 'DependencyGraph.md';
        FooterLbl: Label '```';
        Header1Lbl: Label '```mermaid';
        Header2Lbl: Label 'graph BT';
        LinkArrowLbl: Label ' -- %1 --> ';
}