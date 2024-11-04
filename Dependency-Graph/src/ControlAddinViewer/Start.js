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

document.addEventListener('wheel', function(event) {
    if (event.ctrlKey) {
        event.preventDefault();
        Zoom(event.deltaY < 0 ? 1 : -1);
    }
});

document.addEventListener('mousedown', function(event) {
    if (event.button === 1) {
        document.body.classList.add('zooming');
    }
});

document.addEventListener('mouseup', function(event) {
    if (event.button === 1) {
        document.body.classList.remove('zooming');
    }
});
