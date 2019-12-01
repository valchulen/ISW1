!classDefinition: #CartTest category: #'TusLibros-Tests' stamp: 'a 12/1/2019 15:49:09'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
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

!CartTest methodsFor: 'tests' stamp: 'VPM 11/7/2019 20:11:28'!
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

!CartTest methodsFor: 'tests' stamp: 'a 11/30/2019 17:18:02'!
test12CartCannotDeleteNonAddedItem

	| cart list |
	
	cart := testObjectsFactory createCart.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	
	list := cart list.
	self should: [ cart delete: 1 of: testObjectsFactory anotherItemSellByTheStore ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart invalidQuantityErrorMessage.
			self assert: (list at: (testObjectsFactory itemSellByTheStore)) equals: 3.
			self assert: list size equals: 1 ]! !

!CartTest methodsFor: 'tests' stamp: 'a 11/30/2019 16:47:41'!
test13CartDeletesOneItemWhenOneExisting

	| cart list |
	
	cart := testObjectsFactory createCart.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	cart add: 1 of: testObjectsFactory anotherItemSellByTheStore.
	
	cart delete: 1 of: testObjectsFactory anotherItemSellByTheStore.
	
	list := cart list.
	self assert: (list at: (testObjectsFactory itemSellByTheStore)) equals: 3.
	self assert: list size equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'a 11/30/2019 17:04:31'!
test14CartDeletesOneItemAndThenAddsOne

	| cart list |
	
	cart := testObjectsFactory createCart.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	cart add: 2 of: testObjectsFactory anotherItemSellByTheStore.
	
	cart delete: 1 of: testObjectsFactory anotherItemSellByTheStore.
	cart add: 1 of: testObjectsFactory anotherItemSellByTheStore.
	
	list := cart list.
	self assert: (list at: (testObjectsFactory itemSellByTheStore)) equals: 3.
	self assert: (list at: (testObjectsFactory anotherItemSellByTheStore)) equals: 2.
	self assert: list size equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'a 11/30/2019 17:03:49'!
test14CartDeletesOneItemWhenTwoExisting

	| cart list |
	
	cart := testObjectsFactory createCart.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.
	cart add: 2 of: testObjectsFactory anotherItemSellByTheStore.
	
	cart delete: 1 of: testObjectsFactory anotherItemSellByTheStore.
	
	list := cart list.
	self assert: (list at: (testObjectsFactory itemSellByTheStore)) equals: 3.
	self assert: (list at: (testObjectsFactory anotherItemSellByTheStore)) equals: 1.
	self assert: list size equals: 2.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #'TusLibros-Tests' stamp: 'a 12/1/2019 15:49:09'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |

	salesBook := OrderedCollection new.
	self
		should: [ Cashier
			toCheckout: testObjectsFactory createCart
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.

	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	self
		should: [ Cashier
				toCheckout: cart
				ownedBy: testObjectsFactory customer
				charging: testObjectsFactory expiredCreditCard
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	total := cashier checkOut total.

	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.

	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
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


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosSystemFacadeTest category: #'TusLibros-Tests' stamp: 'a 12/1/2019 15:49:09'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'a 11/30/2019 17:56:15'!
test04CanAddItemsToACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self assert: ((systemFacade listCartIdentifiedAs: cartId) at: self validBook) equals: 1
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HAW 11/26/2018 18:03:02'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HAW 11/26/2018 18:03:17'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidItemErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'HAW 11/26/2018 18:03:58'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'a 12/1/2019 15:35:38'!
test33CanNotAddToCartAlreadyCheckedOut

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	self
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade cartAlreadyCheckedout .
			self assert: ((systemFacade listCartIdentifiedAs: cartId) at: self validBook) equals: 2 ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:07:48'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: '1111222233334444'
		ownedBy: 'Juan Perez'
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) equals: (testObjectsFactory itemSellByTheStorePrice * 2).
	self assert: (purchases at: self anotherValidBook) equals: testObjectsFactory anotherItemSellByTheStorePrice.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:29'!
test15CanNotListPurchasesOfInvalidCustomer

	self
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:45'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self
		should: [systemFacade listPurchasesOf: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'a 12/1/2019 14:45:18'!
test24GivesBackPriceForAnExistingItem

	| price |
	price := systemFacade priceOf: self validBook.
	self assert: testObjectsFactory itemSellByTheStorePrice equals: price.! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 6/19/2018 11:40:51'!
test01CanCreateCartWithValidUserAndPassword

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:23'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:33'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard
! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2015 20:53'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook

	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'a 12/1/2019 15:00:40'!
anotherValidUser
	^ 'valen'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId

	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword

	^'invalidPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook

	^testObjectsFactory itemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser

	^'validUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword

	^'validUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'a 12/1/2019 15:01:10'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		at: self anotherValidUser put: self validUserPassword;
		yourself! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 6/19/2018 11:45:13'!
test10CanCheckoutACart

	| cartId purchases |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) equals: testObjectsFactory itemSellByTheStorePrice.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:05:20'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade
			checkOutCartIdentifiedAs: self invalidCartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:06:07'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade cartCanNotBeEmptyErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:07:02'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:07:15'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self should: [
		systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]


	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'a 11/30/2019 19:35:31'!
