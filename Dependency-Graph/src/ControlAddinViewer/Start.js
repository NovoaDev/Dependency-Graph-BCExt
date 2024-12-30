HTMLContainer = document.getElementById("controlAddIn");
mermaid.initialize({ startOnLoad: false });
Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Ready", []);

document.addEventListener('keydown', function(event) {
    switch (event.key) {
        case 'ArrowUp':
            Navigate('up');
            break;
        case 'ArrowDown':
            Navigate('down');
            break;
        case 'ArrowLeft':
            Navigate('left');
            break;
        case 'ArrowRight':
            Navigate('right');
            break;
        case '+':
            Zoom(1);
            break;
        case '-':
            Zoom(-1);
            break;
    }
});
