$(function() {
  $( ".inspectors-list li:not(.item-description)" ).on( "click", function() {
  	  $( ".inspectors-list li" ).removeClass( "active" );

	  if(!$( this ).hasClass( "active" )) {
	  	$( this ).addClass( "active" );
	  	$( this ).next().slideDown();
	  } else {
	  	$( this ).next().slideUp();
	  }

	});
});