/// <summary>
/// Enum FillingProcessingTables_ANJ (ID 80802).
/// </summary>
enum 80802 FillingProcessingTables_ANJ implements FillingProcessingTables_ANJ
{
    Access = Public;
    Caption = 'Filling Processing Tables', Comment = 'ESP="Rellenar tablas de procesamiento"';
    Extensible = true;

    value(0; WSAndModuleDependencyInfo)
    {
        Caption = 'WS And ModuleDependencyInfo', comment = 'ESP="WS y ModuleDependencyInfo"';
        Implementation = FillingProcessingTables_ANJ = WSAndMDInfoImp_ANJ;
    }
}