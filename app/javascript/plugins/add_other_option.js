const filterSelect = document.getElementById("select-distance");

const addHtml = () =>{
  const added = document.getElementById("added-class");
  if (filterSelect.value == "Other"){
    filterSelect.insertAdjacentHTML("afterend", '<br><input id="added-class" class= "form-control mt-0 mb-0" name="query" placeholder="Enter preferred distance" type="text" />');
  } else if(added){
    added.remove();
  }
}

const addOtherOption = () => {
  if (filterSelect){
  filterSelect.addEventListener("change", addHtml);
  }
};

export { addOtherOption }