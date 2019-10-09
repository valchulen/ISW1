!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 13:43:32'!
testDeltaEast
	self assert: East delta equals: 1@0! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 13:43:01'!
testDeltaNorth
	self assert: North delta equals: 0@1! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 13:43:16'!
testDeltaSouth
	self assert: South delta equals: 0@-1! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 13:43:44'!
testDeltaWest
	self assert: West delta equals: -1@0! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:26:48'!
testLeftOfEastIsNorth

	self assert: East left equals: North! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:26:56'!
testLeftOfNorthIsWest

	self assert: North left equals: West! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:27:03'!
testLeftOfSouthIsEast

	self assert: South left equals: East! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:27:10'!
testLeftOfWestIsSouth

	self assert: West left equals: South! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:27:17'!
testRightOfEastIsSouth

	self assert: East right equals: South! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:27:23'!
testRightOfNorthIsEast

	self assert: North right equals: East! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:27:30'!
testRightOfSouthIsWest

	self assert: South right equals: West! !

!MarsRoverTest methodsFor: 'tests - cardinal' stamp: 'VPM 10/9/2019 12:27:37'!
testRightOfWestIsNorth

	self assert: West right equals: North! !


!MarsRoverTest methodsFor: 'Basic rotations' stamp: 'VPM 10/9/2019 13:47:27'!
testRotatesLeftToEast
	
	| rover |
	
	rover := MarsRover startAt: 1@1 oriented: North.
	
	rover do: 'lll'.
	
	self assert: rover at equals: 1@1.
	self assert: rover orientation equals: East.! !

!MarsRoverTest methodsFor: 'Basic rotations' stamp: 'VPM 10/9/2019 13:47:34'!
testRotatesLeftToSouth
	
	| rover |
	
	rover := MarsRover startAt: 1@1 oriented: North.
	
	rover do: 'll'.
	
	self assert: rover at equals: 1@1.
	self assert: rover orientation equals: South.! !

!MarsRoverTest methodsFor: 'Basic rotations' stamp: 'VPM 10/9/2019 13:47:40'!
testRotatesLeftToWest
	
	| rover |
	
	rover := MarsRover startAt: 1@1 oriented: North.
	
	rover do: 'l'.
	
	self assert: rover at equals: 1@1.
	self assert: rover orientation equals: West.! !

!MarsRoverTest methodsFor: 'Basic rotations' stamp: 'VPM 10/9/2019 13:47:46'!
testRotatesRightToEast
	
	| rover |
	
	rover := MarsRover startAt: 1@1 oriented: North.
	
	rover do: 'r'.
	
	self assert: rover at equals: 1@1.
	self assert: rover orientation equals: East.! !

!MarsRoverTest methodsFor: 'Basic rotations' stamp: 'VPM 10/9/2019 13:47:52'!
testRotatesRightToSouth
	
	| rover |
	
	rover := MarsRover startAt: 1@1 oriented: North.
	
	rover do: 'rr'.
	
	self assert: rover at equals: 1@1.
	self assert: rover orientation equals: South.! !

!MarsRoverTest methodsFor: 'Basic rotations' stamp: 'VPM 10/9/2019 13:48:00'!
testRotatesRightToWest
	
	| rover |
	
	rover := MarsRover startAt: 1@1 oriented: North.
	
	rover do: 'rrr'.
	
	self assert: rover at equals: 1@1.
	self assert: rover orientation equals: West.! !


!MarsRoverTest methodsFor: 'tests - initialization' stamp: 'VPM 10/9/2019 13:36:36'!
testGoodStart
	
	| rover |
	rover := MarsRover startAt: 1@1 oriented: North.
	
	self assert: rover at equals: 1@1.
	self assert: rover orientation equals: North.! !


!MarsRoverTest methodsFor: 'Basic moves - from North' stamp: 'VPM 10/9/2019 13:16:31'!
testMovesOneNorthAfterRotatingLeft

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: North.
	
	rover do: 'llb'.
	
	self assert: rover at equals: 0@1.
	self assert: rover orientation equals: South! !

!MarsRoverTest methodsFor: 'Basic moves - from North' stamp: 'VPM 10/9/2019 13:17:40'!
testMovesOneNorthAfterRotatingRight

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: North.
	
	rover do: 'rrb'.
	
	self assert: rover at equals: 0@1.
	self assert: rover orientation equals: South! !

!MarsRoverTest methodsFor: 'Basic moves - from North' stamp: 'VPM 10/9/2019 13:14:22'!
testMovesOneNorthNotRotating

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: North.
	
	rover do: 'f'.
	
	self assert: rover at equals: 0@1.
	self assert: rover orientation equals: North! !

!MarsRoverTest methodsFor: 'Basic moves - from North' stamp: 'VPM 10/9/2019 13:18:28'!
testMovesOneSouthAfterRotatingLeft

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: North.
	
	rover do: 'llf'.
	
	self assert: rover at equals: 0@-1.
	self assert: rover orientation equals: South! !

