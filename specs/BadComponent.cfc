component 
	output = false
	hint = "I provide a failure in the app's model."
	{


	public any function init() {

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	public boolean function returnTrue() {

		return( false );

	}


	public void function throwError() {

		return( 1 / 0 );

	}


	// ---
	// PRIVATE METHODS.
	// ---
}