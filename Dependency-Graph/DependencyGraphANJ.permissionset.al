permissionset 80800 DependencyGraph_ANJ
{
    Assignable = true;
    Permissions = tabledata DependencyGraphSetup_ANJ = RIMD,
        table DependencyGraphSetup_ANJ = X,
        codeunit CircleIMP_ANJ = X,
        codeunit GenerateFigure_ANJ = X,
        codeunit RhombusIMP_ANJ = X,
        codeunit RoundRectangleIMP_ANJ = X,
        codeunit SquareRectangleIMP_ANJ = X,
        page DependencyGraphSetup_ANJ = X,
        tabledata Extensions_ANJ = RIMD,
        table Extensions_ANJ = X,
        page Extensions_ANJ = X,
        codeunit GenerateExtensionTable_ANJ = X,
        page ShowInGraph_ANJ = X;
}