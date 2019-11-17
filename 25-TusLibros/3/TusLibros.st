!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 21:04:46'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 21:18:44'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 21:05:00'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 19:56:31'!
test09EmptyCartListsToEmptyCollection

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self assert: cart list isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 20:12:06'!
test10CartListsToCollection

	| cart list |
	
	cart := testObjectsFactory createCart.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	
	list := cart list.
	self assert: (list at: (testObjectsFactory itemSellByTheStore)) equals: 3.
	self assert: list size equals: 1! !

!CartTest methodsFor: 'tests' stamp: 'gl 11/17/2019 18:32:28'!
test11CartListsToCollectionAfterMultipleAdds

	| cart list |
	
	cart := testObjectsFactory createCart.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	cart add: 1 of: testObjectsFactory anotherItemSoldByTheStore.
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	
	list := cart list.
	
	self assert: (list at: (testObjectsFactory itemSellByTheStore)) equals: 6.
	self assert: (list at: (testObjectsFactory anotherItemSoldByTheStore)) equals: 1.
	self assert: list size equals: 2! !

!CartTest methodsFor: 'tests' stamp: 'gl 11/17/2019 18:29:27'!
test12CanNotClearEmptyCart

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self should: [cart clear] raise: Error - MessageNotUnderstood withMessageText: Cart cannotClearEmptyCartErrorMessage.! !

!CartTest methodsFor: 'tests' stamp: 'gl 11/17/2019 18:33:40'!
test13CartIsEmptyAfterClearingIt

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	cart add: 1 of: testObjectsFactory anotherItemSoldByTheStore.
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	
	cart clear.
	
	self assert: cart isEmpty.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 19:34:22'!
test04CheckoutRegistersASale

	| cart cashier salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self assert: 10 equals: cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: (salesBook includes: cart).! !

!CashierTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 19:43:09'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook creditCard debitedAmout debitedCreditCard  transactionAmount |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	
	transactionAmount := cashier checkOut.
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout equals: transactionAmount.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'VPM 11/11/2019 19:59:46'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInterfaceTest category: #TusLibros!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'Cart addition' stamp: 'VPM 11/11/2019 20:02:29'!
test04CannotAddToNonExistingCart
	
	| interface cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	cartId := 1.
	
	self should: [ interface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface cartIdNotFoundMessage! !

!TusLibrosInterfaceTest methodsFor: 'Cart addition' stamp: 'VPM 11/11/2019 20:02:34'!
test05CannotAddInvalidItemToExistingCart
	
	| interface cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	self should: [ interface add: 1 of: testObjectsFactory itemNotSellByTheStore to: cartId ]
			raise: Error - MessageNotUnderstood 
			withMessageText: Cart invalidItemErrorMessage.
		
	self assert: (interface getCartById: cartId) isEmpty! !

!TusLibrosInterfaceTest methodsFor: 'Cart addition' stamp: 'VPM 11/11/2019 20:02:39'!
test06CannotAdd0ItemsToExistingCart
	
	| interface cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	self should: [ interface add: 0 of: testObjectsFactory itemNotSellByTheStore to: cartId ]
			raise: Error - MessageNotUnderstood 
			withMessageText: Cart invalidQuantityErrorMessage.
		
	self assert: (interface getCartById: cartId) isEmpty! !

!TusLibrosInterfaceTest methodsFor: 'Cart addition' stamp: 'VPM 11/11/2019 20:02:45'!
test07CannotAddNegativeQuantityItemsToExistingCart
	
	| interface cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	self should: [ interface add: -3 of: testObjectsFactory itemNotSellByTheStore to: cartId ]
			raise: Error - MessageNotUnderstood 
			withMessageText: Cart invalidQuantityErrorMessage.
		
	self assert: (interface getCartById: cartId) isEmpty! !


!TusLibrosInterfaceTest methodsFor: 'Cart creation' stamp: 'VPM 11/11/2019 20:01:32'!
test01CannotCreateCartForNotRegistredUser
	
	
	| interface |
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	self should: [ interface createCartForUser: testObjectsFactory unregistredUser withPassword: testObjectsFactory registredPassword ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface invalidUserPasswordMessage! !

!TusLibrosInterfaceTest methodsFor: 'Cart creation' stamp: 'VPM 11/11/2019 20:01:56'!
test02CannotCreateCartForWrongPassword
	
	
	| interface |
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	self should: [ interface createCartForUser: testObjectsFactory registredUser withPassword: testObjectsFactory unregistredPassword ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface invalidUserPasswordMessage! !

!TusLibrosInterfaceTest methodsFor: 'Cart creation' stamp: 'gl 11/17/2019 18:47:20'!
test03CreatesEmptyCartWhenUserPasswordCorrect
	
	| interface cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	self assert: (interface getCartById: cartId) isEmpty.
	self assert: (interface getCartOwner: cartId) = (testObjectsFactory registredUser)! !

!TusLibrosInterfaceTest methodsFor: 'Cart creation' stamp: 'VPM 11/11/2019 20:02:22'!
test08CreatesTwoDifferentCartIDsForDifferentCarts
	
	| interface cartId cartId2 |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	cartId2 := self createACartOn: interface.
	
	self deny: cartId = cartId2! !

!TusLibrosInterfaceTest methodsFor: 'Cart creation' stamp: 'gl 11/17/2019 18:52:27'!
test26CreatesTwoDifferentCartIDsForDifferentCartsAndUsers
	
	| interface cartId cartId2 |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := interface createCartForUser: testObjectsFactory registredUser withPassword: testObjectsFactory registredPassword.
	cartId2 := interface createCartForUser: testObjectsFactory registredUser2 withPassword: testObjectsFactory registredPassword.
	
	self assert: (interface getCartOwner: cartId) = (testObjectsFactory registredUser).	
	self assert: (interface getCartOwner: cartId2) = (testObjectsFactory registredUser2).
	! !


!TusLibrosInterfaceTest methodsFor: 'set up' stamp: 'VPM 11/11/2019 20:01:06'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :a :b ]! !


!TusLibrosInterfaceTest methodsFor: 'Cart listing' stamp: 'VPM 11/11/2019 20:05:28'!
test09CannotListNonExistingCart
	
	| cartId interface |
	cartId := 1.
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	self should: [ interface listCart: cartId ]
			raise: Error - MessageNotUnderstood 
			withMessageText: TusLibrosInterface cartIdNotFoundMessage ! !

!TusLibrosInterfaceTest methodsFor: 'Cart listing' stamp: 'VPM 11/11/2019 20:05:34'!
test10ListEmptyCartHasNoItems
	
	| cartId interface cartList |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	cartList := interface listCart: cartId.
	
	self assert: cartList isEmpty! !

!TusLibrosInterfaceTest methodsFor: 'Cart listing' stamp: 'VPM 11/11/2019 20:05:23'!
test11ListCartHasItsItems
	
	| cartId interface cartList |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	cartList := interface listCart: cartId.
	
	self assert: cartList size = 1.
	self assert: (cartList at: testObjectsFactory itemSellByTheStore) = 2! !


!TusLibrosInterfaceTest methodsFor: 'support' stamp: 'VPM 11/7/2019 21:06:56'!
createACartOn: anInterface
	^ anInterface createCartForUser: testObjectsFactory registredUser withPassword: testObjectsFactory registredPassword.! !

!TusLibrosInterfaceTest methodsFor: 'support' stamp: 'VPM 11/11/2019 20:00:05'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!TusLibrosInterfaceTest methodsFor: 'CartLifeTime' stamp: 'gl 11/17/2019 17:44:05'!
test18CannotListExpiredCart
	
	| cartId interface |

	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
 	interface timePassed: (Duration minutes: 30).
	
	self should: [ interface listCart: cartId ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface expiredCartMessage ! !

!TusLibrosInterfaceTest methodsFor: 'CartLifeTime' stamp: 'gl 11/17/2019 17:59:58'!
test19CannotAddToExpiredCart
	
	| cartId interface |

	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
 	interface timePassed: (Duration minutes: 30).
	
	self should: [ interface add: 10 of: testObjectsFactory itemSellByTheStore to: cartId ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface expiredCartMessage ! !

!TusLibrosInterfaceTest methodsFor: 'CartLifeTime' stamp: 'gl 11/17/2019 18:07:50'!
test20CannotCheckoutExpiredCart

 	| aCard cartId interface |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.
		
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	interface timePassed: (Duration minutes: 30).

	self should: [ interface checkout: cartId withCard: aCard on: testObjectsFactory today ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface expiredCartMessage ! !

!TusLibrosInterfaceTest methodsFor: 'CartLifeTime' stamp: 'gl 11/17/2019 17:57:21'!
test21ListsCartAfterUpdate
	
	| cartId interface |

	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
 	interface timePassed: (Duration minutes: 29).
	interface listCart: cartId.
	interface timePassed: (Duration minutes: 5).
	
	self shouldntFail: [ interface listCart: cartId ]! !

!TusLibrosInterfaceTest methodsFor: 'CartLifeTime' stamp: 'gl 11/17/2019 18:01:29'!
test22AddsToCartAfterUpdate
	
	| cartId interface |

	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
 	interface timePassed: (Duration minutes: 29).
	interface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface timePassed: (Duration minutes: 5).
	
	self shouldntFail: [ interface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId. ]! !

!TusLibrosInterfaceTest methodsFor: 'CartLifeTime' stamp: 'gl 11/17/2019 18:09:36'!
test23CheckoutCartAfterUpdate

 	| aCard cartId interface |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.
	
	interface timePassed: (Duration minutes: 29).
		
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	interface timePassed: (Duration minutes: 29).

	self shouldntFail: [ interface checkout: cartId withCard: aCard on: testObjectsFactory today ].! !



!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'a 11/11/2019 20:54:31'!
test12CannotCheckoutWhenCartNonExisting
	
	| interface aCard cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := 1.
	aCard := testObjectsFactory notExpiredCreditCard.
	
	self should: [ interface checkout: cartId withCard: aCard on: testObjectsFactory today ]
	 		raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface cartIdNotFoundMessage! !

!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'gl 11/17/2019 18:24:11'!
test13CannotCheckoutWhenCartIsEmpty
	
	| interface aCard cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.

	self should: [ interface checkout: cartId withCard: aCard on: testObjectsFactory today ]
	 		raise: Error - MessageNotUnderstood
			withMessageText: Cashier cartCanNotBeEmptyErrorMessage.
			
	self assert: (interface isCheckedOutCart: (interface getCartById: cartId))! !

!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'gl 11/17/2019 18:24:11'!
test14CannotCheckoutWhenCardIsExpired

	| interface aCard cartId |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory expiredCreditCard.
	
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	self should: [ interface checkout: cartId withCard: aCard on: testObjectsFactory today ]
	 		raise: Error - MessageNotUnderstood
			withMessageText: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
		
	self assert: (interface isCheckedOutCart: (interface getCartById: cartId))! !

!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'gl 11/17/2019 18:24:11'!
test15CannotCheckoutWhenCardHasNoFunds

 	| aCard cartId interface |
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage ].
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.
		
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	self should: [ interface checkout: cartId withCard: aCard on: testObjectsFactory today ]
	 		raise: Error - MessageNotUnderstood
			withMessageText:  Cashier creditCardHasNoCreditErrorMessage.

	self assert: (interface isCheckedOutCart: (interface getCartById: cartId))! !

!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'gl 11/17/2019 18:24:11'!
test16ChecksoutCorrectAmmountFromCorrespondingCreditCard

 	| aCard cartId interface expectedAmount expectedCreditCard |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.
		
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	debitBehavior := [ :anAmount :aCreditCard | expectedAmount := anAmount. expectedCreditCard := aCreditCard ].
	
	interface checkout: cartId withCard: aCard on: testObjectsFactory today.
	
	self assert: (2 * testObjectsFactory itemSellByTheStorePrice) equals: expectedAmount.
	self assert: aCard equals: expectedCreditCard.
	self deny: (interface isCheckedOutCart: (interface getCartById: cartId))! !

!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'gl 11/17/2019 18:24:11'!
test17CannotCheckoutAlreadyCheckedOutCart

 	| aCard cartId interface |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.
		
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface checkout: cartId withCard: aCard on: testObjectsFactory today.
	
	self should: [ interface checkout: cartId withCard: aCard on: testObjectsFactory today ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface invalidCartErrorMessage.	
	self deny: (interface isCheckedOutCart: (interface getCartById: cartId))! !

!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'gl 11/17/2019 18:12:11'!
test24CannotAddToCheckedOutCart

 	| aCard cartId interface |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.
		
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface checkout: cartId withCard: aCard on: testObjectsFactory today.
	
	self should: [ interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface invalidCartErrorMessage.! !

!TusLibrosInterfaceTest methodsFor: 'Checkout' stamp: 'gl 11/17/2019 18:17:45'!
test25CannotListCheckedOutCart

 	| aCard cartId interface |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	aCard := testObjectsFactory notExpiredCreditCard.
		
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface checkout: cartId withCard: aCard on: testObjectsFactory today.
	
	self should: [ interface listCart: cartId ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface invalidCartErrorMessage.! !


!TusLibrosInterfaceTest methodsFor: 'List purchases' stamp: 'gl 11/17/2019 19:01:12'!
test27CannotListPurchasesForNonExistingUser

	| interface |
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	self should: [ interface listPurchases: testObjectsFactory unregistredUser withPassword: testObjectsFactory registredPassword ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface invalidUserPasswordMessage! !

!TusLibrosInterfaceTest methodsFor: 'List purchases' stamp: 'gl 11/17/2019 19:02:11'!
test28CannotListPurchasesForWrongPassword
	
	| interface |
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	self should: [ interface listPurchases: testObjectsFactory registredUser withPassword: testObjectsFactory unregistredPassword ]
			raise: Error - MessageNotUnderstood
			withMessageText: TusLibrosInterface invalidUserPasswordMessage! !

!TusLibrosInterfaceTest methodsFor: 'List purchases' stamp: 'gl 11/17/2019 19:03:00'!
test29ListsEmptyPurchasesForOneUser
	
	| interface purchases |
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	purchases := interface listPurchases: testObjectsFactory registredUser withPassword: testObjectsFactory registredPassword.
	
	self assert: purchases isEmpty! !

!TusLibrosInterfaceTest methodsFor: 'List purchases' stamp: 'gl 11/17/2019 19:08:10'!
test30ListsPurchasesForOneCart
	
	| cartId interface purchases |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface add: 4 of: testObjectsFactory anotherItemSoldByTheStore to: cartId.
	
	purchases := interface listPurchases: testObjectsFactory registredUser withPassword: testObjectsFactory registredPassword.
	self assert: (purchases at: testObjectsFactory itemSellByTheStore) = 2.
	self assert: (purchases at: testObjectsFactory itemSellByTheStore) = 2.! !

!TusLibrosInterfaceTest methodsFor: 'List purchases' stamp: 'gl 11/17/2019 19:30:49'!
test31ListsPurchasesForTwoCarts
	
	| cartId interface purchases cartId2 |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := self createACartOn: interface.
	
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface add: 4 of: testObjectsFactory anotherItemSoldByTheStore to: cartId.
	
	cartId2 := self createACartOn: interface.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId2.
	interface add: 3 of: testObjectsFactory anotherItemSoldByTheStore to: cartId2.
	
	purchases := interface listPurchases: testObjectsFactory registredUser withPassword: testObjectsFactory registredPassword.
	self assert: (purchases at: testObjectsFactory itemSellByTheStore) = 3.
	self assert: (purchases at: testObjectsFactory anotherItemSoldByTheStore) = 7.! !

!TusLibrosInterfaceTest methodsFor: 'List purchases' stamp: 'gl 11/17/2019 19:32:51'!
test32ListsPurchasesForTwoUsers
	
	| cartId interface purchases cartId2 purchases2 |
	
	interface := TusLibrosInterface withUsers: testObjectsFactory usersRegisty andCatalog: testObjectsFactory defaultCatalog andMerchantProcessor: self.
	
	cartId := interface createCartForUser: testObjectsFactory registredUser withPassword: testObjectsFactory registredPassword.
	cartId2 := interface createCartForUser: testObjectsFactory registredUser2 withPassword: testObjectsFactory registredPassword.
	
	interface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface add: 4 of: testObjectsFactory anotherItemSoldByTheStore to: cartId.
	
	interface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId2.
	interface add: 3 of: testObjectsFactory anotherItemSoldByTheStore to: cartId2.
	
	purchases := interface listPurchases: testObjectsFactory registredUser withPassword: testObjectsFactory registredPassword.
	purchases2 := interface listPurchases: testObjectsFactory registredUser2 withPassword: testObjectsFactory registredPassword.
	
	self assert: (purchases at: testObjectsFactory itemSellByTheStore) = 2.
	self assert: (purchases at: testObjectsFactory anotherItemSoldByTheStore) = 4.
	
	self assert: (purchases2 at: testObjectsFactory itemSellByTheStore) = 1.
	self assert: (purchases2 at: testObjectsFactory anotherItemSoldByTheStore) = 3.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'VPM 11/7/2019 21:04:19'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: Cart invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'VPM 11/7/2019 21:18:27'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: Cart invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'VPM 11/7/2019 20:06:57'!
list
	| summary |
	
	summary := Dictionary new.
	
	items do: [ :anItem | summary at: anItem
							ifPresent: [ :amount | summary at: anItem put: (amount +1) ]
							ifAbsent: [ summary at: anItem put: 1 ]].
	
	^ summary! !

!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'clearing' stamp: 'gl 11/17/2019 18:36:46'!
clear
	items isEmpty ifTrue: [^ self error: Cart cannotClearEmptyCartErrorMessage.].
	items removeAll.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !

!Cart class methodsFor: 'instance creation' stamp: 'gl 11/17/2019 18:31:07'!
cannotClearEmptyCartErrorMessage
	
	^'Cannot clear empty cart'.! !

!Cart class methodsFor: 'instance creation' stamp: 'VPM 11/7/2019 21:04:01'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'instance creation' stamp: 'VPM 11/7/2019 21:18:14'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'VPM 11/7/2019 19:40:55'!
debitTotal

	| total |
	
	total := cart total.
	merchantProcessor debit: total from: creditCard.
	
	^ total
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'VPM 11/7/2019 19:39:05'!
registerSale

	salesBook add: cart! !


!Cashier methodsFor: 'checkout' stamp: 'VPM 11/7/2019 19:40:48'!
checkOut

	| total |
	
	total := self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'VPM 11/7/2019 20:09:57'!
anotherItemSoldByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'VPM 11/7/2019 20:10:19'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSoldByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'users' stamp: 'VPM 11/7/2019 20:21:49'!
registredPassword
	^ 'lol'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'VPM 11/7/2019 20:21:40'!
registredUser
	^ 'Guido'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'gl 11/17/2019 18:50:23'!
registredUser2
	^ 'Valen'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'VPM 11/7/2019 20:22:21'!
unregistredPassword
	^ 'otro'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'VPM 11/7/2019 20:22:15'!
unregistredUser
	^ 'otro'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'gl 11/17/2019 18:50:38'!
usersRegisty
	^ Dictionary newFromPairs: { self registredUser. self registredPassword. self registredUser2. self registredPassword.}! !


!classDefinition: #TusLibrosInterface category: #TusLibros!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'usersRegistry carts catalog lastCartId salesBook merchantProcessor cartsTimestamps cartOwners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'actions' stamp: 'gl 11/17/2019 18:17:08'!
add: aQuantity of: aBook to: aCartId
	| cart |
	cart := self getCartById: aCartId.
	
	self failUnlessValidCart: cart.
	self failIfCartExpired: aCartId.
	
	cart add: aQuantity of: aBook.
	
	self updateCartTimestamp: aCartId.! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'gl 11/17/2019 18:16:17'!
checkout: aCartId withCard: aCard on: aDate

	| cart cashier |

	cart := self getCartById: aCartId.
	
	self failUnlessValidCart: cart.
	self failIfCartExpired: aCartId.
	
	cashier := Cashier toCheckout: cart charging: aCard throught: merchantProcessor on: aDate registeringOn: salesBook.
	cashier checkOut.! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'gl 11/17/2019 18:43:37'!
clearCart: aCartId
	| cart |
	cart := self getCartById: aCartId.
	
	self failUnlessValidCart: cart.
	self failIfCartExpired: aCartId.
	
	self updateCartTimestamp: aCartId.
	^ cart clear.! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'gl 11/17/2019 19:00:41'!
createCartForUser: aUsername withPassword: aPassword
	
	| cartId |
	self failIfUserNotFound: aUsername withPassword: aPassword.
	
	cartId := self nextCartId.
	carts at: cartId put: (Cart acceptingItemsOf: catalog).
	cartsTimestamps at: cartId put: (DateAndTime now).
	cartOwners at: cartId put: aUsername.
	^ cartId
	! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'gl 11/17/2019 18:18:26'!
listCart: aCartId
	| cart |
	cart := self getCartById: aCartId.
	
	self failUnlessValidCart: cart.
	self failIfCartExpired: aCartId.
	
	self updateCartTimestamp: aCartId.
	^ cart list! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'gl 11/17/2019 19:30:15'!
listPurchases: aUsername withPassword: aPassword

	| purchased cartsIdOwnedByMe cartsPurchased |
	self failIfUserNotFound: aUsername withPassword: aPassword.
	
	purchased := Dictionary new.
	cartsPurchased := OrderedCollection new.
	
	cartsIdOwnedByMe := cartOwners select: [ :owner | owner = aUsername ].
	cartsIdOwnedByMe keysDo: [ :cartId | | cart |
		cart := self getCartById: cartId.
		(self isCheckedOutCart: cart) ifTrue: [ cartsPurchased add: cart ]
	].
	cartsPurchased do: [ :cart | | list |
		list := cart list.
		list associationsDo: [ :assoc | purchased at: assoc key
							ifPresent: [ :value | purchased at: assoc key put: (value + assoc value) ]
							ifAbsent: [ purchased at: assoc key put: assoc value ] 
			] 
	].
		
	^ purchased.! !


!TusLibrosInterface methodsFor: 'private - checks' stamp: 'gl 11/17/2019 17:49:31'!
failIfCartExpired: aCartId

	| cartTimestampDiff |
	cartTimestampDiff := (DateAndTime now) - (cartsTimestamps at: aCartId).
	cartTimestampDiff  < (Duration minutes: 30) ifFalse: [ self error: TusLibrosInterface expiredCartMessage ].
! !

!TusLibrosInterface methodsFor: 'private - checks' stamp: 'gl 11/17/2019 19:00:19'!
failIfUserNotFound: aUsername withPassword: aPassword
	(usersRegistry at: aUsername ifPresent: [ :realPass |  realPass = aPassword ] ifAbsent: [ false ])
		ifFalse: [ self error: TusLibrosInterface invalidUserPasswordMessage ]! !

!TusLibrosInterface methodsFor: 'private - checks' stamp: 'gl 11/17/2019 18:24:11'!
failUnlessValidCart: aCart

	(self isCheckedOutCart: aCart) ifFalse: [ self error: TusLibrosInterface invalidCartErrorMessage ].! !


!TusLibrosInterface methodsFor: 'private' stamp: 'VPM 11/11/2019 17:49:18'!
nextCartId
	lastCartId := lastCartId +1.
	^ lastCartId! !

!TusLibrosInterface methodsFor: 'private' stamp: 'gl 11/17/2019 17:56:36'!
updateCartTimestamp: aCartId
	cartsTimestamps at: aCartId put: (DateAndTime now)! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'gl 11/17/2019 18:44:31'!
initializeWithUserRegisty: aUsersRegisty andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor

	usersRegistry := aUsersRegisty.
	catalog := aCatalog.
	carts := Dictionary new.
	lastCartId  := 0.
	salesBook := OrderedCollection new.
	merchantProcessor := aMerchantProcessor.
	cartsTimestamps := Dictionary new.
	cartOwners := Dictionary new.! !


!TusLibrosInterface methodsFor: 'testing' stamp: 'VPM 11/7/2019 21:16:36'!
getCartById: aCartId
	
	^ carts at: aCartId ifAbsent: [ self error: TusLibrosInterface cartIdNotFoundMessage ]! !

!TusLibrosInterface methodsFor: 'testing' stamp: 'gl 11/17/2019 18:49:12'!
getCartOwner: aCartId
	^ cartOwners at: aCartId! !

!TusLibrosInterface methodsFor: 'testing' stamp: 'gl 11/17/2019 18:24:11'!
isCheckedOutCart: aCart
	^ (salesBook includes: aCart) not! !

!TusLibrosInterface methodsFor: 'testing' stamp: 'gl 11/17/2019 17:47:37'!
timePassed: aTimeDuration
	
	cartsTimestamps := cartsTimestamps collect: [ :aTimestamp | aTimestamp - aTimeDuration ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #TusLibros!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'VPM 11/7/2019 20:55:32'!
cartIdNotFoundMessage
	^ 'Cart id invalido'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'gl 11/17/2019 17:08:08'!
expiredCartMessage
	^ 'Cart is expired'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'gl 11/17/2019 18:12:21'!
invalidCartErrorMessage
	^ 'No es un carrito valido'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'VPM 11/7/2019 20:27:51'!
invalidUserPasswordMessage
	^ 'User/password combinacion invalida'! !

!TusLibrosInterface class methodsFor: 'as yet unclassified' stamp: 'VPM 11/11/2019 18:52:37'!
withUsers: aUsersRegistry andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor
	^ self new initializeWithUserRegisty: aUsersRegistry andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor! !
