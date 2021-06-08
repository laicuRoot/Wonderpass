// const filterSelect = document.querySelector("#select-distance");

// const addHtml = () =>{
//   const added = document.getElementById("added-class");
//   console.log(added);
//   if (filterSelect.value == "Other"){
//     filterSelect.insertAdjacentHTML("afterend", '<input id="added-class" class= "form-control mt-2 mb-0" name="query" placeholder="Enter preferred distance" type="text" />');
//   } else if(added){
//     added.remove();
//   }
// }

const addOtherOption = () => {
  const filterSelect = document.querySelector("#select-distance");
  if (filterSelect){
    filterSelect.addEventListener("change",  () =>{
      const added = document.getElementById("added-class");
      if (filterSelect.value == "Other"){
        filterSelect.insertAdjacentHTML("afterend", '<input id="added-class" class= "form-control mt-2 mb-0" name="query" placeholder="Enter preferred distance" type="text" />');
      } else if(added){
        added.remove();
      }
    });
  }
}

export { addOtherOption }