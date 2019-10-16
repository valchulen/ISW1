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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:01:57'!
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
		withMessageText: TerniLapilli cantMoveToOccuppiedPlace.! !

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:04:12'!
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
	
	self should: [ game moveOfrom: 9 to: 5 ] 
		raise: Error
		withMessageText: TerniLapilli cantMoveFromAnUnoccupiedSpace.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:04:59'!
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
		withMessageText: TerniLapilli cantMoveToOccuppiedPlace .! !

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:37:58'!
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
		withMessageText: TerniLapilli cantMoveToOccuppiedPlace .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:38:15'!
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
		withMessageText: TerniLapilli cantMoveToOccuppiedPlace .! !

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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:45:59'!
test36XCantMoveOutOfBounds

	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 9.	

	self should: [ game moveXfrom: 1 to: 10 ]
		raise: Error
		withMessageText: TerniLapilli cantPlayOutOfBounds.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:46:20'!
test37XCantMoveFromOutOfBounds

	| game |
	
	game := TerniLapilli new.
	game playXat: 1.
	game playOat: 2.
	game playXat: 5.
	game playOat: 4.
	game playXat: 7.
	game playOat: 9.	

	self should: [ game moveXfrom: 10 to: 1 ]
		raise: Error
		withMessageText: TerniLapilli cantPlayOutOfBounds.
	! !


!classDefinition: #State category: #'Terni-Lapilli'!
Object subclass: #State
	instanceVariableNames: 'ocuppiedPlaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:05:42'!
hasWon
	| aMagicSquare total |
	
	aMagicSquare := TerniLapilli magicSquare.
	total := 0.
	ocuppiedPlaces do: [ :elem | total := total + (aMagicSquare at: elem)].
	^15 = total.! !

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:53:15'!
initialize
	ocuppiedPlaces := Set new! !

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:47:38'!
isOTurn
	self subclassResponsibility ! !

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:58:07'!
isPositionOccupied: aPosition
	^ ocuppiedPlaces includes: aPosition! !

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:36:42'!
isValidMoveFrom: initialPosition to: finalPosition
	| x0 x1 y0 y1 d |
	x0 := (initialPosition - 1) \\ 3.
	y0 := (initialPosition - 1) // 3.
	x1 := (finalPosition - 1) \\ 3.
	y1 := (finalPosition - 1) // 3.
	
	d := ((x0@y0) - (x1@y1)) abs.
	
	^ (d x <= 1) & (d y <= 1)! !

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:47:42'!
isXTurn
	self subclassResponsibility ! !

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:46:58'!
moveFrom: startingPosition to: endPosition

	(1 <= endPosition) & (endPosition <= 9) ifFalse: [ self error: TerniLapilli cantPlayOutOfBounds ].

	(self isValidMoveFrom: startingPosition to: endPosition) ifFalse: [ self error: TerniLapilli cantMakeAnInvalidMove ].

	ocuppiedPlaces size < 3 ifTrue: [ self error: TerniLapilli cantMoveBeforeThirdRound ].
	ocuppiedPlaces remove: startingPosition ifAbsent: [ self error: TerniLapilli cantMoveFromAnUnoccupiedSpace ].
	ocuppiedPlaces add: endPosition.! !

!State methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:43:15'!
playAt: aPosition
	(1 <= aPosition) & (aPosition <= 9) ifFalse: [ self error: TerniLapilli cantPlayOutOfBounds ].
	ocuppiedPlaces size = 3 ifTrue: [ self error: TerniLapilli cantPlayMoreThanThreeTimes ].
	ocuppiedPlaces add: aPosition! !


!classDefinition: #OState category: #'Terni-Lapilli'!
State subclass: #OState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!OState methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:46:54'!
isOTurn
	^ true! !

!OState methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:47:01'!
isXTurn
	^ false! !


!classDefinition: #XState category: #'Terni-Lapilli'!
State subclass: #XState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!XState methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:47:09'!
isOTurn
	^ false! !

!XState methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:47:14'!
isXTurn
	^ true! !


!classDefinition: #TerniLapilli category: #'Terni-Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'XTurn OTurn Xs Os gameFinished OS XS nextPlayer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:29:56'!
initialize
	XS := XState new.
	OS := OState new.
 	nextPlayer := XS.
	
	XTurn := true.
	OTurn := false.
	Xs := Set new.
	Os := Set new.
	gameFinished := false.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:32:19'!
isAnOPieceAt: aPosition
	^ OS isPositionOccupied: aPosition! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:57:03'!
isAnXPieceAt: aPosition
	^ XS isPositionOccupied: aPosition ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:07:18'!
isGameFinished
	^ (self isXTheWinner) | (self isOTheWinner).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:32:55'!
isOTheWinner
	^ OS hasWon! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:48:05'!
isOTurn
	^ nextPlayer isOTurn! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:57:40'!
isPositionOccupied: aPosition
	^ (self isAnXPieceAt: aPosition) | (self isAnOPieceAt: aPosition)
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:32:45'!
isXTheWinner
	^ XS hasWon! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:47:55'!
isXTurn
	^ nextPlayer isXTurn! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:38:38'!
moveOfrom: initialPosition to: finalPosition

	self isOTurn ifFalse: [ self error: TerniLapilli isNotOTurn ].
	
	(self isPositionOccupied: finalPosition) ifTrue: [ self error: TerniLapilli cantMoveToOccuppiedPlace ].
	
	OS moveFrom: initialPosition to: finalPosition.
	
	nextPlayer := XS! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:38:42'!
moveXfrom: initialPosition to: finalPosition

	self isXTurn ifFalse: [ self error: TerniLapilli isNotXTurn ].
	
	(self isPositionOccupied: finalPosition) ifTrue: [ self error: TerniLapilli cantMoveToOccuppiedPlace ].
	
	XS moveFrom: initialPosition to: finalPosition.
	
	nextPlayer := OS
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:55:52'!
playOat: aPosition

	self isOTurn ifFalse: [ self error: TerniLapilli isNotOTurn ].
	(self isPositionOccupied: aPosition) ifTrue: [ self error: TerniLapilli cantPlayInAnOccupiedSlot ].
	OS playAt: aPosition.
	nextPlayer := XS
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:56:00'!
playXat: aPosition

	self isXTurn ifFalse: [ self error: TerniLapilli isNotXTurn ].
	(self isPositionOccupied: aPosition) ifTrue: [ self error: TerniLapilli cantPlayInAnOccupiedSlot ].
	XS playAt: aPosition.
	nextPlayer := OS! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni-Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 11:53:39'!
cantMakeAnInvalidMove
	^ 'cant make a move more than one place away'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 19:41:01'!
cantMoveBeforeThirdRound
	^'Cant move before third round'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 20:01:09'!
cantMoveFromAnUnoccupiedSpace
	^'Cant move from a space you dont occupy'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:45:43'!
cantMoveToOccuppiedPlace
	^ 'cant move to an already Occupied place'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:57:34'!
cantPlayInAnOccupiedSlot
	^ 'Cant play in an occupied slot'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 18:27:22'!
cantPlayMoreThanThreeTimes
	^'Cant play more than three times'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 13:41:12'!
cantPlayOutOfBounds
	^ 'cannot play out of board bounds'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/15/2019 16:39:10'!
isNotOTurn
	^ 'Is not Os turn'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gl 10/14/2019 20:36:18'!
isNotXTurn
	^ 'Is not Xs turn'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'VPM 10/16/2019 12:05:59'!
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
		yourself! !
