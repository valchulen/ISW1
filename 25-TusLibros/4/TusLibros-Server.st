!classDefinition: #HonestClock category: #'TusLibros-Server' stamp: 'a 12/1/2019 14:45:37'!
Object subclass: #HonestClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!HonestClock methodsFor: 'as yet unclassified' stamp: 'a 11/30/2019 19:04:01'!
now
	^ DateAndTime now! !

!HonestClock methodsFor: 'as yet unclassified' stamp: 'a 11/30/2019 19:04:24'!
today
	^ Date today! !


!classDefinition: #StringGenius category: #'TusLibros-Server' stamp: 'a 12/1/2019 14:45:37'!
Object subclass: #StringGenius
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:14:06'!
firstLetter: aWord
	
	^aWord at:1! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 17:20:09'!
substrings: aSentence
	
	^aSentence substrings! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:14:58'!
toLowercase: aWord
	
	^aWord translateToLowercase! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:14:47'!
toUppercase: aWord
	
	^aWord translateToUppercase! !

!StringGenius methodsFor: 'converting' stamp: 'NR 11/11/2019 16:44:40'!
vowels: aWord
	
	^aWord select: [:letter | letter isVowel]! !


!classDefinition: #TusLibrosServerController category: #'TusLibros-Server' stamp: 'a 12/1/2019 14:45:37'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port stringGenius hiList systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:51:52'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'NR 11/11/2019 15:54:12'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.
	! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'NR 11/11/2019 15:54:20'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !


