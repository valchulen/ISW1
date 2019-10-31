!classDefinition: #TusLibros category: #TusLibros stamp: 'sjd 10/31/2019 16:19:38'!
Object subclass: #TusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #ShoppingCart category: #TusLibros stamp: 'sjd 10/31/2019 16:19:38'!
TusLibros subclass: #ShoppingCart
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'sjd 10/31/2019 16:06:00'!
initialize
	elements := Collection new.! !


!classDefinition: #TusLibrosTest category: #TusLibros stamp: 'sjd 10/31/2019 16:19:38'!
Object subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 16:07:26'!
test01CreateShoppingCartEmpty
	| shoppingcart | 
	
	shoppingcart := ShoppingCart new.
	
	self assert: 0 equals: shoppingcart elements size.
	! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 16:07:13'!
test02AddItemToShoppingCartCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item'.
	
	self assert: 1 equals: shoppingcart elements size.! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 16:08:35'!
test03FindItemInShoppingCartCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item'.
	
	self assert: 'Item' equals: (shoppingcart findItem: 'Item').! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 16:00:16'!
test04SearchUnexistingItemInShoppingCartThrowsError! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 16:14:22'!
test05ListShoppingCartElementsCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1'.
	shoppingcart add: 'Item2'.
	shoppingcart add: 'Item3'.
	
	self assert: 'Item1, Item2, Item3' equals: shoppingcart listElements.! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 16:12:17'!
test06AddManyItemsWorksCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	
	
	self assert: 3 equals: shoppingcart elements size.	
	self assert: 'Item1, Item1, Item1' equals: shoppingcart listElements.! !
