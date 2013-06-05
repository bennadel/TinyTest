
component
	output = false
	hint = "I run a suite of test cases."
	{


	public any function init( required string testDirectory ) {

		variables.testDirectory = arguments.testDirectory;

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
		var testCases = getTestCaseNames();

		try {

			for ( var testCaseName in testCases ) {

				if ( ! listFind( arguments.testCaseList, testCaseName ) ) {

					continue;

				}

				runTestsInTestCase( new "specs.#testCaseName#"() );

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

		// structKeyArray() will make sure that only public methods are picked up.
		for ( var methodName in structKeyArray( arguments.testCase ) ) {

			if ( isTestMethodName( methodName ) ) {

				arrayAppend( methodNames, methodName );

			}

		}

		return( methodNames );

	}


	private boolean function isTestMethodName( required string methodName ) {

		// All test methods must start with the term, "test". 
		return( !! reFindNoCase( "^test", arguments.methodName ) );

	}


	private void function runTestMethod( 
		required any testCase,
		required string methodName 
		) {

		arguments.testCase.setup();

		evaluate( "testCase.#arguments.methodName#()" );

		arguments.testCase.teardown();

	}


	public void function runTestsInTestCase( required any testCase ) {

		try{
			// Execute before
			arguments.testCase.beforeTests();

			// Execute tests
			var testMethods = getTestMethodNames( arguments.testCase );
			for ( var methodName in testMethods ) {

				results.incrementTestCount();

				runTestMethod( arguments.testCase, methodName );

			}
			
		}
		catch(Any e){
			rethrow;
		}
		// Guarantee that after tests run even if exceptions ocurr
		finally{
			// Execute after
			arguments.testCase.afterTests();
		}

	}

}