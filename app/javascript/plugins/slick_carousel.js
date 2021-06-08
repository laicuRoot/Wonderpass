import "slick-carousel";

const initSlick = () => {
  if($('.scroller')){
    $('.scroller').slick({
      slidesToShow: 2,
      infinite: true
    });
  }

  if($('.form-categories')){
    $('.form-categories').slick({
      slidesToShow: 4,
      infinite: true
    });
  }

  if($('.card-swipe')){
    $('.card-swipe').slick({
      slidesToShow: 1,
      rows: 3,
      slidesPerRow: 3,
      infinite: true
    });
  }
}

export { initSlick };
