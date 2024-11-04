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
        };
        mermaid.mermaidAPI.render('chart', Markdown, insertSvg);
    }
    catch (e) {
        console.log(e);
    }
}

function Navigate(Direction) {
    try {
        const container = document.getElementById('controlAddIn');
        switch (Direction) {
            case 'up':
                container.scrollBy(0, -100);
                break;
            case 'down':
                container.scrollBy(0, 100);
                break;
            case 'left':
                container.scrollBy(-100, 0);
                break;
            case 'right':
                container.scrollBy(100, 0);
                break;
        }
    }
    catch (e) {
        console.log(e);
    }
}

function Zoom(Level) {
    try {
        const container = document.getElementById('controlAddIn');
        const currentZoom = parseFloat(container.style.zoom) || 1;
        container.style.zoom = currentZoom + Level * 0.1;
    }
    catch (e) {
        console.log(e);
    }
}
