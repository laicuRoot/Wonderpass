import { PageFlip } from 'page-flip';

const initPageFlip = () => {
  const pageFlip = new PageFlip(document.getElementById('book'), {
    width: 600, // required parameter - base page width
    height: 600, // required parameter - base page height
    maxHeight: 400,
    drawShadow: true,
    maxShadowOpacity: 0.3
  });
  if(document.querySelectorAll('.my-page')){
    pageFlip.loadFromHTML(document.querySelectorAll('.my-page'));
  }
}

export { initPageFlip };
