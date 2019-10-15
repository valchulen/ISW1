!classDefinition: #TerniLapilliTest category: #'Terni-Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 18:20:24'!
test01XCanPlaysFirst
	
	| game |
	
	game := TerniLapilli new.
	
	self assert: game isXTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/10/2019 18:00:14'!
test02OCantPlayFirst
	
	| game |
	
	game := TerniLapilli new.
	
	self deny: game isOTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/10/2019 18:42:00'!
test03XPlaysOnePiece

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	
	self assert: (game isAnXPieceAt: 5).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:33:03'!
test04XCantPlayTwiceInARow

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
		
	self should: [ game playXat: 5 ] 
		raise: Error
		withMessageText: TerniLapilli isNotXTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:37:04'!
test05XPlaysAndIsOTurn

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	
	self assert: game isOTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/10/2019 18:22:34'!
test06XPlaysAndThenO

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	
	self assert: (game isAnOPieceAt: 6).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:40:06'!
test07OCantPlayTwiceInARow

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	
	self should: [ game playOat: 7 ] 
		raise: Error
		withMessageText: TerniLapilli isNotOTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/10/2019 19:24:09'!
test08CantPlayInAnOccupiedSlot

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	
	self should: [ game playOat: 5 ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | self assert: error messageText = TerniLapilli cantPlayInAnOccupiedSlot. ]
		"deberia asertar que no haya una O ahi (Invariante) adentro del closure."! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:40:07'!
test09XCanPlaySecondRound

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	
	self assert: game isXTurn.
	
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:40:57'!
test10XPlaysSecondRound

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	
	self assert: (game isAnXPieceAt: 3).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:41:42'!
test11OCanPlaySecondRound

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
		
	self assert: game isOTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:42:35'!
test12OPlaysSecondRound

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	
	self assert: (game isAnOPieceAt: 7).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:43:23'!
test13XCanPlayThirdRound

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	
	self assert: game isXTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:45:04'!
test14XPlaysThirdRound

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	game playXat: 9.
		
	self assert: (game isAnXPieceAt: 9).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:45:39'!
test15OCanPlayThirdRound

	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	game playXat: 9.
		
	self assert: game isOTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 15:51:39'!
test16OPlaysThirdRoundAndGameDoesntEnd
	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	game playXat: 9.
	game playOat: 1.
		
	self assert: (game isAnOPieceAt: 1).
	self deny: game isGameFinished.
	self assert: game isXTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:17:33'!
test17XWinsInThirdRound
	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 8.
	game playXat: 7.
		
	self assert: game isGameFinished.
	self assert: game isXTheWinner.
	self deny: game isOTheWinner.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:17:55'!
test18OWinsInThirdRound
	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 2.
	game playOat: 3.
	game playXat: 7.
	game playOat: 9.
		
	self assert: game isGameFinished.
	self deny: game isXTheWinner.
	self assert: game isOTheWinner.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 18:28:16'!
test19XCantPlayAFourthTime
	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	game playXat: 9.
	game playOat: 1.
		
	self should: [ game playXat: 2 ] 
		raise: Error
		withMessageText: TerniLapilli cantPlayMoreThanThreeTimes.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 18:29:07'!
test20XCanMoveAndDoesntWin
	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	game playXat: 9.
	game playOat: 1.
	
	game moveXfrom: 3 to: 2.
	
	self assert: (game isAnXPieceAt: 2).
	self deny: (game isAnXPieceAt: 3).
	self deny: game isGameFinished.
	self assert: game isOTurn.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:33:38'!
test21XCanMoveAndWins
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 8.
	game playOat: 6.
	
	game moveXfrom: 8 to: 9.
	
	self assert: game isGameFinished.
	self assert: game isXTheWinner.
	self deny: game isOTheWinner.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:21:18'!
test22XCantMoveFromAPositionHeDoesntOccupy
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 6.
	
	self should: [ game moveXfrom: 9 to: 8 ] 
		raise: Error
		withMessageText: TerniLapilli cantMoveFromAnUnoccupiedSpace.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:34:33'!
test23XCantMoveToAnOccupiedPosition
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 8.
	
	self should: [ game moveXfrom: 5 to: 8 ] 
		raise: Error
		withMessageText: TerniLapilli cantPlayInAnOccupiedSlot.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:40:27'!
