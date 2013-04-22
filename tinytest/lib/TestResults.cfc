component
	output = false
	hint = "I represent the results of a test suite."
	{


	public any function init() {

		isFinished = false;

		startTime = getTickCount();
		endTime = startTime;

		errorMessage = "";
		stackTrace = [];

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	// I end the tests with a successful conclusion.
	public void function endTests() {

		if ( isFinished ) {

			throw( type = "InvalidState", message = "Tests have already been ended." );

		}

		isFinished = true;

		endTime = getTickCount();

	}


	public void function endTestsInError( required any exception ) {

		if ( isFinished ) {

			throw( type = "InvalidState", message = "Tests have already been ended." );

		}

		isFinished = true;

		endTime = getTickCount();

	}


	public void function startTests() {

		startTime = getTickCount();
		endTime = startTime;

	}



	public string function getErrorMessage() {

		return( errorMessage );

	}


	public array function getStackTrace() {

		return( stackTrace );

	}


	public boolean function isFailed() {

		return( !! len( errorMessage ) );

	}


	public boolean function isPassed() {

		return( ! len( errorMessage ) );

	}


	// ---
	// PRIVATE METHODS.
	// ---


}