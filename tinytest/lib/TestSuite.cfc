
component
	output = false
	hint = "I run a suite of test cases."
	{


	public any function init( required string testDirectory ) {

		variables.testDirectory = testDirectory;

		variables.results = "";

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	// I get the list of tests that this runner knows about (based on the directory).
	public array function getTestCaseNames() {

		var names = [];

		var files = directoryList( testDirectory, false, "name", "*Test.cfc" );

		for ( var file in files ) {

			arrayAppend( names, listFirst( file, "." ) );

		}

		return( names );

	}


	public any function runTestCases( required string testCaseList ) {

		results = new TestResults();

		try {

			for ( var testCase in getTestCaseNames() ) {

				if ( ! listFind( testCaseList, testCase ) ) {

					continue;

				}

				runTests( new "specs.#testCase#"() );

			}

			results.endTestingWithSuccess();

		} catch ( any error ) {

			results.endTestingWithError( new tinytest.lib.Error( error ) );

		}

		return( results );

	}


	// ---
	// PRIVATE METHODS.
	// ---


	private array function getTestMethodNames( required any testCase ) {

		var methodNames = [];

		for ( var methodName in structKeyArray( testCase ) ) {

			if ( isTestMethodName( methodName ) ) {

				arrayAppend( methodNames, methodName );

			}

		}

		return( methodNames );

	}


	private boolean function isTestMethodName( required string methodName ) {

		return( methodNameStartsWithTest( methodName ) );

	}


	private boolean function methodNameStartsWithTest( required string methodName ) {
		
		return( !! reFindNoCase( "^test", methodName ) );

	}


	private void function runTestMethod( 
		required any testCase,
		required string methodName 
		) {

		testCase.setup();

		evaluate( "testCase.#methodName#()" );

		testCase.teardown();

	}


	public void function runTests( required any testCase ) {

		for ( var methodName in getTestMethodNames( testCase ) ) {

			results.incrementTestCount();

			runTestMethod( testCase, methodName );

		}

	}

}