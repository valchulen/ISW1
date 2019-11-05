!classDefinition: #CardTest category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:05:25'!
test01CreatesCardCorrectly
	| card |
	card := Card number: 1234567812345678 
					holder: 'Guidito MethodObject' 
					expires: (GregorianMonthOfYear year: 2000 month: January).
					
	self assert: card number equals: 1234567812345678.
	self assert: card expiration equals: (GregorianMonthOfYear year: 2000 month: January).
	self assert: card holderName equals: 'Guidito MethodObject'.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:09:02'!
test02CannotCreateCardWithLessThan16Digits
	
	self should: [ Card number: 123456781234567
					holder: 'Guidito MethodObject' 
					expires: (GregorianMonthOfYear year: 2000 month: January) ]
		raise:  Error - MessageNotUnderstood
		withMessageText: Card messageInvalidCardNumber.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:09:08'!
test03CannotCreateCardWithMoreThan16Digits
	
	self should: [ Card number: 12345678123456789
					holder: 'Guidito MethodObject' 
					expires: (GregorianMonthOfYear year: 2000 month: January) ]
		raise:  Error - MessageNotUnderstood
		withMessageText: Card messageInvalidCardNumber.! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:47:22'!
test04IsNotExpiredWhenSameMonth
	
	| card |
	
	card := Card number: 1234567812345678
					holder: 'Guidito MethodObject' 
					expires: (GregorianMonthOfYear yearNumber: 2000 month: January) .
					
	self deny: (card isExpiredOn: (FixedGregorianDate yearNumber: 2000 month: January dayNumber: 1)).! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:47:13'!
test05IsNotExpiredWhenNotExpiredByAMonth
	
	| card |
	card := Card number: 1234567812345678
					holder: 'Guidito MethodObject' 
					expires: (GregorianMonthOfYear yearNumber: 2000 month: January) .
					
	self deny: (card isExpiredOn: (FixedGregorianDate yearNumber: 1999 month: December dayNumber: 1)).! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:46:53'!
test06IsExpiredWhenExpiredByAMonth
	
	| card |
	card := Card number: 1234567812345678
					holder: 'Guidito MethodObject' 
					expires: (GregorianMonthOfYear yearNumber: 2000 month: January) .
					
	self assert: (card isExpiredOn: (FixedGregorianDate yearNumber: 2000 month: February dayNumber: 1)).! !


!classDefinition: #CartTest category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'VPM 11/3/2019 15:27:30'!
test09CartSummarizesCorrectlyForCeroItems

	| cart summary |
	
	cart := self createCart.
	
	summary := cart summary.
	
	self assert: summary isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'VPM 11/3/2019 15:27:22'!
test10CartSummarizesCorrectlyForOneItem

	| cart summary |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	summary := cart summary.
	
	self assert: (summary at: self itemSellByTheStore) = 2.
	self assert: (summary size) = 1! !

!CartTest methodsFor: 'tests' stamp: 'sjd 11/4/2019 19:04:10'!
test11CartSummarizesCorrectlyForTwoItems

	| cart summary |
	
	cart := Cart acceptingItemsOf: (Dictionary newFromPairs: { self itemSellByTheStore. 50. self itemNotSellByTheStore. 30 }).
	
	cart add: 2 of: self itemSellByTheStore.
	cart add: 1 of: self itemNotSellByTheStore.
	cart add: 1 of: self itemSellByTheStore.
	
	summary := cart summary.
	
	self assert: (summary at: self itemSellByTheStore) = 3.
	self assert: (summary at: self itemNotSellByTheStore) = 1.
	self assert: (summary size) = 2! !

!CartTest methodsFor: 'tests' stamp: 'sjd 11/4/2019 19:08:45'!
test12CartCalculatesBalanceForCeroItems
	| cart |
	
	cart := Cart acceptingItemsOf: (Dictionary newFromPairs: { self itemSellByTheStore. 50. self itemNotSellByTheStore. 30 }).
	
	self assert: (cart balance) = 0! !

!CartTest methodsFor: 'tests' stamp: 'sjd 11/4/2019 19:08:27'!
test13CartCalculatesBalanceCorrectlyForTwoItems

	| cart |
	
	cart := Cart acceptingItemsOf: (Dictionary newFromPairs: { self itemSellByTheStore. 50. self itemNotSellByTheStore. 30 }).
	
	cart add: 2 of: self itemSellByTheStore.
	cart add: 1 of: self itemNotSellByTheStore.
	cart add: 1 of: self itemSellByTheStore.
	
	self assert: (cart balance) = 180! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'sjd 11/4/2019 19:02:13'!
defaultCatalog
	
	^ Dictionary newFromPairs: { self itemSellByTheStore. 50 }! !

