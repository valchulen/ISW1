!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/2/2019 19:30:06'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self check: [customerBook addCustomerNamed: 'John Lennon'] fasterThan: (50 * millisecond)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/2/2019 21:11:57'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook newWithActiveCustomerNamed: paulMcCartney.
	
	self check: [customerBook removeCustomerNamed: paulMcCartney.] fasterThan: (100 * millisecond)
	  
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/2/2019 20:47:21'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
	
	customerBook := CustomerBook new.
	
	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/7/2019 11:57:26'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithActiveCustomerNamed: johnLennon.
	
	self check: customerBook  cannotDo: [ customerBook removeCustomerNamed: 'Paul McCartney' ] withoutError: NotFound.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/7/2019 11:25:20'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook newWithSuspendedCustomerNamed: paulMcCartney.
	
	self checkCustomerBook: customerBook hasNumberOfActiveCustomers:  0 numberOfInactive: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/7/2019 11:25:51'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook newWithActiveCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkCustomerBook: customerBook hasNumberOfActiveCustomers: 0  numberOfInactive: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/7/2019 11:50:19'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithActiveCustomerNamed: johnLennon.
		
	self check: customerBook cannotSuspend: 'Paul McCartney'.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'VPM 9/7/2019 11:51:04'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook newWithSuspendedCustomerNamed: johnLennon.
	
	self check: customerBook cannotSuspend: johnLennon.
! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'VPM 9/7/2019 12:00:53'!
check: aCustomerBook cannotDo: aBlock withoutError: aTypeOfError
	| previousActiveCustomers previousSuspendedCustomers|
	
	previousActiveCustomers  := aCustomerBook activeCustomers.
	previousSuspendedCustomers  := aCustomerBook suspendedCustomers.
	
	[ aBlock value.
	self fail ]
		on: aTypeOfError 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = (previousActiveCustomers size + previousSuspendedCustomers size).
			previousActiveCustomers do: [:name | self assert: (aCustomerBook includesCustomerNamed: name)].
			previousSuspendedCustomers do: [:name | self assert: (aCustomerBook includesCustomerNamed: name)]. 
			^self. ].
	self fail.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'VPM 9/7/2019 11:55:44'!
check: aCustomerBook cannotSuspend: aCustomer

	self check: aCustomerBook cannotDo: [aCustomerBook suspendCustomerNamed: aCustomer] withoutError: CantSuspend.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'VPM 9/2/2019 19:35:22'!
check: aClosure fasterThan: aTimeInSomeUnit
	|  timeBeforeRunning timeAfterRunning |
	
	timeBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	timeAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (timeAfterRunning-timeBeforeRunning) < aTimeInSomeUnit! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'VPM 9/7/2019 11:24:49'!
checkCustomerBook: aCustomerBook hasNumberOfActiveCustomers: numberOfActive numberOfInactive: numberOfInactive
	self assert: numberOfActive equals: aCustomerBook numberOfActiveCustomers.
	self assert: numberOfInactive equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: (numberOfActive + numberOfInactive) equals: aCustomerBook numberOfCustomers.
	! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'VPM 9/7/2019 11:41:32'!
activeCustomers
	^active! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !

!CustomerBook methodsFor: 'testing' stamp: 'VPM 9/7/2019 11:41:46'!
suspendedCustomers
	^suspended! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !

!CustomerBook methodsFor: 'initialization' stamp: 'VPM 9/2/2019 21:11:33'!
initializeWithActiveCustomerNamed: aName
	self addCustomerNamed: aName! !

!CustomerBook methodsFor: 'initialization' stamp: 'VPM 9/2/2019 21:11:44'!
initializeWithSuspendedCustomerNamed: aName
	suspended add: aName! !


!CustomerBook methodsFor: 'customer management' stamp: 'VPM 9/2/2019 20:32:23'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'VPM 9/2/2019 20:29:47'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'VPM 9/2/2019 20:08:27'!
removeCustomerNamed: aName 
 	active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [	
			^ NotFound signal
		]
	].
	^aName
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'VPM 9/7/2019 12:01:34'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !


!CustomerBook class methodsFor: 'creators' stamp: 'VPM 9/2/2019 21:10:01'!
newWithActiveCustomerNamed: aName
	^self new initializeWithActiveCustomerNamed: aName! !

!CustomerBook class methodsFor: 'creators' stamp: 'VPM 9/2/2019 21:10:43'!
newWithSuspendedCustomerNamed: aName
	^self new initializeWithSuspendedCustomerNamed: aName! !
