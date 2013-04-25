component
	output = false
	hint = "I execute the unit tests on a given test case."
	{


	public any function init( 
		required any testCase,
		required any testResults
		) {

		variables.testCase = testCase;
		variables.testResults = testResults;

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	public void function runTests() {

		for ( var methodName in getTestMethods() ) {

			testResults.incrementTestCount();

			runTest( methodName );

		}

	}


	// ---
	// PRIVATE METHODS.
	// ---


	private array function getTestMethods() {

		var methods = [];

		for ( var methodName in structKeyArray( testCase ) ) {

			if ( isTestMethodName( methodName ) ) {

				arrayAppend( methods, methodName );

			}

		}

		return( methods );

	}


	private boolean function isTestMethodName( required string methodName ) {

		return( methodNameStartsWithTest( methodName ) );

	}


	private boolean function methodNameStartsWithTest( required string methodName ) {
		
		return( !! reFindNoCase( "^test", methodName ) );

	}


	private void function runTest( required string methodName ) {

		testCase.setup();

		evaluate( "testCase.#methodName#()" );

		testCase.teardown();

	}

}