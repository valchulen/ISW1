!classDefinition: #TusLibrosTest category: #TusLibros stamp: 'sjd 10/31/2019 18:05:04'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:12:19'!
test01CreateShoppingCartEmpty
	| shoppingcart | 
	
	shoppingcart := ShoppingCart new.
	
	self assert: 0 equals: shoppingcart size.
	! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:17:45'!
test02AddItemToShoppingCartCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item'.
	
	self assert: 1 equals: shoppingcart size.! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:20:27'!
test03FindItemInShoppingCartCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item'.
	
	self assert: (shoppingcart findItem: 'Item').! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:21:46'!
test04SearchUnexistingItemInShoppingCartReturnsFalse
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item'.
	
	self deny: (shoppingcart findItem: 'DifferentItem').! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 16:14:22'!
test05ListShoppingCartElementsCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1'.
	shoppingcart add: 'Item2'.
	shoppingcart add: 'Item3'.
	
	self assert: 'Item1, Item2, Item3' equals: shoppingcart listElements.! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:42:07'!
test06AddManyItemsWorksCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	
	
	self assert: 3 equals: shoppingcart size.	
	self assert: 'Item1, Item1, Item1' equals: shoppingcart listElements.! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:26:25'!
test07HowManyElementsOfWorksCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	shoppingcart add: 'Item2' times: 2.
		
	self assert: 3 equals: (shoppingcart howManyOf: 'Item1').! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:55:22'!
test08RemovingItemFromShoppingCartWorksCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	shoppingcart remove: 'Item1'.
		
	self assert: 2 equals: (shoppingcart howManyOf: 'Item1').! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:53:55'!
test09RemovingUnexistingItemFromShoppingThrowsError
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	
	self should: [shoppingcart remove: 'Item2'] raise: Error withMessageText: 'No se encuentra el elemento que desea borrar'. ! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 17:57:18'!
test10RemovesTimesFromShoppingCartWorksCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	shoppingcart remove: 'Item1' times: 3.
		
	self assert: 0 equals: (shoppingcart howManyOf: 'Item1').! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 18:03:34'!
test11RemovesMoreTimesFromShoppingThrowsError
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	
	self should: [shoppingcart remove: 'Item2' times:4] raise: Error withMessageText: 'No se encuentra el elemento que desea borrar'. ! !

!TusLibrosTest methodsFor: 'tests - shoppingCart' stamp: 'sjd 10/31/2019 18:04:29'!
test12RemoveAllFromShoppingWorksCorrectly
	| shoppingcart |
	
	shoppingcart := ShoppingCart new.
	shoppingcart add: 'Item1' times: 3.
	shoppingcart removeAll.
	
	self assert: 0 equals: shoppingcart size! !


!classDefinition: #TusLibros category: #TusLibros stamp: 'sjd 10/31/2019 18:05:04'!
Object subclass: #TusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #ShoppingCart category: #TusLibros stamp: 'sjd 10/31/2019 18:05:04'!
TusLibros subclass: #ShoppingCart
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'initialization' stamp: 'sjd 10/31/2019 17:15:31'!
initialize
	elements := OrderedCollection new.! !


!ShoppingCart methodsFor: 'accessing' stamp: 'sjd 10/31/2019 17:09:25'!
elements
	^elements.! !

!ShoppingCart methodsFor: 'accessing' stamp: 'sjd 10/31/2019 17:11:07'!
size
	^ elements size.! !


!ShoppingCart methodsFor: 'adding' stamp: 'sjd 10/31/2019 17:16:09'!
add: anItem
	elements add: anItem.! !

!ShoppingCart methodsFor: 'adding' stamp: 'sjd 10/31/2019 17:41:31'!
add: anItem times: aNumber

	aNumber timesRepeat: [self add: anItem].! !


!ShoppingCart methodsFor: 'searching' stamp: 'sjd 10/31/2019 17:20:09'!
findItem: anItem
	^ elements includes: anItem.! !

!ShoppingCart methodsFor: 'searching' stamp: 'sjd 10/31/2019 17:46:39'!
howManyOf: anItem
	^(elements select: [:element | element = anItem]) size.! !


!ShoppingCart methodsFor: 'printing' stamp: 'sjd 10/31/2019 17:39:38'!
listElements
	
	| result |
	
	result := ''.
	elements do: [:element | result := result,element,', '.].
	result := result truncateTo: result size - 2.
	^result.
	
	! !


!ShoppingCart methodsFor: 'removing' stamp: 'sjd 10/31/2019 18:03:06'!
remove: anItem
	elements remove: anItem ifAbsent: [self error: 'No se encuentra el elemento que desea borrar'].! !

!ShoppingCart methodsFor: 'removing' stamp: 'sjd 10/31/2019 18:02:31'!
remove: anItem times: aNumber
	aNumber timesRepeat: [self remove: anItem].! !

!ShoppingCart methodsFor: 'removing' stamp: 'sjd 10/31/2019 18:04:50'!
removeAll
	elements removeAll.! !
