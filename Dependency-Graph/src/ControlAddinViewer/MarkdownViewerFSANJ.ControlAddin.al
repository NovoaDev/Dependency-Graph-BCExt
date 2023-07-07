/// <summary>
/// ControlAddIn "MarkdownViewer_ANJ._ANJ"
/// </summary>
controladdin MarkdownViewerFS_ANJ
{
    HorizontalStretch = true;
    Scripts = 'src\ControlAddinViewer\Scripts.js', 'https://cdnjs.cloudflare.com/ajax/libs/mermaid/9.3.0/mermaid.min.js';
    StartupScript = 'src\ControlAddinViewer\Start.js';
    VerticalStretch = true;


    /// <summary>
    /// Ready.
    /// </summary>
    event Ready();

    /// <summary>
    /// Draw.
    /// </summary>
    /// <param name="Markdown">Text.</param>
    procedure Draw(Markdown: Text);
}