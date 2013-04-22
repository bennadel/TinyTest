
<cfscript>


	param name="form.submitted" type="boolean" default=false;
	param name="form.selectedTestCases" type="string" default="";


	testSuite = new tinytest.lib.TestSuite( this.mappings[ "/specs" ] );

	testCases = testSuite.getTestCases();

	testStatus = "start";


	if ( form.submitted ) {

		if ( ! len( form.selectedTestCases ) ) {

			location( url = cgi.script_name, addToken = false );

		}

		testResults = testSuite.runTestCases( form.selectedTestCases );

		testStatus = ( testResults.isPassed() ? "pass" : "fail" );

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


			<!-- BEGIN: Site Info. -->
			<div class="siteInfo">

				<a href="#cgi.script_name#" class="name">
					TinyTest
				</a>

				<span class="tddMentality">
					Red - Green - Refactor
				</span>

				<span class="author">
					by <a href="http://www.bennadel.com" target="bennadelcom">Ben Nadel</a>
				</span>

			</div>
			<!-- END: Site Info. -->


			<!--- BEGIN: Status Output. --->
			<cfif ( testStatus eq "start" )>


				<!-- BEGIN: Test Status. -->
				<div class="testStatus start">

					<button type="submit" class="callToAction">

						<div class="subtitle">
							<span>Test Driven Development</span>
						</div>

						<div class="status">
							Start
						</div>

						<div class="button">
							Run Selected Tests
						</div>

					</button>

				</div>
				<!-- END: Test Status. -->


			<cfelseif ( testStatus eq "pass" )>


				<!-- BEGIN: Test Status. -->
				<div class="testStatus pass">

					<button type="submit" class="callToAction">

						<div class="subtitle">
							<span>You Ran #numberFormat( testResults.getTestCount(), "," )# Tests In #numberFormat( testResults.getDuration(), "," )# ms</span>
						</div>

						<div class="status">
							Passed
						</div>

						<div class="button">
							Run Tests Again
						</div>

					</button>

				</div>
				<!-- END: Test Status. -->


			<cfelseif ( testStatus eq "fail")>


				<!-- BEGIN: Test Status. -->
				<div class="testStatus fail">

					<button type="submit" class="callToAction">

						<div class="subtitle">
							<span>We Have A Problem</span>
						</div>

						<div class="status">
							Failed
						</div>

						<div class="button">
							Try Again
						</div>

						<div class="errorInfo">

							<div class="subtitle">
								<span>What Went Wrong</span>
							</div>

							<cfloop
								index="stackItem"
								array="#testResults.getError().getStackTrace()#">
									
								<!--- Ignore some "noise" items. --->
								<cfif listFindNoCase( "Application.cfc,test-suite.cfm", stackItem.filename )>
									
									<cfcontinue />

								</cfif>

								<div class="file">
									#stackItem.filename# : Line #stackItem.lineNumber#
								</div>

							</cfloop>		

							<div class="message">
								#htmlEditFormat( testResults.getError().getErrorMessage() )#
							</div>

						</div>

					</button>

				</div>
				<!-- END: Test Status. -->


			</cfif>
			<!--- END: Status Output. --->


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