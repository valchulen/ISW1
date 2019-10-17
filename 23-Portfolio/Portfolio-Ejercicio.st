!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 18:52:30'!
test01CreatesPortfolioWithAccount
	| account1 portfolio1 |
	account1 := ReceptiveAccount new.
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	
	self assert: (portfolio1 hasAccount: account1).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 18:55:51'!
test02CantAddAlreadyAddedPortfolio
	| account1 portfolio1 |
	account1 := ReceptiveAccount new.
	portfolio1 := Portfolio new.
	portfolio1 add: account1.
	
	self should: [ portfolio1 add: account1  ]
		raise: Error
		withMessageText: (Portfolio cantAddAlreadyAddedAccount ).
	self assert: (portfolio1 hasAccount: account1).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 18:56:46'!
test03CantAddItself
	| portfolio1 |
	
	portfolio1 := Portfolio new.
	
	self should: [ portfolio1 add: portfolio1  ]
		raise: Error
		withMessageText: (Portfolio cantAddAlreadyAddedAccount).
	self assert: (portfolio1 hasAccount: portfolio1).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 18:58:31'!
test04AddsAnotherPortfolio

	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 add: portfolio2.
	self assert: (portfolio1 hasAccount: portfolio2).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:17:50'!
test05CantHaveCircularPortfolios
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio1 add: portfolio2.
	
	self should: [ portfolio2 add: portfolio1  ]
		raise: Error
		withMessageText: (Portfolio cantAddAlreadyAddedAccount).
	self assert: (portfolio1 hasAccount: portfolio2).
	self deny: (portfolio2 hasAccount: portfolio1).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 19:15:41'!
test06PortfolioHasTransactionsForAccount

	| account deposit withdraw portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: account.
	
	deposit :=  Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 19:16:54'!
test07PortfolioHasTransactionsForMultipleAccountsOneLevelDown

	| deposit withdraw portfolio account1 account2 portfolio2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio2 := Portfolio new.
	portfolio2 add: account2.
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: portfolio2.
	
	deposit :=  Deposit register: 100 on: account1.
	withdraw := Withdraw register: 50 on: account2.
		
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 19:21:01'!
test08PortfolioBalanceForOneAccount

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: account.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: portfolio balance equals: 50! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 19:22:06'!
test09PortfolioBalanceForMultipleAccountsOneLevelDown

	| portfolio account1 account2 portfolio2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio2 := Portfolio new.
	portfolio2 add: account2.
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: portfolio2.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account2.
		
	self assert: portfolio balance equals: 50! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:43:51'!
test10CantHaveSameAccountOnDifferentPortfolios
	| portfolio1 portfolio2 account portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio1 add: account.
	portfolio2 add: account.
	portfolio3 := (Portfolio new) add: portfolio1; yourself.
	
	self should: [ portfolio3 add: portfolio1 ]
		raise: Error
		withMessageText: (Portfolio cantAddAlreadyAddedAccount).
		
	self assert: (portfolio3 hasAccount: portfolio1).
	self assert: (portfolio3 hasAccount: account).
	self deny: (portfolio3 hasAccount: portfolio2).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:22:37'!
test11PortfolioHasHimself
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio hasAccount: portfolio)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:54:40'!
test12PortfolioHasHimselfAndSomeoneElse
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self assert: (portfolio hasAccount: portfolio).
	self assert: (portfolio hasAccount: account).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:54:46'!
test13OneAccountMultiplePortfolios
	| account portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	portfolio1 add: account.
	portfolio2 add: account.
	
	self assert: (portfolio1 hasAccount: account).
	self assert: (portfolio2 hasAccount: account).! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'VPM 10/17/2019 18:35:14'!
balanceModification
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'VPM 10/17/2019 18:35:44'!
balanceModification
	^ self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'VPM 10/17/2019 18:35:29'!
balanceModification
	^ self value negated! !

!Withdraw methodsFor: 'value' stamp: 'VPM 10/17/2019 18:34:41'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:17:15'!
add: anAccount
	(self internalAccounts intersection: anAccount internalAccounts) ifNotEmpty: [ self error: Portfolio cantAddAlreadyAddedAccount ].
	accounts add: anAccount! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 19:20:27'!
balance
	^ accounts sum: [ :anAccount | anAccount balance ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:23:17'!
hasAccount: anAccount
	^ self internalAccounts includes: anAccount! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 19:10:27'!
hasRegistered: aTransaction
	^ accounts inject: false into: [ :a :b | a or: [ b hasRegistered: aTransaction ]].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 18:37:49'!
initialize
	accounts := Set new! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 20:54:22'!
internalAccounts
	^ (accounts collect: [ :anAccount | anAccount internalAccounts ]) inject: (Set with: self) into: [ :a :b | a addAll: b. a ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'VPM 10/17/2019 18:41:12'!
cantAddAlreadyAddedAccount
	^ 'No se puede agregar una cuenta que ya esta en el portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'VPM 10/17/2019 20:14:21'!
internalAccounts
	^ Set with: self! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'VPM 10/17/2019 18:35:55'!
balance

	^transactions sum: [ :aTransaction | aTransaction balanceModification ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'VPM 10/17/2019 18:50:43'!
hasAccount: anAccount
	^ self == anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
