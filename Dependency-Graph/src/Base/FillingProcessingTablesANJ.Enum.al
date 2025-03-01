/// <summary>
/// Enum FillingProcessingTables_ANJ (ID 80802).
/// </summary>
namespace ANJ.Tools.Graph;
enum 80802 FillingProcessingTables_ANJ implements IFillingProcessingTables_ANJ
{
    Access = Public;
    Caption = 'Filling Processing Tables';
    DefaultImplementation = IFillingProcessingTables_ANJ = DefaultFillProcessTabImp_ANJ;
    Extensible = true;
    UnknownValueImplementation = IFillingProcessingTables_ANJ = DefaultFillProcessTabImp_ANJ;

    value(1; WSAndModuleDependencyInfo)
    {
        Caption = 'WS And ModuleDependencyInfo';
        Implementation = IFillingProcessingTables_ANJ = WSAndMDInfoImp_ANJ;
    }
}