import Dropzone from "dropzone";

// Make sure Dropzone doesn't try to attach itself to the
// element automatically.
// This behaviour will change in future versions.
Dropzone.autoDiscover = false;

let myDropzone = new Dropzone("#my-awesome-dropzone", { url: "/"});
myDropzone.on("addedfile", file => {
    console.log(`File added: ${file.name}`);
});

export { myDropzone }
