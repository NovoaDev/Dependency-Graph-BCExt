/// <summary>
/// Enum ExtensionScope_ANJ (ID 80801)
/// </summary>
namespace ANJ.Tools.Graph;
enum 80801 ExtensionScope_ANJ
{
    Access = Public;
    Caption = 'Extension Scope';
    Extensible = false;

    value(0; PTE)
    {
        Caption = 'PTE';
    }
    value(1; Global)
    {
        Caption = 'Global';
    }
    value(2; Dev)
    {
        Caption = 'Dev';
    }
}