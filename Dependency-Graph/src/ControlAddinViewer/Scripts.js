/* 
Embed mermaid in Javascript learned from video by Erick houguard
https://www.youtube.com/watch?v=OIVVpFSJLmw
https://www.hougaard.com/ 

- Thank you very much! -
*/

function Draw(Markdown) {
    try {
        const insertSvg = function (svgCode, bindFunctions) {
            document.getElementById('controlAddIn').innerHTML = '<div class=\'MermaidDiv\'>' + svgCode + '</div>';
            initializeNavigationAndZoom();
        };
        mermaid.mermaidAPI.render('chart', Markdown, insertSvg);
    }
    catch (e) {
        console.log(e);
    }
}

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

function Navigate(Direction) {
    const svgElement = document.querySelector('.MermaidDiv svg');
    if (!svgElement) return;

    const [x, y, width, height] = svgElement.getAttribute('viewBox').split(' ').map(Number);
    const moveAmount = 20; // Adjust this value to control the navigation speed

    let newX = x;
    let newY = y;

    switch (Direction.toLowerCase()) {
        case 'up':
            newY -= moveAmount;
            break;
        case 'down':
            newY += moveAmount;
            break;
        case 'left':
            newX -= moveAmount;
            break;
        case 'right':
            newX += moveAmount;
            break;
    }

    svgElement.setAttribute('viewBox', `${newX} ${newY} ${width} ${height}`);
}

function Zoom(Level) {
    const svgElement = document.querySelector('.MermaidDiv svg');
    if (!svgElement) return;

    const [x, y, width, height] = svgElement.getAttribute('viewBox').split(' ').map(Number);
    const newWidth = width * Level;
    const newHeight = height * Level;
    const newX = x - (newWidth - width) / 2;
    const newY = y - (newHeight - height) / 2;

    svgElement.setAttribute('viewBox', `${newX} ${newY} ${newWidth} ${newHeight}`);
}
