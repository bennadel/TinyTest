
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


	public void function setup() {

		// This can be overridden by the user's sub-class.

	}


	public void function teardown() {

		// This can be overridden by the user's sub-class.

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