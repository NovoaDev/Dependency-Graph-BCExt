HTMLContainer = document.getElementById("controlAddIn");
mermaid.initialize({ startOnLoad: false });
Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Ready", []);

function initializeNavigationAndZoom() {
    const svgElement = document.querySelector('.MermaidDiv svg');
    if (!svgElement) return;

    svgElement.setAttribute('preserveAspectRatio', 'xMidYMid meet');
    svgElement.setAttribute('viewBox', `0 0 ${svgElement.clientWidth} ${svgElement.clientHeight}`);

    let isPanning = false;
    let startX, startY, startViewBox;

    svgElement.addEventListener('mousedown', (e) => {
        isPanning = true;
        startX = e.clientX;
        startY = e.clientY;
        startViewBox = svgElement.getAttribute('viewBox').split(' ').map(Number);
    });

    svgElement.addEventListener('mousemove', (e) => {
        if (!isPanning) return;
        const dx = (startX - e.clientX) * (startViewBox[2] / svgElement.clientWidth);
        const dy = (startY - e.clientY) * (startViewBox[3] / svgElement.clientHeight);
        svgElement.setAttribute('viewBox', `${startViewBox[0] + dx} ${startViewBox[1] + dy} ${startViewBox[2]} ${startViewBox[3]}`);
    });

    svgElement.addEventListener('mouseup', () => {
        isPanning = false;
    });

    svgElement.addEventListener('mouseleave', () => {
        isPanning = false;
    });

    svgElement.addEventListener('wheel', (e) => {
        e.preventDefault();
        const scale = e.deltaY > 0 ? 1.1 : 0.9;
        const [x, y, width, height] = svgElement.getAttribute('viewBox').split(' ').map(Number);
        const newWidth = width * scale;
        const newHeight = height * scale;
        const newX = x - (newWidth - width) / 2;
        const newY = y - (newHeight - height) / 2;
        svgElement.setAttribute('viewBox', `${newX} ${newY} ${newWidth} ${newHeight}`);
    });
}
