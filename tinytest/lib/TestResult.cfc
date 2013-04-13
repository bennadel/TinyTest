component
	output = false
	hint = "I represent the results of a unit test within a test case."
	{


	public any function init( required string methodName ) {

		variables.methodName = methodName;
		variables.startTime = 0;
		variables.endTime = 0;
		variables.errorMessage = "";

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	public void function endTestWithFailure( required string error ) {

		endTime = getTickCount();

		errorMessage = error

	}


	public void function endTestWithSuccess() {

		endTime = getTickCount();

	}


	public numeric function getDuration() {

		return( endTime - startTime );

	}


	public void function startTest() {

		startTime = getTickCount();

	}


	// ---
	// PRIVATE METHODS.
	// ---
	

}