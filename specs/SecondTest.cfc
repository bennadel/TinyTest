component
	extends = "TestCase"
	output = false
	hint = ""
	{


	public void function testThatThisRuns() {

		sleep( 20 );
	
	}


	public void function testThatThatRuns() {

		
		var badComponent = new BadComponent();

		// assertTrue( badComponent.returnTrue() );

		badComponent.throwError();


	}


}