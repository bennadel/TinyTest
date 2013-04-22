
<cfscript>

	
	function testing() {

		throw( type = "foobar" );

	}


	try {

		testing();
		
	} catch( any error ){ 

		// writeDump(error);

		e = new tinytest.lib.Error( error );

		writeDump( e.getErrorMessage() );
		writeDump( e.getStackTrace() );



	}



	abort;
	
	param name="form.submitted" type="boolean" default=false;
	param name="form.selectedTestCases" type="string" default="";


	testSuite = new tinytest.lib.TestSuite( this.mappings[ "/specs" ] );

	testCases = testSuite.getTestCases();


	mode = "start";
	statusClass = "start";
	statusLabel = "Start";


	if ( form.submitted ) {

		if ( ! len( form.selectedTestCases ) ) {

			location( url = cgi.script_name, addToken = false );

		}

		testResults = testSuite.runTestCases( form.selectedTestCases );

		if ( testResults.isPassed() ) {

			mode = "pass";
			statusClass = "pass";
			statusLabel = "Passed";

		} else {

			mode = "fail";
			statusClass = "fail";
			statusLabel = "Failed";

		}

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

		<link rel="stylesheet" type="text/css" href="tinytest/assets/app/css/test-suite.css"></link>
	</head>
	<body>

		<!-- BEGIN: Form. -->
		<form method="post" action="#cgi.script_name#">

			<!-- Flag the form as submitted. -->
			<input type="hidden" name="submitted" value="true" />


			<!-- BEGIN: Test Status. -->
			<div class="testStatus #testStatusClass#">

				<!-- BEGIN: Site Info. -->
				<div class="siteInfo">

					<span class="name">
						TinyTest
					</span>

					<span class="tddMentality">
						Red - Green - Refactor
					</span>

					<span class="author">
						by <a href="http://www.bennadel.com" target="bennadelcom">Ben Nadel</a>
					</span>

				</div>
				<!-- END: Site Info. -->

				<button type="submit" class="callToAction">


					<!--- BEGIN: Mode Output. --->
					<cfif ( mode eq "start" )>


						<div class="subtitle">
							<span>Test Driven Development</span>
						</div>

						<div class="status">
							#htmlEditFormat( testStatusLabel )#
						</div>

						<div class="button">
							Run Selected Tests
						</div>
						

					<cfelseif ( mode eq "pass" )>


						<div class="subtitle">
							<span>Test Driven Development</span>
						</div>

						<div class="status">
							#htmlEditFormat( testStatusLabel )#
						</div>

						<div class="button">
							Run Selected Tests
						</div>


					<cfelseif ( mode eq "fail")>


						<div class="subtitle">
							<span>Test Driven Development</span>
						</div>

						<div class="status">
							#htmlEditFormat( testStatusLabel )#
						</div>

						<div class="button">
							Run Selected Tests
						</div>

						<div class="errorInfo">

							<div class="subtitle">
								<span>What Went Wrong</span>
							</div>

							<div class="file">
								NotificationServiceTest.cfc : Line 16
							</div>

							<div class="message">
								Expected [123] to be [ABC].
							</div>

						</div>


					</cfif>
					<!--- END: Mode Output. --->


				</button>

			</div>
			<!-- END: Test Status. -->


			<!-- BEGIN: Test List. -->
			<div class="testList">

				<div class="header">

					<div class="title">
						<span class="text">You Have #arrayLen( testCases )# Test Cases</span>
						<span class="selectAll">( <a href="##">Select All</a> )</span>
					</div>

					<input type="text" placeholder="Filter test cases" tabindex="1" class="filter" />

				</div>

				<ol class="tests">

					<cfloop 
						index="testCase"
						array="#testCases#">
						
						<li class="test">

							<label>
								
								<input 
									type="checkbox"
									name="selectedTestCases"
									value="#htmlEditFormat( testCase )#" 
									<cfif listFind( form.selectedTestCases, testCase )>
										checked="checked"
									</cfif>
									/>

								#htmlEditFormat( testCase )#

							</label>

						</li>

					</cfloop>

				</ol>

			</div>
			<!-- END: Test List. -->

		</form>
		<!-- END: Form. -->


		<!-- BEGIN: Processing. -->
		<div class="processingOverlay">

			<div class="message">
				
				<div class="plan">
					Running <span class="count">0</span> Test Cases
				</div>

				<div class="patience">
					Please stand by...
				</div>

			</div>

		</div>
		<!-- END: Processing. -->


		<!-- Initialize interface scripts. -->
		<script type="text/javascript" src="./tinytest/assets/jquery/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="./tinytest/assets/app/main.js"></script>

	</body>
	</html>

</cfoutput>