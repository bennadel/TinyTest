
component
	output = false
	hint = "I provide the base class for unit test cases."
	{


	public any function init() {

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	public string function getName() {

		var componentName = getMetaData( this ).name;

		var fileName = listLast( componentName, "." );

		return( fileName );

	}


	public void function setup() {

	}


	public void function teardown() {

	}


	// ---
	// PRIVATE METHODS.
	// ---


	private void function assert( required boolean value ) {

		assertTrue( value );

	}


	private void function assertEqual( 
		required string valueA,
		required string valueB
		) {

		if ( valueA != valueB ) {

			throwAssertionError( "Expected [#valueA#] to equal [#valueB#]." );

		}

	}


	private void function assertFalse( required boolean value ) {

		if ( value ) {

			throwAssertionError( "Expected [#value#] to be falsey." );

		}

	}


	private void function assertNotEqual( 
		required string valueA,
		required string valueB
		) {

		if ( valueA == valueB ) {

			throwAssertionError( "Expected [#valueA#] to not equal [#valueB#]." );

		}

	}


	private void function assertTrue( required boolean value ) {

		if ( ! value ) {

			throwAssertionError( "Expected [#value#] to be truthy." );

		}

	}


	private void function throwAssertionError( required string message ) {

		throw( type = "tinytest.AssertionFailed", message = message );

	}


}