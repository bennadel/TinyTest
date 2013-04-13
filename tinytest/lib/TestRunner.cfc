component
	output = false
	hint = "I execute the unit tests on a given test case."
	{


	public any function init( required any testCase ) {

		variables.testCase = testCase;

		variables.results = [];

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	public void function runTests() {

		results = [];

		for ( var methodName in getTestMethods() ) {

			arrayAppend( results, runTest( methodName ) );

		}

	}


	// ---
	// PRIVATE METHODS.
	// ---


	private string function getErrorMessage( required any error ) {

		return( error.message );
		
	}


	private array function getTestMethods() {

		var methods = [];

		for ( var methodName in structKeyArray( testCase ) ) {

			if ( isTestMethodName( methodName ) ) {

				arrayAppend( methods, methodName );

			}

		}

		return( methods );

	}


	private void function invokeTestMethod( required string methodName ) {

		evaluate( "testCase.#methodName#()" );

	}


	private boolean function isTestMethodName( required string methodName ) {

		return( methodNameStartsWithTest( methodName ) );

	}


	private boolean function methodNameStartsWithTest( required string methodName ) {
		
		return( !! reFindNoCase( "^test", methodName ) );

	}


	private any function runTest( required string methodName ) {

		var result = new TestResult( methodName );

		result.startTest();

		try {

			invokeTestMethod( methodName );

			result.endTestWithSuccess();

		} catch ( any error ) {

			result.endTestWithFailure( getErrorMessage( error ) );

		}

		return( result );

	}

}