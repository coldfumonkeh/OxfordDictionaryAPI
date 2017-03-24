/**
* Matt Gifford, Monkeh Works
* www.monkehworks.com
* ---
* This module connects your application to the Oxford Dictionary API
**/
component {

	// Module Properties
	this.title 				= "Oxford Dictionary API";
	this.author 			= "Matt Gifford";
	this.webURL 			= "https://www.monkehworks.com";
	this.description 		= "This SDK will provide you with connectivity to the Oxford Dictionary API for any ColdFusion (CFML) application.";
	this.version			= "@version.number@+@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	this.entryPoint			= 'oxforddictionary';
	this.modelNamespace		= 'oxforddictionary';
	this.cfmapping			= 'oxforddictionary';
	this.autoMapModels 		= false;

	/**
	 * Configure
	 */
	function configure(){

		// Settings
		settings = {
			appID = '',
			appKey = ''
		};
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		parseParentSettings();
		var oxfordDictionarySettings = controller.getConfigSettings().oxforddictionary;

		// Map Library
		binder.map( "oxforddictionary@oxforddictionary" )
			.to( "#moduleMapping#.oxforddictionary" )
			.initArg( name="appID",      value=oxfordDictionarySettings.appID )
			.initArg( name="appKey",     value=oxfordDictionarySettings.appKey );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
	}

	/**
	* parse parent settings
	*/
	private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var odDSL 		= oConfig.getPropertyMixin( "oxforddictionary", "variables", structnew() );

		//defaults
		configStruct.oxforddictionary = variables.settings;

		// incorporate settings
		structAppend( configStruct.oxforddictionary, odDSL, true );
	}

}
