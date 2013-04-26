component
	extends = "tinytest.lib.TestCase"
	output = false
	hint = "I provide a hook for adding custom assertion methods to your test cases."
	{


	// Example of a custom assertion that you provide for your test cases.
	private void function assertIsValidEmail( required string email ) {

		if ( ! isValid( "email", email ) ) {

			throwAssertionError( "Expected [#email#] to be a valid email address." );

		}

	}


}