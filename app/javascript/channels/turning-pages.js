import { PageFlip } from 'page-flip';

const pageFlip = new PageFlip(document.getElementById('book'), {
    width: 600, // required parameter - base page width
    height: 400, // required parameter - base page height
    maxHeight: 400,
    drawShadow: true,
    maxShadowOpacity: 0.3
});

pageFlip.loadFromHTML(document.querySelectorAll('.my-page'));

export { pageFlip };
