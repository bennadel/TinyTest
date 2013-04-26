(function( $ ) {

	"use strict";


	function hideAllTestCases() {

		dom.testCases.children().hide();

	}


	function getSelectedTestCases() {

		return(
			dom.testCases.children().has( "input:checked" )
		);

	}


	function initializeSearchValues() {

		dom.testCases.children().attr(
			"data-search-value",
			function( index ) {

				var textValue = $( this ).text();

				return( $.trim( textValue ).toLowerCase() );

			}
		);

	}


	function isRefreshEvent( event ) {

		return( ( event.which === 114 ) && event.metaKey );

	}


	function isEnterKeyEvent( event ) {

		return( event.which === 13 );

	}


	function searchTestCases( value ) {

		value = value.toLowerCase();

		var matchingTestCases = dom.testCases.children().filter(
			function() {

				return( $( this ).attr( "data-search-value" ).indexOf( value ) >= 0 );

			}
		);

		return( matchingTestCases );

	}


	function selectAllTestsCases() {

		dom.filter.val( "" );

		showAllTestCases();

		selectVisibleTestCases();

	}


	function selectVisibleTestCases() {

		dom.testCases
			.children( ":visible" )
				.find( "input" )
					.prop( "checked", true )
		;

	}


	function showAllTestCases() {

		dom.testCases.children().show();

	}


	function showMatchingTestsCases( value ) {

		if ( value ) {

			hideAllTestCases();
			
			searchTestCases( value )
				.show()
			;

		} else {

			showAllTestCases();

		}

	}


	function showProcessingOverlay( testCaseCount ) {

		dom.processingCount.text( testCaseCount );

		dom.processingOverlay
			.delay( 500 )
			.fadeIn( 200 )
		;

	}


	// Cache DOM node references.
	var dom = {
		form: $( "form" ),
		testStatus: $( "form input[ name = 'testStatus' ]"),
		filter: $( "input.filter" ),
		selectAll: $( "span.selectAll a" ),
		testCases: $( "div.testList ol.tests" ),
		processingOverlay: $( "div.processingOverlay" ),
		processingCount: $( "div.processingOverlay span.count" )
	};


	initializeSearchValues();


	dom.selectAll.click(
		function( event ) {

			event.preventDefault();

			selectAllTestsCases();

		}
	);


	// Listen for the keypress event which will give us access to the Enter key.
	dom.filter.keypress(
		function( event ) {

			if ( isEnterKeyEvent( event ) ) {

				selectVisibleTestCases();

				// NOTE: We are not cancelling the event since we want it to trigger a form submission.
				
			}

		}
	);


	// Listen to filter changes so we can update the list of test cases.
	dom.filter.keyup(
		function( event ) {

			showMatchingTestsCases( this.value );

		}
	);


	dom.form.submit(
		function( event ) {

			var selectedTestCases = getSelectedTestCases();

			if ( selectedTestCases.length ) {

				showProcessingOverlay( selectedTestCases.length );

			} else {

				event.preventDefault();

			}

		}
	);


	$( window ).keypress(
		function( event ) {

			// We don't care about keypresses while on the start screen.
			if ( dom.testStatus.val() === "start" ) {

				return;

			}

			if ( isRefreshEvent( event ) ) {

				// This will prevent the browser from asking if the form data should be
				// resubmitted (for security reasons). Since we just want to resubmit the
				// data, this will remove that friction.
				event.preventDefault();

				dom.form.submit();

			}

		}
	);


})( jQuery );