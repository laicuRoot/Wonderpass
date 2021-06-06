require("slick-carousel")

const initSlick = () => {
  $('.scroller').slick({
    slidesToShow: 2,
    infinite: true
  })
}

export { initSlick }