!MarsRoverTest methodsFor: 'Basic moves - from North' stamp: 'VPM 10/9/2019 13:18:57'!
testMovesOneSouthAfterRotatingRight

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: North.
	
	rover do: 'rrf'.
	
	self assert: rover at equals: 0@-1.
	self assert: rover orientation equals: South! !

!MarsRoverTest methodsFor: 'Basic moves - from North' stamp: 'VPM 10/9/2019 13:14:15'!
testMovesOneSouthNotRotating

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: North.
	
	rover do: 'b'.
	
	self assert: rover at equals: 0@-1.
	self assert: rover orientation equals: North! !


!MarsRoverTest methodsFor: 'Basic moves - from East' stamp: 'VPM 10/9/2019 13:30:44'!
testMovesOneEastAfterRotatingLeft

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: East.
	
	rover do: 'llb'.
	
	self assert: rover at equals: 1@0.
	self assert: rover orientation equals: West! !

!MarsRoverTest methodsFor: 'Basic moves - from East' stamp: 'VPM 10/9/2019 13:31:07'!
testMovesOneEastAfterRotatingRight

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: East.
	
	rover do: 'rrb'.
	
	self assert: rover at equals: 1@0.
	self assert: rover orientation equals: West! !

!MarsRoverTest methodsFor: 'Basic moves - from East' stamp: 'VPM 10/9/2019 13:30:01'!
testMovesOneEastNotRotating

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: East.
	
	rover do: 'f'.
	
	self assert: rover at equals: 1@0.
	self assert: rover orientation equals: East! !

!MarsRoverTest methodsFor: 'Basic moves - from East' stamp: 'VPM 10/9/2019 13:32:02'!
testMovesOneWestAfterRotatingLeft

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: East.
	
	rover do: 'llf'.
	
	self assert: rover at equals: -1@0.
	self assert: rover orientation equals: West! !

!MarsRoverTest methodsFor: 'Basic moves - from East' stamp: 'VPM 10/9/2019 13:31:47'!
testMovesOneWestAfterRotatingRight

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: East.
	
	rover do: 'rrf'.
	
	self assert: rover at equals: -1@0.
	self assert: rover orientation equals: West! !

!MarsRoverTest methodsFor: 'Basic moves - from East' stamp: 'VPM 10/9/2019 13:31:29'!
testMovesOneWestNotRotating

	| rover |
	
	rover := MarsRover startAt: 0@0 oriented: East.
	
	rover do: 'b'.
	
	self assert: rover at equals: -1@0.
	self assert: rover orientation equals: East! !


!MarsRoverTest methodsFor: 'Wrong command sequence' stamp: 'VPM 10/9/2019 14:40:20'!
testMovesStraightUntilUnknownCommand

	| commands rover |
	
	rover := MarsRover startAt: 4@4 oriented: South.
	
	commands := 'ffffaaaaafff'.
	"esto deberia estar bien hecho jejje"
	self should: [ rover do: commands ] raise: Error.
	
	self assert: rover at equals: 4@0.
	self assert: rover orientation equals: South! !


!MarsRoverTest methodsFor: 'Half rectangles' stamp: 'VPM 10/9/2019 14:12:28'!
testHalfRectangleBackwardBackward
	
	| commands rover |
	rover := MarsRover startAt: 0@0 oriented: East.
	
	commands := 'bbbblbbbbbl'.
	
	rover do: commands.
	
	self assert: rover at equals: -4@-5.
	self assert: rover orientation equals: East left left! !

!MarsRoverTest methodsFor: 'Half rectangles' stamp: 'VPM 10/9/2019 14:12:51'!
testHalfRectangleBackwardForward
	
	| commands rover |
	rover := MarsRover startAt: 0@0 oriented: East.
	
	commands := 'bbbblfffffl'.
	
	rover do: commands.
	
	self assert: rover at equals: -4@5.
	self assert: rover orientation equals: East left left! !

!MarsRoverTest methodsFor: 'Half rectangles' stamp: 'VPM 10/9/2019 14:12:07'!
testHalfRectangleForwardBackward
	
	| commands rover |
	rover := MarsRover startAt: 0@0 oriented: East.
	
	commands := 'fffflbbbbbl'.
	
	rover do: commands.
	
	self assert: rover at equals: 4@-5.
	self assert: rover orientation equals: East left left! !

!MarsRoverTest methodsFor: 'Half rectangles' stamp: 'VPM 10/9/2019 14:11:49'!
testHalfRectangleForwardForward
	
	| commands rover |
	rover := MarsRover startAt: 0@0 oriented: East.
	
	commands := 'fffflfffffl'.
	
	rover do: commands.
	
	self assert: rover at equals: 4@5.
	self assert: rover orientation equals: East left left! !


!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 13:59:38'!
testMovesFarEast
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: East.
	instructions := 'fffffffffffffffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: (instructions size - 1)@-1.
	self assert: rover orientation equals: East! !

!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 14:06:16'!
testMovesFarEastWithCrazyFullTurns
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: East.
	instructions := 'fffffllllfffffffrrrrfffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: 20@-1.
	self assert: rover orientation equals: East! !

