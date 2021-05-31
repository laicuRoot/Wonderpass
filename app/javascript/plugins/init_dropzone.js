import Dropzone from "dropzone";

// Make sure Dropzone doesn't try to attach itself to the
// element automatically.
// This behaviour will change in future versions.
Dropzone.autoDiscover = false;


function init_dropzone(){
  let myDropzone = new Dropzone(("#my-awesome-dropzone"),{
  uploadMultiple: false,
  acceptedFiles:'.jpg,.png,.jpeg,.gif',
  parallelUploads: 6,
  autoProcessQueue: false
  });
  myDropzone.on("addedfile", file => {
      console.log(`File added: ${file.name}`);
  });
  myDropzone.on('sending', function (file, xhr, formData) {
    formData.append('api_key', 431665768796881);
    formData.append('timestamp', Date.now() / 1000 | 0);
    formData.append('upload_preset', 'presetname');
  });
  myDropzone.on('success', function (file, response) {
    console.log('Success! Cloudinary public ID is', response.public_id);
  });

  let btn = document.getElementById('processDrop');
  btn.addEventListener('click', () => {
    console.log(btn);
    myDropzone.processQueue();
  })
}

// function processPhotos = () => {
//   let btn = document.getElementById('processDrop');
//   btn.addEventListener('click', {
//     myDropzone.processQueue();
//   })
// }

// var myDropzone = new Dropzone(document.getElementById('dropzone-area'), {
//   uploadMultiple: false,
//   acceptedFiles:'.jpg,.png,.jpeg,.gif',
//   parallelUploads: 6
// });

export { init_dropzone }
