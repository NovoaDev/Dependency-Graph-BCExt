namespace ANJ.Tools.Graph;
controladdin MarkdownViewer_ANJ
{
    HorizontalShrink = true;
    RequestedHeight = 600;
    RequestedWidth = 650;
    Scripts = 'src\ControlAddinViewer\Scripts.js', 'https://cdnjs.cloudflare.com/ajax/libs/mermaid/9.3.0/mermaid.min.js', 'src\ControlAddinViewer\Navigation.js', 'src\ControlAddinViewer\Zoom.js';
    StartupScript = 'src\ControlAddinViewer\Start.js';
    StyleSheets = 'src\ControlAddinViewer\Style.css';
    VerticalShrink = true;

    event Ready();

    procedure Draw(Markdown: Text)

    procedure Navigate(Direction: Text)

    procedure Zoom(Level: Decimal)
}