test24XCantMoveBeforeThirdRound
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	
	self should: [ game moveXfrom: 1 to: 4 ] 
		raise: Error
		withMessageText: TerniLapilli cantMoveBeforeThirdRound.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:42:45'!
test25OCanMoveAndDoesntWin
	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	game playXat: 9.
	game playOat: 1.
	
	game moveXfrom: 3 to: 2.
	game moveOfrom: 7 to: 8.
	
	self assert: (game isAnOPieceAt: 8).
	self deny: (game isAnXPieceAt: 7).
	self deny: game isGameFinished.
	self assert: game isXTurn.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:43:44'!
test26OCanMoveAndWins
	| game |
	
	game := TerniLapilli new.
	game playXat: 2.
	game playOat: 4.
	game playXat: 5.
	game playOat: 1.
	game playXat: 6.
	game playOat: 8.
	
	game moveXfrom: 2 to: 3.
	game moveOfrom: 8 to: 7.
	
	self assert: game isGameFinished.
	self deny: game isXTheWinner.
	self assert: game isOTheWinner.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:44:30'!
test27OCantMoveFromAPositionHeDoesntOccupy
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 4.
	game playOat: 6.
	game playXat: 5.
	game playOat: 8.
	
	game moveXfrom: 5 to: 3.
	
	self should: [ game moveOfrom: 9 to: 8 ] 
		raise: Error
		withMessageText: TerniLapilli cantMoveFromAnUnoccupiedSpace.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:53:15'!
test28OCantMoveToAnOccupiedPosition
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 4.
	game playOat: 6.
	game playXat: 5.
	game playOat: 8.
	
	game moveXfrom: 5 to: 3.
	
	self should: [ game moveOfrom: 2 to: 1 ] 
		raise: Error
		withMessageText: TerniLapilli cantPlayInAnOccupiedSlot.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:49:09'!
test29XCantMoveBeforeThirdRound
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 3.
	
	self should: [ game moveOfrom: 2 to: 5 ] 
		raise: Error
		withMessageText: TerniLapilli cantMoveBeforeThirdRound.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:56:17'!
test30XCantMoveToTheSamePlace
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 8.
	
	self should: [ game moveXfrom: 5 to: 5 ] 
		raise: Error
		withMessageText: TerniLapilli cantMoveToTheSamePlace.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:59:47'!
test31OCantMoveToTheSamePlace
	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 8.
	
	game moveXfrom: 5 to: 6.
	
	self should: [ game moveOfrom: 2 to: 2 ] 
		raise: Error
		withMessageText: TerniLapilli cantMoveToTheSamePlace.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:10:18'!
test32OCantPlayAFourthTime
	| game |
	
	game := TerniLapilli new.
	game playXat: 5.
	game playOat: 6.
	game playXat: 3.
	game playOat: 7.
	game playXat: 9.
	game playOat: 1.
	
	game moveXfrom: 5 to: 2.
		
	self should: [ game playOat: 8 ] 
		raise: Error
		withMessageText: TerniLapilli cantPlayMoreThanThreeTimes.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:19:07'!
test32XCantMakeAnInvalidMove

	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 8.
	
	self should: [ game moveXfrom: 1 to: 3 ] 
		raise: Error
		withMessageText: TerniLapilli cantMakeAnInvalidMove.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:21:38'!
test33OCantMakeAnInvalidMove

	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 8.
	
	game moveXfrom: 5 to: 9.
	
	self should: [ game moveOfrom: 8 to: 3 ] 
		raise: Error
		withMessageText: TerniLapilli cantMakeAnInvalidMove.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:22:03'!
test34XCantMoveOutOfTurn

	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 8.
	
	game moveXfrom: 5 to: 9.
	
	self should: [ game moveXfrom: 7 to: 5 ] 
		raise: Error
		withMessageText: TerniLapilli isNotXTurn.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:23:23'!
test35OCantMoveOutOfTurn

	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 8.
	
	self should: [ game moveOfrom: 8 to: 9 ] 
		raise: Error
		withMessageText: TerniLapilli isNotOTurn.
	! !


!classDefinition: #TerniLapilli category: #'Terni-Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'XTurn OTurn Xs Os gameFinished'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:45:41'!
initialize
	XTurn := true.
	OTurn := false.
	Xs := Set new.
	Os := Set new.
	gameFinished := false.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:38:41'!
