component
	output = false
	hint = "I provide the base class for unit test cases."
	{

	// I initialize the component.
	public any function init() {

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	// I get called once after all the test methods have executed.
	public void function afterTests() {

		// Abstract method...

	}


	// I get called once before any tests methods have executed.
	public void function beforeTests() {

		// Abstract method...

	}


	// I get called before every test method is executed.
	public void function setup() {

		// Abstract method...

	}


	// I get called after every test method has executed.
	public void function teardown() {

		// Abstract method...

	}


	// ---
	// PRIVATE METHODS.
	// ---


	// I am a short-hand for the assertTrue() method.
	private void function assert( required boolean value ) {

		assertTrue( arguments.value );

	}


	private void function assertEquals( 
		required string valueA,
		required string valueB
		) {

		if ( arguments.valueA != arguments.valueB ) {

			fail( "Expected [#arguments.valueA#] to equal [#arguments.valueB#]." );

		}

	}


	private void function assertFalse( required boolean value ) {

		if ( arguments.value ) {

			fail( "Expected [#arguments.value#] to be falsey." );

		}

	}


	private void function assertNotEquals( 
		required string valueA,
		required string valueB
		) {

		if ( arguments.valueA == varguments.alueB ) {

			fail( "Expected [#arguments.valueA#] to not equal [#arguments.valueB#]." );

		}

	}


	private void function assertTrue( required boolean value ) {

		if ( ! arguments.value ) {

			fail( "Expected [#arguments.value#] to be truthy." );

		}

	}


	private void function fail( required string message ) {

		throw( type = "tinytest.AssertionFailed", message = arguments.message );

	}

}