!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 13:57:54'!
testMovesFarNorth
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: North.
	instructions := 'fffffffffffffffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: -1@(instructions size - 1).
	self assert: rover orientation equals: North! !

!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 14:07:07'!
testMovesFarNorthWithCrazyFullTurns
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: North.
	instructions := 'fffffllllfffffffrrrrfffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: -1@20.
	self assert: rover orientation equals: North! !

!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 13:59:15'!
testMovesFarSouth
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: South.
	instructions := 'fffffffffffffffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: -1@(-1 - instructions size).
	self assert: rover orientation equals: South! !

!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 14:07:21'!
testMovesFarSouthWithCrazyFullTurns
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: South.
	instructions := 'fffffllllfffffffrrrrfffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: -1@-22.
	self assert: rover orientation equals: South! !

!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 14:00:16'!
testMovesFarWest
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: West.
	instructions := 'fffffffffffffffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: (-1 - instructions size)@-1.
	self assert: rover orientation equals: West! !

!MarsRoverTest methodsFor: 'Straight Line moves' stamp: 'VPM 10/9/2019 14:06:38'!
testMovesFarWestWithCrazyFullTurns
	
	| instructions rover |
	
	rover := MarsRover startAt: -1@-1 oriented: West.
	instructions := 'fffffllllfffffffrrrrfffffffff'.
	
	rover do: instructions.
	
	self assert: rover at equals: -22@-1.
	self assert: rover orientation equals: West! !


!classDefinition: #CardinalDirection category: #MarsRover!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: #MarsRover!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:18:29'!
delta
	self subclassResponsibility ! !

!CardinalDirection class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:18:02'!
left
	self subclassResponsibility ! !

!CardinalDirection class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:18:14'!
right
	self subclassResponsibility ! !


!classDefinition: #East category: #MarsRover!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 13:42:24'!
delta
	^ 1@0! !

!East class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:19:38'!
left
	^ North! !

!East class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:19:46'!
right
	^ South! !


!classDefinition: #North category: #MarsRover!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 13:41:32'!
delta
	^ 0@1! !

!North class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:19:09'!
left
	^ West! !

!North class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:19:15'!
right
	^ East! !


!classDefinition: #South category: #MarsRover!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 13:41:45'!
delta
	^ 0@-1! !

!South class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:18:45'!
left
	^ East! !

!South class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:18:54'!
right
	^ West! !


!classDefinition: #West category: #MarsRover!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 13:42:05'!
delta
	^ -1@0! !

!West class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:18:10'!
left
	^ South! !

!West class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 12:18:22'!
right
	^ North! !


!classDefinition: #Command category: #MarsRover!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: #MarsRover!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:20:06'!
executeOn: aMarsRover
	self subclassResponsibility ! !

!Command class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:36:44'!
forChar: aCommandChar
	^ self subclasses detect: [ :aTypeOfCommand | aTypeOfCommand toChar = aCommandChar ] 
						ifNone: [ self error: 'Unknown Command' ]! !


!classDefinition: #Backward category: #MarsRover!
Command subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backward class' category: #MarsRover!
Backward class
	instanceVariableNames: ''!

!Backward class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:27:50'!
executeOn: aMarsRover
	aMarsRover moveTo: aMarsRover at - (aMarsRover orientation delta)! !

!Backward class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:24:22'!
toChar
	^ $b! !


!classDefinition: #Forward category: #MarsRover!
Command subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forward class' category: #MarsRover!
Forward class
	instanceVariableNames: ''!

!Forward class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:28:05'!
executeOn: aMarsRover
	aMarsRover moveTo: aMarsRover at + (aMarsRover orientation delta)! !

!Forward class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:21:12'!
toChar
	^ $f! !


!classDefinition: #Left category: #MarsRover!
Command subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Left class' category: #MarsRover!
Left class
	instanceVariableNames: ''!

!Left class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:28:33'!
executeOn: aMarsRover
	aMarsRover orientTo: aMarsRover orientation left! !

!Left class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:28:16'!
toChar
	^ $l! !


!classDefinition: #Right category: #MarsRover!
Command subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Right class' category: #MarsRover!
Right class
	instanceVariableNames: ''!

!Right class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:28:56'!
executeOn: aMarsRover
	aMarsRover orientTo: aMarsRover orientation right! !

!Right class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:28:50'!
toChar
	^ $r! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'myPosition myOrientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 13:35:51'!
at
	^ myPosition ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:40:54'!
do: anInstructionList

	anInstructionList do: [ :anInstruction | (Command forChar: anInstruction) executeOn: self ]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:26:15'!
moveTo: aPosition
	myPosition := aPosition! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:26:44'!
orientTo: aCardinalDirection
	myOrientation := aCardinalDirection ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 13:36:17'!
orientation
	^ myOrientation ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'VPM 10/9/2019 14:41:48'!
startAt: aPoint oriented: aCardinalDirection

	^ (self new) moveTo: aPoint ; orientTo: aCardinalDirection! !