!CartTest methodsFor: 'support' stamp: 'VPM 11/3/2019 13:55:01'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'VPM 11/3/2019 13:55:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:50:41'!
aValidCard
	^ Card number: 1234567812345678
			holder: 'Guido Objeto metodo'
			expires: (GregorianMonthOfYear yearNumber: 2021 month: January)! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:51:07'!
anExpiredCard
	^ Card number: 1234567812345678
			holder: 'Guido Objeto metodo'
			expires: (GregorianMonthOfYear yearNumber: 2000 month: January)! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:54:35'!
test01CashierCannotCheckoutOnEmptyCart

	| aCard aCart aCashier aLedger |
	aCart := Cart acceptingItemsOf: (Dictionary newFromPairs: { 'a'. 10 }).
	aLedger := OrderedCollection new.
	aCashier := Cashier withLedger: aLedger.
	aCard := self aValidCard.
	
	self should: [ aCashier checkout: aCart with: aCard onDay: self today ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier messageEmptyCart.
	self assert: aCashier ammountCharged equals: 0.
	self assert: aLedger isEmpty.
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:54:11'!
test02CashierCannotCheckoutOnExpiredCard

	| aCard aCart aCashier aLedger |
	aCart := Cart acceptingItemsOf: (Dictionary newFromPairs: { 'a'. 10 }).
	aCart add: 'a'.
	
	aLedger := OrderedCollection new.
	aCashier := Cashier withLedger: aLedger.
	aCard := self anExpiredCard.
	
	self should: [ aCashier checkout: aCart with: aCard onDay: self today ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier messageExpiredCard.
	self assert: aCashier ammountCharged equals: 0.
	self assert: aLedger isEmpty.
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:55:02'!
test03CashierChecksOutOneCartForValidCart

	| aCard aCart aCashier aLedger |
	aCart := Cart acceptingItemsOf: (Dictionary newFromPairs: { 'a'. 10 }).
	aCart add: 'a'.
	
	aLedger := OrderedCollection new.
	aCashier := Cashier withLedger: aLedger.
	aCard := self aValidCard.
	aCashier checkout: aCart with: aCard onDay: self today.
	
	self assert: aCashier ammountCharged equals: 10.
	self assert: aLedger isEmpty.
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:54:21'!
today
	^ FixedGregorianDate yearNumber: 2019 month: November dayNumber: 4.! !


!classDefinition: #Card category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
Object subclass: #Card
	instanceVariableNames: 'number holder expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:06:01'!
expiration
	^ expiration ! !

!Card methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:05:54'!
holderName
	^ holder! !

!Card methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:11:46'!
initializeWithNumber: aNumber holder: aName expires: aMonthYear
	(aNumber numberOfDigitsInBase: 10) = 16 ifFalse: [ self error: Card messageInvalidCardNumber ].
	holder := aName.
	number := aNumber.
	expiration := aMonthYear.! !

!Card methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:33:30'!
isExpiredOn: aGregorianDate
	^ expiration < aGregorianDate monthOfYear! !

!Card methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:05:45'!
number
	^ number ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:08:26'!
messageInvalidCardNumber
	^ 'Wrong Card number'! !

!Card class methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:00:20'!
number: aNumber holder: aName expires: aMonthYear
	^ self new initializeWithNumber: aNumber holder: aName expires: aMonthYear! !


!classDefinition: #Cart category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'sjd 11/4/2019 19:03:06'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'sjd 11/4/2019 19:09:30'!
balance
	| balance |
	
	balance := 0.
	self summary associationsDo: [ :assoc | balance :=  balance + ((catalog at: assoc key) * assoc value)].
	^ balance! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'VPM 11/3/2019 15:13:59'!
summary
	| aDictionary |
	aDictionary := Dictionary new.
	
	items do: [:anItem | aDictionary at: anItem ifAbsentPut: 0.
							aDictionary at: anItem put: (aDictionary at: anItem) + 1].
	
	^aDictionary! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'sjd 11/4/2019 19:01:00'!
add: anItem
	self assertIsValidItem: anItem.
	
	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
Object subclass: #Cashier
	instanceVariableNames: 'ledger ammountCharged'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 19:52:49'!
ammountCharged
	^ ammountCharged! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 20:53:19'!
checkout: aCart with: aCard onDay: aFixedDate
	aCart isEmpty ifTrue: [ self error: Cashier messageEmptyCart ].
	(aCard isExpiredOn: aFixedDate) ifTrue: [ self error: Cashier messageExpiredCard ].
	
	ammountCharged := aCart balance.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 19:53:38'!
initializeWithLedger: aLedger
	ledger := aLedger.
	ammountCharged := 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'sjd 11/4/2019 20:55:12'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 19:19:59'!
messageEmptyCart
	^ 'Cannot purchase an empry cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 19:32:38'!
messageExpiredCard
	^ 'Cannot use an expired card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'sjd 11/4/2019 19:19:17'!
withLedger: aLedger
	^ self new initializeWithLedger: aLedger! !
