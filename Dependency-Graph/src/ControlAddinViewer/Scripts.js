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