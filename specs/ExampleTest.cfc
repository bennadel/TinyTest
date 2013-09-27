component
	extends = "TestCase"
	output = false
	hint = "I test a given component or module."
	{

	public void function beforeTests() {

		// Runs ONCE before ANY the test methods have executed.

	}


	public void function afterTests() {

		// Runs ONCE after ALL the test methods have executed.

	}


	public void function testThatThisRuns() {

		// Runs failure... if you uncomment any of the following.

		// assert( true == false );
		// assertIsValidEmail( "ben nadel" );
		
	}


	public void function testThatThatRuns() {

		// Runs successfully...	
	
	}


	public void function proveThatNonStandardNamesWillNotRun() {

		// Since this method name does not start with "test", it should not be invoked by TinyTest.
		fail( "Non-test method invoked incorrectly." );

	}


	private void function testThatThisDoesNotRun() {

		// This is a private method, it should not be invoked by TinyTest.
		fail( "Private method invoked incorrectly." );

	}

}