/// <summary>
/// Codeunit ExpectedValues_ANJ (ID 99994).
/// </summary>
namespace ANJ.Tools.Graph;
codeunit 99994 ExpectedValues_ANJ
{
    Access = Internal;

    /// <summary>
    /// GetExpectedMarkdownText.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetExpectedMarkdownText(): Text
    var
        ExpectedValueTextBuilder: TextBuilder;
    begin
        ExpectedValueTextBuilder.AppendLine(Header1Lbl);
        ExpectedValueTextBuilder.AppendLine(Header2Lbl);
        ExpectedValueTextBuilder.AppendLine(ExpectedRelationLbl);
        ExpectedValueTextBuilder.AppendLine();
        ExpectedValueTextBuilder.AppendLine(FooterLbl);

        exit(ExpectedValueTextBuilder.ToText());
    end;

    /// <summary>
    /// GetExpectedMarkdownMermaidText.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetExpectedMarkdownMermaidText(): Text
    var
        ExpectedValueTextBuilder: TextBuilder;
    begin
        ExpectedValueTextBuilder.AppendLine(Header2Lbl);
        ExpectedValueTextBuilder.AppendLine(ExpectedRelationLbl);

        exit(ExpectedValueTextBuilder.ToText());
    end;

    var
        ExpectedRelationLbl: Label 'E1[Take Order Sample] --> E2[DependencyGraph]';
        FooterLbl: Label '```';
        Header1Lbl: Label '```mermaid';
        Header2Lbl: Label 'graph BT';
}