!TusLibrosServerController methodsFor: 'initialization' stamp: 'a 12/1/2019 13:45:20'!
initializeWith: aPortNumber

	| userDatabase catalog salesBook |
	userDatabase := Dictionary new at: 'guido' put: 'saki'; yourself.
	catalog := Dictionary new at: '123' put: 5; yourself.
	salesBook := OrderedCollection new.
	
	systemFacade := TusLibrosSystemFacade authenticatingWith: userDatabase acceptingItemsOf: catalog registeringOn: salesBook debitingThrought: AlwaysOkMerchantProcessor new measuringTimeWith: HonestClock new.
	
	stringGenius := StringGenius new.
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	self register: [:req | self createCart: req ] for: '/createCart'.

	self register: [:req | self addToCart: req ] for: '/addToCart'.
	
	self register: [:req | self listCart: req ] for: '/listCart'.
	
	self register: [:req | self deleteFromCart: req ] for: '/deleteFromCart'.
	
	self register: [:req | self checkOutCart: req ] for: '/checkoutCart'.
	
	self register: [:req | self listPurchases: req ] for: '/listPurchases'.
	
	webServer addService: '/sayHi' action:[:request |	
		
		"request send200Response: (self sayRandomHi)"
		request send200Response: (self sayRandomHi asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		].
	
	webServer addService: '/substrings' action:[:request | |substringsAsJson sentence substrings |
		
		[sentence := (request fields at:'sentence').
		substrings := stringGenius substrings: sentence.
		substringsAsJson:= WebUtils jsonEncode: (substrings).
		"request send200Response: (substringsAsJson)"
		request send200Response: (substringsAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	webServer addService: '/firstLetter' action:[:request | |letterAsJson word letter |
		
		[word := (request fields at:'word').
		letter := stringGenius firstLetter: word.
		letterAsJson:= WebUtils jsonEncode: (letter asString).
		"request send200Response: (letterAsJson)"
		request send200Response: (letterAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	webServer addService: '/vowels' action:[:request | |vowelsAsJson word vowels |
		
		[word := (request fields at:'word').
		vowels := stringGenius vowels: word.
		vowelsAsJson:= WebUtils jsonEncode: (vowels).
		"request send200Response: (vowelsAsJson)"
		request send200Response: (vowelsAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	webServer addService: '/toUppercase' action:[:request | |upperCasedWordAsJson word upperCasedWord |
		
		[word := (request fields at:'word').
		upperCasedWord := stringGenius toUppercase: word.
		upperCasedWordAsJson:= WebUtils jsonEncode: (upperCasedWord).
		"request send200Response: (upperCasedWordAsJson)"
		request send200Response: (upperCasedWordAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'NR 11/11/2019 17:19:18'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	
	! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'a 11/30/2019 20:24:22'!
register: aBlock for: aURI
 	webServer addService: aURI action: [:request | self handleWith: aBlock AndFormatErrorFor: request ].
! !


!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 11/30/2019 20:43:32'!
addToCart: aRequest
	| cartId isbn quantity |
	cartId := (aRequest fields at: 'cartId') asInteger.
	isbn := aRequest fields at: 'bookIsbn'.
	quantity := (aRequest fields at: 'bookQuantity') asInteger.
		
	systemFacade add: quantity of: isbn toCartIdentifiedAs: cartId.
	aRequest send200Response: 'OK'
! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 12/1/2019 13:21:08'!
checkOutCart: aRequest
	| cartId cardExpiration cardNumber cardOwner cardExpirationMonth ticket |
	cartId := (aRequest fields at: 'cartId') asInteger.
	cardNumber := aRequest fields at: 'ccn'.
	cardExpiration := aRequest fields at: 'cced'.
	cardExpirationMonth := Month month: (cardExpiration copyFrom: 1 to: 2) asInteger year: ('20', (cardExpiration copyFrom: 3 to: 4)) asInteger.
	cardOwner := aRequest fields at: 'cco'.
	
	ticket := systemFacade checkOutCartIdentifiedAs: cartId withCreditCardNumbered: cardNumber ownedBy: cardOwner  expiringOn: cardExpirationMonth.
	aRequest send200Response: ('{ "books": ', ticket asJson, ' }')! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 11/30/2019 20:44:03'!
createCart: aRequest
	| clientId password cartId |
	clientId := aRequest fields at: 'clientId'.
	password := aRequest fields at: 'password'.
	
	cartId := systemFacade createCartFor: clientId authenticatedWith: password.
	aRequest send200Response: ('{ "cartId": ', cartId asString, ' }')
! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 11/30/2019 20:44:09'!
deleteFromCart: aRequest
	| cartId isbn quantity |
	cartId := (aRequest fields at: 'cartId') asInteger.
	isbn := aRequest fields at: 'bookIsbn'.
	quantity := (aRequest fields at: 'bookQuantity') asInteger.
	
	systemFacade delete: quantity of: isbn fromCartIdentifiedAs: cartId.
	aRequest send200Response: 'OK'
! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 11/30/2019 20:08:58'!
handleWith: aBlock AndFormatErrorFor: aRequest
	[ aBlock value: aRequest ] on: Error do: [ :error | aRequest send404Response: ('{ "error": "', error messageText , '" }') ]! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 12/1/2019 13:45:37'!
listCart: aRequest
	| cartId list serialization |

	cartId := (aRequest fields at: 'cartId') asInteger.
	
	list := systemFacade listCartIdentifiedAs: cartId.
	serialization := ''.
	list keysAndValuesDo: [ :aBook :aQuantity |
		serialization := serialization, '{ "bookIsbn": "', aBook asString, '", "quantity":', aQuantity asString, '}'
		].
	aRequest send200Response: ('{ "books": [', (serialization copyFrom: 2), '] }'). ! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 12/1/2019 14:41:29'!
listPurchases: aRequest
	| password clientId list serialization |
	clientId := aRequest fields at: 'clientId'.
	password := aRequest fields at: 'password'.
	
	list := systemFacade listPurchasesOf: clientId authenticatingWith: password.
	serialization := ''.
	list keysAndValuesDo: [ :aBook :aQuantity |
		serialization := serialization, '{ "bookIsbn": "', aBook asString, '", "price":', (systemFacade priceOf: aBook) asString, ', "spent":', aQuantity asString, '}'
		].
	aRequest send200Response: ('{ "books": [', (serialization copyFrom: 2), '] }'). ! !


!TusLibrosServerController methodsFor: 'private' stamp: 'NR 6/24/2019 07:16:54'!
hiList
	
	^OrderedCollection with: 'Hi!!' with: 'Hodor!!' with: 'I am Groot!!' with: 'My name is Homer Simp... Doh!!' with: 'I am inevitable...' with: 'Because Im Baaaatman!!'.
	
	! !

!TusLibrosServerController methodsFor: 'private' stamp: 'NR 6/24/2019 07:15:43'!
sayRandomHi
	
	^hiList at: (hiList size atRandom).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Server' stamp: 'a 12/1/2019 14:45:37'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'NR 11/11/2019 15:43:02'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #AlwaysOkMerchantProcessor category: #'TusLibros-Server' stamp: 'a 12/1/2019 14:45:37'!
MerchantProcessor subclass: #AlwaysOkMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!AlwaysOkMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'a 11/30/2019 18:44:32'!
debit: anAmount from: aCreditCard

	^ 'Transid'! !
