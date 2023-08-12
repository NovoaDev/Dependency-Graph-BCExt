/// <summary>
/// Page MarkdownFactbox_ANJ (ID 80805).
/// </summary>
page 80805 MarkdownFactbox_ANJ
{
    ApplicationArea = All;
    Caption = 'Markdown Text';
    Editable = false;
    PageType = CardPart;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            field(MarkdownText; MarkdownText)
            {
                Editable = false;
                MultiLine = true;
                ShowCaption = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DownloadMarkdown)
            {
                ApplicationArea = All;
                Caption = 'Download Markdown as .md';
                Image = Download;
                ToolTip = 'Executes the Download Markdown as .md action.';

                trigger OnAction()
                begin
                    MarkdownMgmt.DownloadMarkdown();
                end;
            }
        }
    }

    /// <summary>
    /// SetMarkdownText.
    /// </summary>
    /// <param name="AuxMarkdownText">Text.</param>
    internal procedure SetMarkdownText(AuxMarkdownText: Text)
    begin
        MarkdownText := AuxMarkdownText;
    end;

    var
        MarkdownMgmt: Codeunit MarkdownMgmt_ANJ;
        MarkdownText: Text;
}