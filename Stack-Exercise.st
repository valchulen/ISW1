!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finderWithEmptyStack finderWithFullStack stackWithElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'VPM 9/19/2019 00:00:55'!
setUp
	|emptyStack |
	
	emptyStack := OOStack new.
	stackWithElements := OOStack new.
	stackWithElements push: 'uno'.
	stackWithElements push: 'dos'.
	stackWithElements push: 'dostres'.
	stackWithElements push: 'dos cinco'.
	stackWithElements push: 'Cuatro'.
	stackWithElements push: 'siete seis'.


	finderWithEmptyStack := SentenceFinderByPrefix with: emptyStack.
	finderWithFullStack := SentenceFinderByPrefix with: stackWithElements.

! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:30:59'!
test01EmptyStackDoesntFindAnything

    |elementFound|
    elementFound := finderWithEmptyStack find: 'nueve'.
    self assert: elementFound size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:41:18'!
test02FindsOnlyOneElementInStack

    |elementFound|
    elementFound := finderWithFullStack find: 'uno'.
    self assert: (elementFound at: 1) equals: 'uno'.
    self assert: elementFound size equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:41:40'!
test03DoesntFindAnythingInStack

    |elementFound|
    elementFound := finderWithFullStack find: 'nueve'.
    self assert: elementFound size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:41:53'!
test04FindsCaseSensitieveElement

    |elementFound|
    elementFound := finderWithFullStack find: 'Cuatro'.
    self assert: (elementFound at: 1) equals: 'Cuatro'.
    self assert: elementFound size equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:42:09'!
test05DoesntFindCaseSensitieveElement

    |elementFound|
    elementFound := finderWithFullStack find: 'cuatro'.
    self assert: elementFound size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:42:25'!
test06FindsManyElementsInStack
    |elementFound|
    elementFound := finderWithFullStack find: 'dos'.
    self assert: (elementFound at: 1) equals: 'dos'.
    self assert: (elementFound at: 2) equals: 'dostres'.
    self assert: (elementFound at: 3) equals: 'dos cinco'.
    self assert: elementFound size equals: 3.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:48:34'!
test07ThrowsErrorIfPrefixIsEmpty

    self
        should: [ finderWithFullStack find: '' ]
        raise: Error
        withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix cannotSearchForEmptyPrefix ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:49:03'!
test08ThrowsErrorIfPrefixContainsSpaces

    self
        should: [ finderWithFullStack find: 'dos cinco' ]
        raise: Error
        withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixCannotContainSpaces ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/18/2019 23:57:15'!
test09DoesntFindElementIfNotPrefix

    |elementFound|
    elementFound := finderWithFullStack find: 'seis'.
    self assert: elementFound size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/19/2019 00:01:17'!
test10FindsElementAfterPush

    |elementFound |
    stackWithElements push: 'ocho'.
    elementFound := finderWithFullStack find: 'ocho'.
    self assert: (elementFound at: 1) equals: 'ocho'.
    self assert: elementFound size equals: 1.
	stackWithElements pop.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'VPM 9/19/2019 00:01:35'!
test11DoesntFindElementThatHasBeenPopped

    |elementFound|
    stackWithElements push: 'nueve'.
    stackWithElements pop.
    elementFound := finderWithFullStack find: 'nueve'.
    self assert: elementFound size equals: 0.! !


!classDefinition: #EmptyStackElement category: #'Stack-Exercise'!
Object subclass: #EmptyStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackElement methodsFor: 'errors'!
oveSelector: #doRecursive:! !


!EmptyStackElement methodsFor: 'getters'!
1808! !

!EmptyStackElement methodsFor: 'getters' stamp: 'VPM 9/18/2019 23:34:57'!
refix) ifTrue: [ ^ sentence ].
	
	stack pop.
	
	returnSentence := self findRecursive: aPrefix on: stack.
	
	stack push: sentence.
	
	^ returnSentence.
	
		
