component accessors="true" {
	
	property name="baseURL" type="string" 	default="https://od-api.oxforddictionaries.com/api/v1";
	property name="appID"	type="string"	default="";
	property name="appKey"	type="string"	default="";
	
	/**
	* Constructor method
	* @appID The application ID.
	* @appKey The application key.
	* @baseURL The API base URL.
	*/
	public OxfordDictionary function init(
		required string appID,
		required string appKey,
		string baseURL
	){
		setAppID( arguments.appID );
		setAppKey( arguments.appKey );
		if( len( arguments.baseURL ) ){
			setBaseURL( arguments.baseURL );
		}
		return this;
	}
		
	/*****************************************
	*           Dictionary Entries           *
	*****************************************/
	
	/**
	* Retrieve available dictionary entries for a given word and language.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	* @region Region filter parameter. gb = Great Britain English. us = United States English. Default is gb.
	*/
	public function getWordEntries(
		required string word,
		string language = 'en',
		string region = 'gb',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#';
		if( len( arguments.region ) ){
			strURL = strURL & '/regions=#arguments.region#';
		}
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Apply filters to entry search. Find available dictionary entries for given word and language. Filter results by categories.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	* @filters Separate filtering conditions using a semicolon. Conditions take values grammaticalFeatures and/or lexicalCategory and are case-sensitive. To list multiple values in single condition divide them with comma.
	*/
	public function filterWordEntries(
		required string word,
		string language = 'en',
		string filters = '',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/#arguments.filters#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Retrieve only definitions in entry search. Find available dictionary entries for given word and language. Filter results by categories.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	*/
	public function getDefinitions(
		required string word,
		string language = 'en',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/definitions';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Retrieve only example sentences in entry search. Find available dictionary entries for given word and language. Filter results by categories.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	*/
	public function getExamples(
		required string word,
		string language = 'en',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/examples';
		return makeRequest( strURL, arguments.deserialize );
	}

	
	/*****************************************
	*               Lemmatron                *
	*****************************************/
	
	/**
	* Retrieve available lemmas for a given inflected wordform.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	*/
	public function getInflections(
		required string word,
		string language = 'en',
		boolean deserialize
	){
		var strURL = '/inflections/#arguments.language#/#lowerCaseWord( arguments.word )#/pronunciations';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Apply filters to Lemmatrong response. Retrieve available lemmas for a given inflected wordform. Filter results by categories.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	* @filters Separate filtering conditions using a semicolon. Conditions take values grammaticalFeatures and/or lexicalCategory and are case-sensitive. To list multiple values in single condition divide them with comma.
	*/
	public function filterInflections(
		required string word,
		string language = 'en',
		string filters = '',
		boolean deserialize
	){
		var strURL = '/inflections/#arguments.language#/#lowerCaseWord( arguments.word )#/#arguments.filters#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/*****************************************
	*               Translation              *
	*****************************************/
	
	/**
	* Find translation for a given word. Returns target language translations for a given word ID and source language. In the event that a word in the dataset does not have a direct translation, the response will be a definition in the target language.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	* @target_language IANA language code
	*/
	public function getTranslation(
		required string word,
		string language = 'en',
		string target_language = 'es',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/translations=#arguments.target_language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	
	/*****************************************
	*               Wordlist                *
	*****************************************/

	/**
	* Retrieve list of words for category. Retrieve list of words for particular domain, lexical category, register and/or region.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	* @filters Semicolon separated list of wordlist parameters, presented as value pairs: LexicalCategory, domains, regions, registers. Parameters can take comma separated list of values. E.g., lexicalCategory=noun,adjective;domains=sport. Number of values limited to 5.
	* @limit Limit the number of results per response. Default and maximum limit is 5000.
	* @offset Offset the start number of the result.
	*/
	public function getWordListBasicFilter(
		required string word,
		string language = 'en',
		string limit = '5000',
		string offset = '',
		boolean deserialize
	){
		var strURL = '/wordlist/#arguments.language#/#lowerCaseWord( arguments.word )#/#arguments.filters#?limit=#arguments.limit#';
		if( len( arguments.offset ) ){
			strURL = strURL & '&offset=#arguments.offset#';
		}
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Retrieve list of words for category with advanced options. Advanced options for retrieving wordlist - exclude filter, filter by word length or match by substring (prefix).
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	* @filters Semicolon separated list of wordlist parameters, presented as value pairs: LexicalCategory, domains, regions, registers. Parameters can take comma separated list of values. E.g., lexicalCategory=noun,adjective;domains=sport. Number of values limited to 5.
	* @exclude Semicolon separated list of parameters-value pairs (same as filters). Excludes headwords that have any senses in specified exclusion attributes (lexical categories, domains, etc.) from results.
	* @exclude_senses Semicolon separated list of parameters-value pairs (same as filters). Excludes those senses of a particular headword that match specified exclusion attributes (lexical categories, domains, etc.) from results but includes the headword if it has other permitted senses.
	* @exclude_prime_senses Semicolon separated list of parameters-value pairs (same as filters). Excludes a headword only if the primary sense matches the specified exclusion attributes (registers, domains only).
	* @word_length Parameter to speficy the minimum (>), exact or maximum (<) length of the words required. E.g., >5 - more than 5 chars; <4 - less than 4 chars; >5<10 - from 5 to 10 chars; 3 - exactly 3 chars.
	* @prefix Filter words that start with prefix parameter.
	* @exact If exact=true wordlist returns a list of entries that exactly matches the search string. Otherwise wordlist lists entries that start with prefix string.
	* @limit Limit the number of results per response. Default and maximum limit is 5000.
	* @offset Offset the start number of the result.
	*/
	public function getWordListAdvancedFilter(
		required string word,
		string language = 'en',
		string exclude = '',
		string exclude_senses = '',
		string exclude_prime_senses = '',
		string word_length = '',
		string prefix = '',
		boolean exact = false,
		string limit = '5000',
		string offset = '',
		boolean deserialize
	){
		var strURL = '/wordlist/#arguments.language#/#lowerCaseWord( arguments.word )#/#arguments.filters#&exact=#arguments.exact#';
		if( len( arguments.exclude ) ){
			strURL = strURL & '&exclude=#arguments.exclude#';
		}
		if( len( arguments.exclude_senses ) ){
			strURL = strURL & '&offset=#arguments.exclude_senses#';
		}
		if( len( arguments.exclude_prime_senses ) ){
			strURL = strURL & '&offset=#arguments.exclude_prime_senses#';
		}
		if( len( arguments.word_length ) ){
			strURL = strURL & '&offset=#arguments.word_length#';
		}
		if( len( arguments.prefix ) ){
			strURL = strURL & '&prefix=#arguments.prefix#';
		}
		if( len( arguments.limit ) ){
			strURL = strURL & '&limit=#arguments.limit#';
		}
		if( len( arguments.offset ) ){
			strURL = strURL & '&offset=#arguments.offset#';
		}
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/*****************************************
	*               Thesaurus                *
	*****************************************/
	
	/**
	* Retrieve synonyms for a given word. Retrieve available synonyms for a given word and language.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	*/
	public function getSynonyms(
		required string word,
		string language = 'en',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/synonyms';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Retrieve antonyms for a given word. Retrieve available antonyms for a given word and language.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	*/
	public function getAntonyms(
		required string word,
		string language = 'en',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/antonyms';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Retrieve synonyms and antonyms for a given word. Retrieve available synonyms and antonyms for a given word and language.
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	*/
	public function getSynonymsAndAntonyms(
		required string word,
		string language = 'en',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/synonyms;antonyms';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	
	/*****************************************
	*                Search                  *
	*****************************************/
	
	/**
	* Retrieve available results for a search query and language.
	* @language IANA language code.
	* @q Search string
	* @prefix Set prefix to true if you'd like to get results only starting with search string.
	* @regions Filter words with specific region(s) E.g., regions=us. For now gb, us are available for en language.
	* @limit Limit the number of results per response. Default and maximum limit is 5000.
	* @offset Offset the start number of the result.
	*/
	public function getSearch(
		required string language,
		required string q,
		boolean prefix = false,
		string regions = '',
		string limit = '5000',
		string offset = '',
		boolean deserialize
	){
		var strURL = '/search/#arguments.language#?q=#arguments.q#&prefix=#arguments.prefix#';
		
		if( len( arguments.regions ) ){
			strURL = strURL & '&regions=#arguments.regions#';
		}
		if( len( arguments.limit ) ){
			strURL = strURL & '&limit=#arguments.limit#';
		}
		if( len( arguments.offset ) ){
			strURL = strURL & '&offset=#arguments.offset#';
		}
		
		return makeRequest( strURL, arguments.deserialize );
	}
	
	
	/**
	* Find translation results for a search query and language.
	* @language IANA language code.
	* @target_language IANA language code.
	* @q Search string
	* @prefix Set prefix to true if you'd like to get results only starting with search string.
	* @regions Filter words with specific region(s) E.g., regions=us. For now gb, us are available for en language.
	* @limit Limit the number of results per response. Default and maximum limit is 5000.
	* @offset Offset the start number of the result.
	*/
	public function getTranslationSearch(
		required string language,
		required string target_language,
		required string q,
		boolean prefix = false,
		string regions = '',
		string limit = '5000',
		string offset = '',
		boolean deserialize
	){
		var strURL = '/search/#arguments.language#?translations=#arguments.target_language#&q=#arguments.q#&prefix=#arguments.prefix#';
		
		if( len( arguments.regions ) ){
			strURL = strURL & '&regions=#arguments.regions#';
		}
		if( len( arguments.limit ) ){
			strURL = strURL & '&limit=#arguments.limit#';
		}
		if( len( arguments.offset ) ){
			strURL = strURL & '&offset=#arguments.offset#';
		}
		
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/*****************************************
	*        The Sentence Dictionary         *
	*****************************************/

	/**
	* Retrieve corpus sentences for a given word. Retrieve list of sentences and list of senses (English language only).
	* @word An Entry identifier. Case-sensitive.
	* @language IANA language code.
	*/
	public function getSentences(
		required string word,
		string language = 'en',
		boolean deserialize
	){
		var strURL = '/entries/#arguments.language#/#lowerCaseWord( arguments.word )#/sentences';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/*****************************************
	*               Utilities                *
	*****************************************/

	/**
	* Lists available monolingual and bilingual language datasets in the API.
	* @source_language IANA language code. If provided output will be filtered by sourceLanguage.
	* @target_language IANA language code. If provided output will be filtered by sourceLanguage.
	*/
	public function getLanguages(
		string source_language,
		string target_language,
		boolean deserialize
	){
		var strURL = '/languages';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Lists available filters. Returns a list of all the valid filters to construct API calls.
	*/
	public function getFilters(
		boolean deserialize
	){
		var strURL = '/filters';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Lists available filters for a specific endpoint. Returns a list of all the valid filters for a given endpoint to construct API calls.
	* @endpoint Name of the endpoint.
	*/
	public function getFiltersByEndpoint(
		required string endpoint,
		boolean deserialize
	){
		var strURL = '/filters/#arguments.endpoint#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Returns a list of available lexical categories for a given language dataset.
	* @language IANA language code.
	*/
	public function getLexicalCategories(
		required string language,
		boolean deserialize
	){
		var strURL = '/lexicalcategories/#arguments.language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Returns a list of the available registers for a given monolingual language dataset.
	* @source_language IANA language code.
	*/
	public function getLanguageRegisters(
		required string source_language,
		boolean deserialize
	){
		var strURL = '/registers/#arguments.source_language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Returns a list of the available registers for a given bilingual language dataset.
	* @source_language IANA language code.
	* @target_language IANA language code.
	*/
	public function getBilingualLanguageRegisters(
		required string source_language,
		required string target_language,
		boolean deserialize
	){
		var strURL = '/registers/#arguments.source_language#/#arguments.target_language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Returns a list of the available domains for a given monolingual language dataset.
	* @source_language IANA language code.
	*/
	public function getLanguageDomains(
		required string source_language,
		boolean deserialize
	){
		var strURL = '/domains/#arguments.source_language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Returns a list of the available domains for a given bilingual language dataset.
	* @source_language IANA language code.
	* @target_language IANA language code.
	*/
	public function getBilingualLanguageDomains(
		required string source_language,
		required string target_language,
		boolean deserialize
	){
		var strURL = '/domains/#arguments.source_language#/#arguments.target_language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Returns a list of the available regions for a given monolingual language dataset.
	* @source_language IANA language code.
	*/
	public function getLanguageRegions(
		required string source_language,
		boolean deserialize
	){
		var strURL = '/regions/#arguments.source_language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	/**
	* Returns a list of the available grammatical features for a given monolingual language dataset.
	* @source_language IANA language code.
	*/
	public function getLanguageGrammaticalFeatures(
		required string source_language,
		boolean deserialize
	){
		var strURL = '/grammaticalFeatures/#arguments.source_language#';
		return makeRequest( strURL, arguments.deserialize );
	}
	
	
	
	/*****************************************
	*           Internal Utilities           *
	*****************************************/
	
	private function makeRequest(
		required string url,
		boolean deserialize = false
	){
		var httpService = new http( method="GET", url=getBaseURL() & arguments.url );
		httpService.addParam( name="app_id", type="header", value=getAppID() );
		httpService.addParam( name="app_key", type="header", value=getAppKey() );
		var result = httpService.send().getPrefix();
		return ( arguments.deserialize ) ? deserializeJSON( result.fileContent ) : result.fileContent;
	}
	
	private string function lowerCaseWord( required string word ){
		return lCase( arguments.word );
	}
}  