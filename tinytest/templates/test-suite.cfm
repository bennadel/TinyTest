<cfscript>

	
	param name="form.submitted" type="boolean" default=false;
	param name="form.selectedTestCases" type="string" default="";


	testSuite = new tinytest.lib.TestSuite( this.mappings[ "/specs" ] );

	testCases = testSuite.getTestCases();


	if ( form.submitted ) {

		testResults = testSuite.runTestCases( form.selectedTestCases );

	} else {

		form.selectedTestCases = arrayToList( testCases, "" );

	}


</cfscript>


<!--- ----------------------------------------------------- --->
<!--- ----------------------------------------------------- --->

<cfcontent type="text/html; charset=utf-8" />

<cfoutput>

	<!doctype html>
	<html>
	<head>
		<meta charset="utf-8" />
		<title>Tiny Test : Test-Driven Development</title>
	</head>
	<body>

		<h1>
			Tiny Test : Test-Driven Development
		</h1>

		<p>
			I found #numberFormat( arrayLen( testCases ), "," )# test case(s) in the "specs" directory.
			Please select the test cases that you want to run.
		</p>


		<!--- BEGIN: Test Results. --->
		<cfif form.submitted>
			
			<h2>
				Test Results
			</h2>

			<cfloop index="testResult" array="#testResults#">
				

				<h4>
					#testResult.getTestCase()#
				</h4>


			</cfloop>

			<hr />

		</cfif>
		<!--- END: Test Results. --->


		<form method="post" action="#cgi.script_name#">

			<input type="hidden" name="submitted" value="true" />

			<p>
				<input type="submit" value="Run Selected Tests" />
			</p>

			<cfloop index="testCase" array="#testCases#">
				
				<div>

					<label for="#testCase#">

						<input id="#testCase#" type="checkbox" name="selectedTestCases" value="#testCase#"
							<cfif listFind( selectedTestCases, testCase )>
								checked="checked"
							</cfif>
							/>

						#testCase#

					</label>

				</div>

			</cfloop>

		</form>


		<script type="text/javascript" src="./tinytest/assets/jquery/jquery-1.9.1.min.js"></script>
		<script type="text/javascript">
			// ...
		</script>

	</body>
	</html>

</cfoutput>