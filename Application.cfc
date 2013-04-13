
component
	extends = "tinytest.Application"
	output = false
	hint = "I provide the application settings and event handlers for your testing." 
	{


	// Add any mappings that you need in order to load your modules from within
	// the unit test specifications.
	this.mappings[ "/yourAppRoot" ] = evaluatePathTraversal( "../" );


}