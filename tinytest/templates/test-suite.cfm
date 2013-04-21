
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

		<link rel="stylesheet" type="text/css" href="tinytest/assets/app/css/test-suite.css"></link>
	</head>
	<body>

		<!-- BEGIN: Form. -->
		<form method="post" action="#cgi.script_name#">

			<!-- Flag the form as submitted. -->
			<input type="hidden" name="submitted" value="true" />


			<!-- BEGIN: Test Status. -->
			<div class="testStatus start">

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

					<div class="subtitle">
						<span>Test Driven Development</span>
					</div>

					<div class="status">
						Start
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

				</button>

			</div>
			<!-- END: Test Status. -->


			<!-- BEGIN: Test List. -->
			<div class="testList">

				<div class="header">

					<div class="title">
						<span class="text">You Have 87 Test Cases</span>
						<span class="selectAll">( <a href="##">Select All</a> )</span>
					</div>

					<input type="text" placeholder="Filter test cases" tabindex="1" class="filter" />

				</div>

				<ol class="tests selected">
					<li class="test">

						<label>
							<input type="checkbox" /> NotificationServiceTest
						</label>

					</li>
					<li class="test">

						<label>
							<input type="checkbox" /> UserServiceTest
						</label>

					</li>
					<li class="test">

						<label>
							<input type="checkbox" /> TeamServiceTest
						</label>

					</li>
				</ol>

				<div class="subtitle">
					<span>You Have 87 Test Cases</span>
				</div>

				<ol class="tests all">
					<li class="test">

						<label>
							<input type="checkbox" /> NotificationServiceTest
						</label>

					</li>
					<li class="test">

						<label>
							<input type="checkbox" /> UserServiceTest
						</label>

					</li>
					<li class="test">

						<label>
							<input type="checkbox" /> TeamServiceTest
						</label>

					</li>
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