!classDefinition: #HonestClock category: #'TusLibros-Server' stamp: 'a 12/1/2019 15:49:04'!
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


!classDefinition: #TusLibrosServerController category: #'TusLibros-Server' stamp: 'a 12/1/2019 15:49:04'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port systemFacade salesBook'
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


!TusLibrosServerController methodsFor: 'initialization' stamp: 'a 12/1/2019 15:48:57'!
initializeWith: aPortNumber
	salesBook := OrderedCollection new.
	
	systemFacade := TusLibrosSystemFacade authenticatingWith: self userDatabase
														acceptingItemsOf: self catalog
														registeringOn: salesBook
														debitingThrought: AlwaysOkMerchantProcessor new
														measuringTimeWith: HonestClock new.
	
	port := aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	self register: [:req | self createCart: req ] for: '/createCart'.

	self register: [:req | self addToCart: req ] for: '/addToCart'.
	
	self register: [:req | self listCart: req ] for: '/listCart'.
	
	self register: [:req | self deleteFromCart: req ] for: '/deleteFromCart'.
	
	self register: [:req | self checkOutCart: req ] for: '/checkoutCart'.
	
	self register: [:req | self listPurchases: req ] for: '/listPurchases'.
	
	self register: [:req | self listActive: req ] for: '/listActiveCarts'.
	
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


!TusLibrosServerController methodsFor: 'database' stamp: 'a 12/1/2019 15:47:50'!
catalog
	^ Dictionary new
		at: '0' put: 10;
		at: '1' put: 6;
		at: '2' put: 25;
		at: '3' put: 8;
		at: '4' put: 4;
		at: '5' put: 10;
		at: '6' put: 6;
		at: '7' put: 25;
		at: '8' put: 8;
		at: '9' put: 4;
		at: '10' put: 10;
		at: '11' put: 6;
		at: '12' put: 25;
		at: '13' put: 8;
		at: '14' put: 4;
		at: '15' put: 4;
		yourself.! !

!TusLibrosServerController methodsFor: 'database' stamp: 'a 12/1/2019 15:44:42'!
userDatabase
	^ Dictionary new
		at: 'Guido' put: '5678';
		at: 'Valentin' put: '1234';
		at: 'Hernan' put: 'cuis';
		at: 'Harry' put: 'potter';
		at: 'Archie' put: 'betty';
		yourself.! !


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

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 12/1/2019 15:32:09'!
listActive: aRequest
	| password clientId active serialization |
	clientId := aRequest fields at: 'clientId'.
	password := aRequest fields at: 'password'.
	
	active := systemFacade listActiveCartsFor: clientId authenticatingWith: password.
	serialization := ''.
	active do: [ :cartId | serialization := serialization, (cartId asString), ',' ].

	aRequest send200Response: ('{ "books": [', (serialization copyFrom:1 to: (serialization size -1)), '] }'). ! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 12/1/2019 15:30:00'!
listCart: aRequest
	| cartId list serialization |

	cartId := (aRequest fields at: 'cartId') asInteger.
	
	list := systemFacade listCartIdentifiedAs: cartId.
	serialization := ''.
	list keysAndValuesDo: [ :aBook :aQuantity |
		serialization := serialization, '{ "bookIsbn": "', aBook asString, '", "quantity":', aQuantity asString, '},'
		].
	aRequest send200Response: ('{ "books": [', (serialization copyFrom:1 to: (serialization size -1)), '] }'). ! !

!TusLibrosServerController methodsFor: 'handlers' stamp: 'a 12/1/2019 15:30:20'!
listPurchases: aRequest
	| password clientId list serialization |
	clientId := aRequest fields at: 'clientId'.
	password := aRequest fields at: 'password'.
	
	list := systemFacade listPurchasesOf: clientId authenticatingWith: password.
	serialization := ''.
	list keysAndValuesDo: [ :aBook :aQuantity |
		serialization := serialization, '{ "bookIsbn": "', aBook asString, '", "price":', (systemFacade priceOf: aBook) asString, ', "spent":', aQuantity asString, '},'
		].
	aRequest send200Response: ('{ "books": [', (serialization copyFrom:1 to: (serialization size -1)), '] }'). ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Server' stamp: 'a 12/1/2019 15:49:04'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'NR 11/11/2019 15:43:02'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #AlwaysOkMerchantProcessor category: #'TusLibros-Server' stamp: 'a 12/1/2019 15:49:04'!
MerchantProcessor subclass: #AlwaysOkMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!AlwaysOkMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'a 11/30/2019 18:44:32'!
debit: anAmount from: aCreditCard

	^ 'Transid'! !
