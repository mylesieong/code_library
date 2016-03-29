// Data
var players = [
  {
    name: "Tom Chan",
    score: 78,
    pic: "http://placehold.it/150x150&text=FW"
  },
  {
    name: "Steven Ku",
    score: 73,
    pic: "http://placehold.it/150x150&text=KW"
  },
  {
    name: "Francis Wong",
    score: 82,
    pic: "http://placehold.it/150x150&text=TC"
  },
  {
    name: "Ken Wong",
    score: 98,
    pic: "http://placehold.it/150x150&text=SK"
  },
];

// construct the list from data
function createListFromData() {
	// empty the container
	$('#player-board').empty();
	  
	// construct the list
	$.each(players, function(){
		var playerObj = this;
		var clone = $('.template').find('.player').clone();
		clone.find('.name').text( playerObj.name );
		clone.find('.score').text( playerObj.score );
		clone.find('.profile-pic img').prop( 'src', playerObj.pic );

		$('#player-board').append(clone);

		}
	);  
}


// call the function once on start up
//createListFromData();

// View links handling
$(document).on("click", '.sorting-controls > a', 
	function(){
		// determine which sorting
		var sortBy = $(this).attr('href').substring(1); // get 'ascend' or 'descend'
		var sortFactor;
		
		// tell the user that we are sorting.
		$('.current-sorting-by').find('span').text( sortBy );
		
		// sort the data
		if (sortBy=='ascend'){
			alert ('in ascend sortFactor condition');
			sortFactor=-1;
		}
		
		if (sortBy=='descend'){
			alert ('in descend sortFactor condition');
			sortFactor=1;
		}
		
		players.sort(
			function(a, b){
				if (a.score <= b.score) {
					  return sortFactor;
					} else {
					  return sortFactor * -1;
					}
			}
		);
		
		createListFromData();
		
		return false;
	}
);