! !



!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization'!
/18/2019 15:32:48'! !


!OOStack methodsFor: 'getters' stamp: 'VPM 9/18/2019 23:30:29'!
setUp
	|emptyStack stackWithElements|
	
	emptyStack := OOStack new.
	stackWithElements := OOStack new.
	stackWithElements push: 'uno'.
	stackWithElements push: 'dos'.
	stackWithElements push: 'dostres'.
	stackWithElements push: 'dos cinco'.
	stackWithElements push: 'Cuatro'.
	stackWithElements push: 'siete seis'.


	finderWithEmptyStack new with: emptyStack.
	finderWithFullStack new with: stackWithElements

! !

!OOStack methodsFor: 'getters'!
: 'VPM 9/18/2019 23:38:36' prior: 50741642! !


!OOStack methodsFor: 'comparing' stamp: 'VPM 9/18/2019 23:40:06'!
refix.
	
	(sentence beginsWith: aPrefix) ifTrue: [ alreadyFound add: sentence ].
	
	stack push: sentence.
	
	^ alreadyFound.
	
		
! !


!OOStack methodsFor: 'modifiers'!
ByPrefix methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 23:40:06' prior: 50741820! !

!OOStack methodsFor: 'modifiers'!
ames: 'finderWithEmptyStack finderWithFullStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 23:56:58'!
find: aPrefix
	aPrefix isEmpty ifTrue: [ self error: self class cannotSearchForEmptyPrefix ].
	(aPrefix includesSubString: ' ') ifTrue: [ self error: self class prefixCannotContainSpaces ].
	^ self findRecursive: aPrefix.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 23:41:02'!
findRecursive: aPrefix
	| sentence alreadyFound |
	
	[sentence := stack pop] on: Error do: [^ OrderedCollection new ].
	
	alreadyFound := self findRecursive: aPrefix.
	
	(sentence beginsWith: aPrefix) ifTrue: [ alreadyFound add: sentence ].
	
	stack push: sentence.
	
	^ alreadyFound.
	
		
! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 15:47:01'!
findRecursive: aPrefix on: aStack
	| sentence returnSentence |
	
	sentence := (aStack top) ifError: [ :error | self error: 'No encontre nada' ].
	
	(sentence beginsWith: aPrefix) ifTrue: [ ^ sentence ].
	
	aStack pop.
	
	returnSentence := self findRecursive: aPrefix on: aStack.
	
	aStack push: sentence.
	
	^ returnSentence.
	
		
! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 15:32:48'!
initializeWithStack: aInitialStack
	stack := aInitialStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 23:48:06'!
cannotSearchForEmptyPrefix
	^ 'No se puede buscar por prefijo vacio'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 23:49:24'!
prefixCannotContainSpaces
	^ 'El prefijo no puede contener espacios'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 15:31:59'!
with: aSentenceStack
	^ self new initializeWithStack: aSentenceStack.! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'value prev'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'getters'!
50741794! !

!StackElement methodsFor: 'getters'!
019 23:33:28' prior: 50741755! !


!StackElement methodsFor: 'initialization' stamp: 'VPM 9/18/2019 23:33:04'!
'uno'.
	stackWithElements push: 'dos'.
	stackWithElements push: 'dostres'.
	stackWithElements push: 'dos cinco'.
	stackWithElements push: 'Cuatro'.
	stackWithElements push: 'siete seis'.


	finderWithEmptyStack := SentenceFinderByPrefix with: emptyStack.
	finderWithFullStack new with: stackWithElements

! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackElement class' category: #'Stack-Exercise'!
StackElement class
	instanceVariableNames: ''!

!StackElement class methodsFor: 'as yet unclassified' stamp: 'VPM 9/18/2019 23:33:04'!
nderWithEmptyStack := SentenceFinderByPrefix with: emptyStack.
	finderWithFullStack new with: stackWithElements

! !
