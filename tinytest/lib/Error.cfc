component
	output = false
	hint = "I represent the error that was thrown during a TestCase execution."
	{


	public any function init( required any exception ) {

		errorMessage = getErrorFromException( arguments.exception );

		stackTrace = getStackTraceFromException( arguments.exception );
		
		fullStackTrace = getFullStackTraceFromException( arguments.exception );

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	public string function getErrorMessage() {

		return( errorMessage );

	}


	public string function getFullStackTrace() {

		return( fullStackTrace );

	}


	public array function getStackTrace() {

		return( stackTrace );

	}


	// ---
	// PRIVATE METHODS.
	// ---


	private string function getErrorFromException( required any exception ) {

		if ( 
			! structKeyExists( arguments.exception, "message" ) ||
			! len( arguments.exception.message )
			) {

			return( "An unexpected error has occurred." );

		}

		return( arguments.exception.message );

	}


	private string function getFullStackTraceFromException( required any exception ) {
		
		if ( ! structKeyExists( arguments.exception, "stackTrace" ) ) {

			return( "" );

		}
		
		return( arguments.exception.stackTrace );

	}


	private array function getStackTraceFromException( required any exception ) {

		if ( ! structKeyExists( arguments.exception, "tagContext" ) ) {

			return( arrayNew( 1 ) );

		}

		var simplifiedContext = [];

		for ( var tagContext in arguments.exception.tagContext ) {

			// For generated templates, this will not be a file path. This is caused by the
			// use of the evaluate() method to invoke a compoonent method.
			if ( isPhysicalTemplatePath( tagContext.template ) ) {

				arrayAppend(
					simplifiedContext,
					{
						fileName = getFileFromPath( tagContext.template ),
						filePath = tagContext.template,
						lineNumber = tagContext.line
					}
				);
				
			}

		}

		return( simplifiedContext );

	}


	private boolean function isPhysicalTemplatePath( required string templatePath ) {

		return( arguments.templatePath != "<generated>" );

	}


}