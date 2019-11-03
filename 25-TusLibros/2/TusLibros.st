!classDefinition: #CartTest category: #TusLibros stamp: 'VPM 11/3/2019 15:58:14'!
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

!CartTest methodsFor: 'tests' stamp: 'VPM 11/3/2019 15:26:57'!
test11CartSummarizesCorrectlyForTwoItems

	| cart summary |
	
	cart := Cart acceptingItemsOf: (Set with: self itemSellByTheStore with: self itemNotSellByTheStore).
	
	cart add: 2 of: self itemSellByTheStore.
	cart add: 1 of: self itemNotSellByTheStore.
	cart add: 1 of: self itemSellByTheStore.
	
	summary := cart summary.
	
	self assert: (summary at: self itemSellByTheStore) = 3.
	self assert: (summary at: self itemNotSellByTheStore) = 1.
	self assert: (summary size) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'VPM 11/3/2019 15:04:53'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'VPM 11/3/2019 13:55:01'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'VPM 11/3/2019 13:55:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CheckoutTest category: #TusLibros stamp: 'VPM 11/3/2019 15:58:14'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 14:53:18'!
catalog
	^ Dictionary newFromPairs: { 'an item'. 50. 'another item'. 30 }! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:22:13'!
test01CartHasAllItemsInCart

	| aCart aCheckout |
	aCart := Cart acceptingItemsOf: self catalog keys.
	
	aCheckout := Checkout withCatalog: self catalog.
	
	self assert: (aCheckout acceptsAllItemsOf: aCart)
	! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:22:35'!
test02CartHasItemsNotInCheckoutsCatalog

	| aCart aCheckout |
	aCart := Cart acceptingItemsOf: (Set with: 'aaa').
	
	aCheckout := Checkout withCatalog: self catalog.
	
	aCart add: 'aaa'.
	
	self deny: (aCheckout acceptsAllItemsOf: aCart)
	! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:36:42'!
test03CheckoutCannotCalculateBalanceForCartWithUnknownItems
	
	| aCart aCheckout |
	aCart := Cart acceptingItemsOf: (Set with: 'aa').
	
	aCart add: 1 of: 'aa'.
	
	aCheckout := Checkout withCatalog: self catalog.
	
	self should: [ aCheckout balanceFor: aCart ]
		raise: Error - MessageNotUnderstood
		withMessageText: aCheckout itemsNotInCatalogError! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:49:14'!
test04CheckoutCalculatesBalanceForCart

	| aCart aCheckout items |
	
	items := self catalog keys.
	aCart := Cart acceptingItemsOf: items.
	
	aCart add: 2 of: 'an item'.
	aCart add: 1 of: 'another item'.
	
	aCheckout := Checkout withCatalog: self catalog.
	
	self assert: (aCheckout balanceFor: aCart) = 130! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:58:06'!
test05CheckoutBuysCartWithAValidCard

	| aCart aCheckout items aCard |
	
	items := self catalog keys.
	aCart := Cart acceptingItemsOf: items.
	
	aCart add: 2 of: 'an item'.
	aCart add: 1 of: 'another item'.
	
	aCheckout := Checkout withCatalog: self catalog.
	
	aCard := 0.
	
	self shouldntFail: [ aCheckout buy: aCart with: aCard ]! !


!classDefinition: #Cart category: #TusLibros stamp: 'VPM 11/3/2019 15:58:14'!
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


!Cart methodsFor: 'assertions' stamp: 'VPM 11/3/2019 15:05:46'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


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


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'VPM 11/3/2019 15:58:14'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Checkout category: #TusLibros stamp: 'VPM 11/3/2019 15:58:14'!
Object subclass: #Checkout
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Checkout methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:20:33'!
acceptsAllItemsOf: aCart
	^ catalog keys includesAllOf: (aCart summary keys)! !

!Checkout methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:47:14'!
balanceFor: aCart
	| balance |
	(self acceptsAllItemsOf: aCart) ifFalse: [ self error: self itemsNotInCatalogError ].
	balance := 0.
	aCart summary associationsDo: [ :assoc | balance :=  balance + ((catalog at: assoc key) * assoc value)].
	^ balance
	! !

!Checkout methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:56:34'!
buy: aCart with: aCard

	| balance |
	balance := self balanceFor: aCart.
	
	self debit: balance fromCard: aCard.! !

!Checkout methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:57:14'!
debit: anAmmount fromCard: aCard

	^ 'does something'! !

!Checkout methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 14:59:19'!
initializeWithCatalog: aCatalog
	catalog := aCatalog ! !

!Checkout methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 15:37:13'!
itemsNotInCatalogError
	^ 'Items in cart not found in catalog'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Checkout class' category: #TusLibros stamp: 'VPM 11/3/2019 15:58:14'!
Checkout class
	instanceVariableNames: ''!

!Checkout class methodsFor: 'as yet unclassified' stamp: 'VPM 11/3/2019 14:58:28'!
withCatalog: aCatalog
	^ self new initializeWithCatalog: aCatalog! !
