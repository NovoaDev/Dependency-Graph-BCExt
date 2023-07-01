/// <summary>
/// Enum ExtensionScope_ANJ (ID 80801)
/// </summary>
enum 80801 ExtensionScope_ANJ
{
    Access = Public;
    Caption = 'Extension Scope', Comment = 'ESP="Alcance de la extensión"';
    Extensible = false;

    value(0; PTE)
    {
        Caption = 'PTE', Comment = 'ESP="PTE"';
    }
    value(1; Global)
    {
        Caption = 'Global', Comment = 'ESP="Global"';
    }
    value(2; Dev)
    {
        Caption = 'Dev', Comment = 'ESP="Dev"';
    }
}