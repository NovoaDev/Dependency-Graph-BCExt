/// <summary>
/// Enum FillingProcessingTables_ANJ (ID 80802).
/// </summary>
namespace ANJ.Tools.Graph;
enum 80802 FillingProcessingTables_ANJ implements FillingProcessingTables_ANJ
{
    Access = Public;
    Caption = 'Filling Processing Tables';
    Extensible = true;

    value(0; WSAndModuleDependencyInfo)
    {
        Caption = 'WS And ModuleDependencyInfo';
        Implementation = FillingProcessingTables_ANJ = WSAndMDInfoImp_ANJ;
    }
}