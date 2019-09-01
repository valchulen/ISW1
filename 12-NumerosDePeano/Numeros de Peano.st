!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 8/29/2019 11:54:35'!
* numDePeano
	^numDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 8/28/2019 16:17:40'!
+ num
	^num next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:21:28'!
- unNumDePeano
	^self error: I descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:21:52'!
/ unNumDePeano
	
	I = unNumDePeano ifTrue: [^self].
	^self error: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:17:49'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor!!'! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:24:58'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No existen numeros negativos o cero!!'! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:36:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 8/26/2019 18:35:10'!
next

	next ifNil: [ 
		next := self cloneNamed: self name, 'I' 
	].
	^next
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:27:34'!
previous
	^self error: I descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 8/26/2019 18:45:47'!
removeAllNext


	next ifNotNil:

	[
		next removeAllNext.

		next removeFromSystem.

		next := nil.

	]! !

!I class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:50'!
restaInversa: unNumDePeano
	^unNumDePeano previous! !


!classDefinition: #II category: #'Numeros de Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 8/29/2019 11:57:03'!
* numDePeano
	^numDePeano + (self previous * numDePeano).! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 8/28/2019 16:31:52'!
+ numDePeano
	
	^self previous + (numDePeano next).! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:34:06'!
- unNumDePeano
	^ unNumDePeano restaInversa: self
! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:29:49'!
/ unNumDePeano
		
	self = unNumDePeano ifTrue: [^I].
	
	[^I + (self - unNumDePeano / unNumDePeano)] on: Error do: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:24:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor!!'! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:36:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 8/28/2019 16:14:12'!
next

	next ifNil: [ 
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 8/28/2019 16:14:34'!
previous
	^prev.! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 8/28/2019 16:32:09'!
previous: numDePeano
	prev := numDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 8/28/2019 15:48:55'!
removeAllNext


	next ifNotNil:

	[
		next removeAllNext.

		next removeFromSystem.

		next := nil.

	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:32:28'!
restaInversa: unNumDePeano
	
	^self previous restaInversa: unNumDePeano previous! !


!classDefinition: #III category: #'Numeros de Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros de Peano'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:34:59'!
* numDePeano
	^numDePeano + (self previous * numDePeano).! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:34:59'!
+ numDePeano
	
	^self previous + (numDePeano next).! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:34:59'!
- unNumDePeano
	^ unNumDePeano restaInversa: self
! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:34:59'!
/ unNumDePeano
		
	self = unNumDePeano ifTrue: [^I].
	
	[^I + (self - unNumDePeano / unNumDePeano)] on: Error do: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:34:59'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor!!'! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:36:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
next

	next ifNil: [ 
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next
	
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
previous
	^prev.! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
previous: numDePeano
	prev := numDePeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
removeAllNext


	next ifNotNil:

	[
		next removeAllNext.

		next removeFromSystem.

		next := nil.

	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
restaInversa: unNumDePeano
	
	^self previous restaInversa: unNumDePeano previous! !


!classDefinition: #IIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros de Peano'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
* numDePeano
	^numDePeano + (self previous * numDePeano).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
+ numDePeano
	
	^self previous + (numDePeano next).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
- unNumDePeano
	^ unNumDePeano restaInversa: self
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
/ unNumDePeano
		
	self = unNumDePeano ifTrue: [^I].
	
	[^I + (self - unNumDePeano / unNumDePeano)] on: Error do: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	^'No se puede dividir por un numero mayor!!'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:36:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
next

	next ifNil: [ 
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].
	^next
	
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
previous
	^prev.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
previous: numDePeano
	prev := numDePeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
removeAllNext


	next ifNotNil:

	[
		next removeAllNext.

		next removeFromSystem.

		next := nil.

	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'VPM 9/1/2019 17:35:00'!
restaInversa: unNumDePeano
	
	^self previous restaInversa: unNumDePeano previous! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!