isAnOPieceAt: aPosition
	^Os includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/10/2019 18:49:11'!
isAnXPieceAt: aPosition
	^Xs includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:07:18'!
isGameFinished
	^ (self isXTheWinner) | (self isOTheWinner).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:16:27'!
isOTheWinner
	| aMagicSquare total |
	
	aMagicSquare := TerniLapilli magicSquare.
	total := 0.
	Os do: [:elem | total := total + (aMagicSquare at: elem)].
	^15 = total.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/10/2019 18:37:02'!
isOTurn
	^ OTurn.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 17:00:54'!
isPositionOccupied: aPosition
	^(self isAnXPieceAt: aPosition) | (self isAnOPieceAt: aPosition).
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:16:11'!
isXTheWinner
	| aMagicSquare total |
	
	aMagicSquare := TerniLapilli magicSquare.
	total := 0.
	Xs do: [:elem | total := total + (aMagicSquare at: elem)].
	^15 = total.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/10/2019 18:37:19'!
isXTurn
	^ XTurn.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:06:22'!
moveOfrom: initialPostition to: finalPosition

	initialPostition = finalPosition ifTrue: [self error: TerniLapilli cantMoveToTheSamePlace].
	Os size < 3 ifFalse: [
	Os remove: initialPostition ifAbsent: [self error: TerniLapilli cantMoveFromAnUnoccupiedSpace].
	self playOat: finalPosition.
	] ifTrue: [
		self error: TerniLapilli cantMoveBeforeThirdRound.
	]
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:15:14'!
moveXfrom: initialPostition to: finalPosition
	
	initialPostition = finalPosition ifTrue: [self error: TerniLapilli cantMoveToTheSamePlace].	
	Xs size < 3 ifFalse: [
	Xs remove: initialPostition ifAbsent: [self error: TerniLapilli cantMoveFromAnUnoccupiedSpace].
	self playXat: finalPosition.
	] ifTrue: [
		self error: TerniLapilli cantMoveBeforeThirdRound.
	]
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:07:51'!
playOat: aPosition
	self isOTurn ifTrue: [
		 (self isPositionOccupied: aPosition ) not ifTrue: [
			Os size = 3 ifFalse: [
			Os add: aPosition.
			OTurn := false.
			XTurn := true.
			] ifTrue: [
				self error: TerniLapilli cantPlayMoreThanThreeTimes.
			]
		] ifFalse: [
			self error: TerniLapilli cantPlayInAnOccupiedSlot.
		].
	] ifFalse: [
		self error: TerniLapilli isNotOTurn.
	].
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:30:59'!
playXat: aPosition
	self isXTurn ifTrue: [
		 (self isPositionOccupied: aPosition ) not ifTrue: [
			Xs size = 3 ifFalse: [
			Xs add: aPosition.
			XTurn := false.
			OTurn := true.
			] ifTrue: [
				self error: TerniLapilli cantPlayMoreThanThreeTimes.
			]
		] ifFalse: [
			self error: TerniLapilli cantPlayInAnOccupiedSlot.
		].
	] ifFalse: [
		self error: TerniLapilli isNotXTurn.
	].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni-Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:41:01'!
cantMoveBeforeThirdRound
	^'Cant move before third round'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:01:09'!
cantMoveFromAnUnoccupiedSpace
	^'Cant move from a space you dont occupy'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:56:56'!
cantMoveToTheSamePlace
	^'cant move to the same place'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:57:34'!
cantPlayInAnOccupiedSlot
	^ 'Cant play in an occupied slot'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 18:27:22'!
cantPlayMoreThanThreeTimes
	^'Cant play more than three times'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:39:10'!
isNotOTurn
	^ 'Is not Os turn'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/14/2019 20:36:18'!
isNotXTurn
	^ 'Is not Xs turn'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:10:34'!
magicSquare
	
	| conversionArray |
	conversionArray := Array new: 10.
	^conversionArray 
		at: 1 put: 4;
		at: 2 put: 9;
		at: 3 put: 2;
		at: 4 put: 3;
		at: 5 put: 5;
		at: 6 put: 7;
		at: 7 put: 8;
		at: 8 put: 1;
		at: 9 put: 6;
		at: 10 put: 0;
		yourself! !
