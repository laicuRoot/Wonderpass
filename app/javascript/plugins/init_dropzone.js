const init_dropzone = () => {
  let element = document.querySelector("body > div.container.bg-white.mt-5.main_container > div > div:nth-child(1) > form > div > div.dropzone.dropzone-default.dz-clickable.dz-started.dz-max-files-reached > input[type=hidden]:nth-child(2)")

  if(element){
    console.log(element)
  }

}

export { init_dropzone }