test23CannotCheckOutCartAlreadyCheckedout

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
			
	self should: [ systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear
	]	raise: Error - MessageNotUnderstood
		withMessageText: systemFacade cartAlreadyCheckedout.


	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:15'!
test08CanNotListCartOfInvalidCartId

	self
		should: [systemFacade listCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'a 11/30/2019 17:56:29'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.

	self assert: (cartContent at: self validBook) equals: 1.
	self assert: (cartContent at: self anotherValidBook) equals: 2
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:42'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration

	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration

	clock revertTime: aDuration ! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 14:49:28'!
test25CannotListActiveCartsForWrongUser

	
	self should: [ systemFacade listActiveCartsFor: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood 
		withMessageText: systemFacade invalidUserAndOrPasswordErrorDescription! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 14:50:46'!
test26CannotListActiveCartsForWrongPassword

	
	self should: [ systemFacade listActiveCartsFor: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood 
		withMessageText: systemFacade invalidUserAndOrPasswordErrorDescription! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 14:51:55'!
test27ActiveCartsIsEmptyWhenNoActiveCarts

	| active |
	
	active := systemFacade listActiveCartsFor: self validUser authenticatingWith: self validUserPassword.
	self assert: (active isEmpty).! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 14:58:47'!
test28ListsCorrectActiveCartWhenOneCreated

	| active cartId |
	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	active := systemFacade listActiveCartsFor: self validUser authenticatingWith: self validUserPassword.
	
	self assert: 1 equals: active size.
	self assert: 1 equals: (active occurrencesOf: cartId).! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 15:00:23'!
test29ListsAUsersActiveCartButNotAllActiveCarts

	| active cartId |
	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade createCartFor: self anotherValidUser authenticatedWith: self validUserPassword.
	active := systemFacade listActiveCartsFor: self validUser authenticatingWith: self validUserPassword.
	
	self assert: 1 equals: active size.
	self assert: 1 equals: (active occurrencesOf: cartId).! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 15:06:51'!
test30ListsEmptyActiveCartsWhenCartsExpired

	| active |
	systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes).

	active := systemFacade listActiveCartsFor: self validUser authenticatingWith: self validUserPassword.
	
	self assert: (active isEmpty)! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 15:11:34'!
test31ListsOneActiveCartWhenOnlyOneIsExpired

	| active cartId |
	systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes).
	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	active := systemFacade listActiveCartsFor: self validUser authenticatingWith: self validUserPassword.
	
	self assert: 1 equals: (active size).
	self assert: 1 equals: (active occurrencesOf: cartId).! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - lists active carts' stamp: 'a 12/1/2019 15:18:40'!
test32DoesNotListCheckedOutCart

	| active cartId |
	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 3 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	active := systemFacade listActiveCartsFor: self validUser authenticatingWith: self validUserPassword.
	
	self assert: (active isEmpty).! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'a 11/30/2019 17:56:42'!
test20CanDeleteItemsFromCreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade delete: 1 of: self anotherValidBook fromCartIdentifiedAs: cartId.
	
	self assert: ((systemFacade listCartIdentifiedAs: cartId) at: self validBook) equals: 2.
	self assert: ((systemFacade listCartIdentifiedAs: cartId) at: self anotherValidBook) equals: 1.
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'a 11/30/2019 17:56:48'!
test21CannotDeleteItemsIfCartHasNoneOfThoseItems

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	
	self should: [ systemFacade delete: 1 of: self anotherValidBook fromCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidQuantityErrorMessage.
			self assert: ((systemFacade listCartIdentifiedAs: cartId) at: self validBook) equals: 2.
			]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'a 11/30/2019 17:20:56'!
test22CannotDeleteItemsWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	
	self
		should: [systemFacade delete: 2 of: self validBook fromCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
	! !


!classDefinition: #ManualClock category: #'TusLibros-Tests' stamp: 'a 12/1/2019 15:49:09'!
Clock subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration

	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration

	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now

	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today

	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'TusLibros-Tests' stamp: 'a 12/1/2019 15:49:09'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime

	^self new initializeNow: aTime ! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros-Tests' stamp: 'a 12/1/2019 15:49:09'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore

	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice

	^15! !

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/22/2013 00:16'!
defaultCatalog

	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard

	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard

	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:30'!
notExpiredCreditCardNumber

	^ '1111222233334444' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:48'!
notExpiredCreditCardOwner

	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


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

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'VPM 11/7/2019 20:22:21'!
unregistredPassword
	^ 'otro'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'VPM 11/7/2019 20:22:15'!
unregistredUser
	^ 'otro'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'VPM 11/7/2019 20:21:07'!
usersRegisty
	^ Dictionary newFromPairs: { self registredUser. self registredPassword }! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer

	^'aCustomer'! !
