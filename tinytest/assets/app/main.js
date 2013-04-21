(function( $ ) {

	"use strict";


	function focusFilter() {

		dom.filter[ 0 ].focus();
		dom.filter[ 0 ].select();

	}


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

		dom.processingOverlay.fadeIn( 200 );

	}


	// Cache DOM node references.
	var dom = {
		form: $( "form" ),
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


})( jQuery );