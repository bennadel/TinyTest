
component
	extends = "tinytest.Application"
	output = false
	hint = "I provide the application settings and event handlers for your testing." 
	{


	// Set up any datasource your application might need.
	this.datasource = "yourAppDatasource";

	// Add any mappings that you need in order to load your modules from within
	// the unit test specifications.
	this.mappings[ "/yourAppRoot" ] = evaluatePathTraversal( "../" );
	this.mappings[ "/yourAppLib" ] = evaluatePathTraversal( "../lib/" );


}