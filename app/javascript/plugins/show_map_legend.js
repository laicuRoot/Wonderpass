const legendButton = document.querySelector('.legend-toggle')
console.log(legendButton)

function showLegend() {
  legendButton.addEventListener('click', function() {
    console.log('success');
  });
};

export { showLegend };
