import "slick-carousel";

const initSlick = () => {
  if($('.scroller')){
    let slideCount = $('.card').length;
    console.log(slideCount);
    if(slideCount <= 1 ){
      $('.scroller').slick({
        slidesToShow: 1,
        infinite: true
      })
    } else {
      $('.scroller').slick({
        slidesToShow: 2,
        infinite: true,
      })
    }
  };

  if($('.form-categories')){
    $('.form-categories').slick({
      slidesToShow: 5
    });
  }

  if($('.card-swipe')){
    let itineraryCards = document.querySelectorAll(".itinerary-item-body");
    if (itineraryCards.length > 9){
      $('.card-swipe').slick({
        slidesToShow: 1,
        rows: 3,
        slidesPerRow: 3,
        infinite: true
      });
    }
  }
}

export { initSlick };
