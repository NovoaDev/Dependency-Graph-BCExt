/// <summary>
/// EnumExtension FillingProcessingTablesMock_ANJ (ID 99990) extends Record FillingProcessingTables_ANJ.
/// </summary>
enumextension 99990 FillingProcessTablesMock_ANJ extends FillingProcessingTables_ANJ
{
    value(99990; Mock_ANJ)
    {
        Caption = 'Mock', comment = 'ESP="WS y Mock"';
        Implementation = FillingProcessingTables_ANJ = FillingProTablesMock_ANJ;
    }
}