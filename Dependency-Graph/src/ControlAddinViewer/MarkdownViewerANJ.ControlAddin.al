/// <summary>
/// ControlAddIn "MarkdownViewer_ANJ."
/// </summary>
namespace ANJ.Tools.Graph;
controladdin MarkdownViewer_ANJ
{
    HorizontalShrink = true;
    RequestedHeight = 600;
    RequestedWidth = 650;
    Scripts = 'src\ControlAddinViewer\Scripts.js', 'https://cdnjs.cloudflare.com/ajax/libs/mermaid/9.3.0/mermaid.min.js';
    StartupScript = 'src\ControlAddinViewer\Start.js';
    StyleSheets = 'src\ControlAddinViewer\Style.css';
    VerticalShrink = true;

    /// <summary>
    /// Ready.
    /// </summary>
    event Ready();

    /// <summary>
    /// Draw.
    /// </summary>
    /// <param name="Markdown">Text.</param>
    procedure Draw(Markdown: Text)
}