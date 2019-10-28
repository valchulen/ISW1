!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gl 10/24/2019 16:41:31'!
test08TransfersWorkAsExpected 

	| accountSender accountReceiver |
	
	accountSender := ReceptiveAccount  new.
	accountReceiver := ReceptiveAccount new.
	Deposit register: 100 on: accountSender.
	WireTransfer register: 50 from: accountSender to: accountReceiver.		
	self assert: 50 equals: accountSender balance .
	self assert: 50 equals: accountReceiver balance .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gl 10/24/2019 16:50:51'!
test09AccountKnowsItsHasTransferedMoney 

	| accountSender accountReceiver transfer |
	
	accountSender := ReceptiveAccount  new.
	accountReceiver := ReceptiveAccount new.
	Deposit register: 100 on: accountSender.
	transfer := WireTransfer register: 50 from: accountSender to: accountReceiver.
		
	self assert: 2 equals: accountSender transactions size .
	self assert: (accountSender transactions includes: transfer wireTransferOut).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gl 10/24/2019 17:39:09'!
test10AccountKnowsItsHasReceivedMoney 

	| accountSender accountReceiver transfer |
	
	accountSender := ReceptiveAccount  new.
	accountReceiver := ReceptiveAccount new.
	Deposit register: 100 on: accountSender.
	transfer := WireTransfer register: 50 from: accountSender to: accountReceiver.
		
	self assert: 2 equals: accountSender transactions size .
	self assert: (accountReceiver transactions includes: transfer wireTransferIn).
	"Method object y double dispatch generico  withNewLine"
	"desde el reporte: account HaceAlgo self para no romper el encapsulamiento"
	"desde accounts: haceAlgo hace un do sobre todas las transacciones"
	""! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gl 10/28/2019 16:12:41'!
test11ReceptiveAccountSummaryReportWorks

	| account account2 report|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	WireTransfer register: 50 from: account2 to: account.
	WireTransfer register: 25 from: account to: account2.
	
	report := SummaryReport newWith: account.
	self assert:  
'Depósito por 100.
Extracción por 50.
Entrada por transferencia de 50.
Salida por transferencia de 25.
Balance=75'   
	equals: report value.		
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gl 10/28/2019 16:18:09'!
test12ReceptiveTransferNetReportWorks

	| account account2 report|
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	WireTransfer register: 50 from: account2 to: account.
	WireTransfer register: 25 from: account to: account2.
	
	report := TransferNetReport newWith: account.
	self assert:  'Neto de transferencias=25' equals: report value.		
	
! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'gl 10/28/2019 15:47:16'!
getSummaryReport

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'gl 10/28/2019 16:12:15'!
getSummaryReport
	| report |
	report := ''.
	transactions do: [:transaction | 
		report := report, (transaction getSummaryReportInfoWith: transaction value)].
	report := report, 'Balance=',  self balance asString.
	^report.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'gl 10/28/2019 16:16:28'!
getTransferNetReport
	| balance |
	balance := 0.
	transactions do: [:transaction | balance := balance + (transaction getTransferNetReportInfoWith: balance).].
	^'Neto de transferencias=', balance asString.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 14:26:41'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'report' stamp: 'gl 10/28/2019 15:36:59'!
getSummaryReportInfoWith: aBalance

	self subclassResponsibility  ! !

!AccountTransaction methodsFor: 'report' stamp: 'gl 10/28/2019 15:52:04'!
getTransferNetReportInfoWith:  aBalance

	self subclassResponsibility  ! !


!AccountTransaction methodsFor: 'value' stamp: 'gl 10/24/2019 16:17:24'!
initializeFor: aValue

	self subclassResponsibility  ! !

!AccountTransaction methodsFor: 'value' stamp: 'gl 10/21/2019 21:05:06'!
value

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 14:27:17'!
for: aValue

	^ self new initializeFor: aValue! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 14:27:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'gl 10/28/2019 16:07:39'!
getSummaryReportInfoWith: aBalance

	^ 'Depósito por ', aBalance asString, '.', String newLineString! !

!Deposit methodsFor: 'balance' stamp: 'gl 10/28/2019 15:52:20'!
getTransferNetReportInfoWith:  aBalance

	^ 0.  ! !

!Deposit methodsFor: 'balance' stamp: 'gl 10/24/2019 16:15:37'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'balance' stamp: 'gl 10/21/2019 21:06:20'!
value
	^ value.! !


!classDefinition: #WireTransferIn category: #'Portfolio-Solucion'!
AccountTransaction subclass: #WireTransferIn
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransferIn methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:18:41'!
affectBalance: aBalance

	^aBalance + transfer value ! !

!WireTransferIn methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 16:03:39'!
getSummaryReportInfoWith: aBalance

	^ 'Entrada por transferencia de ', aBalance asString, '.', String newLineString! !

!WireTransferIn methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 15:53:06'!
getTransferNetReportInfoWith:  aBalance

	^ transfer value.  ! !

!WireTransferIn methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:29:14'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!WireTransferIn methodsFor: 'as yet unclassified' stamp: 'gl 10/21/2019 21:07:29'!
sender
	^ transfer sender.! !

!WireTransferIn methodsFor: 'as yet unclassified' stamp: 'gl 10/21/2019 21:06:59'!
value
	^ transfer value.! !


!classDefinition: #WireTransferOut category: #'Portfolio-Solucion'!
AccountTransaction subclass: #WireTransferOut
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransferOut methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:18:50'!
affectBalance: aBalance

	^aBalance - transfer value! !

!WireTransferOut methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 16:03:29'!
getSummaryReportInfoWith: aBalance

	^ 'Salida por transferencia de ', aBalance asString, '.', String newLineString! !

!WireTransferOut methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 15:53:50'!
getTransferNetReportInfoWith:  aBalance

	^ transfer value * (-1).  ! !

!WireTransferOut methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:29:26'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!WireTransferOut methodsFor: 'as yet unclassified' stamp: 'gl 10/21/2019 21:02:54'!
receiver
	^ transfer receiver! !

!WireTransferOut methodsFor: 'as yet unclassified' stamp: 'gl 10/21/2019 21:07:07'!
value
	^ transfer value.! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'gl 10/28/2019 16:07:50'!
getSummaryReportInfoWith: aBalance

	^ 'Extracción por ', aBalance asString, '.', String newLineString! !

!Withdraw methodsFor: 'balance' stamp: 'gl 10/28/2019 15:52:36'!
getTransferNetReportInfoWith:  aBalance

	^ 0.  ! !

!Withdraw methodsFor: 'balance' stamp: 'gl 10/24/2019 16:17:04'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'balance' stamp: 'gl 10/21/2019 21:06:29'!
value
	^ value.! !


!classDefinition: #AccountsReport category: #'Portfolio-Solucion'!
Object subclass: #AccountsReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountsReport methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 15:31:33'!
initializeFor: anAccount
	account := anAccount.! !

!AccountsReport methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 15:31:13'!
value

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountsReport class' category: #'Portfolio-Solucion'!
AccountsReport class
	instanceVariableNames: ''!

!AccountsReport class methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 15:30:00'!
newWith: anAccount
	^ self new initializeFor: anAccount! !


!classDefinition: #SummaryReport category: #'Portfolio-Solucion'!
AccountsReport subclass: #SummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 15:32:06'!
value
	^ account getSummaryReport.! !


!classDefinition: #TransferNetReport category: #'Portfolio-Solucion'!
AccountsReport subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'gl 10/28/2019 16:13:22'!
value
	^ account getTransferNetReport.! !


!classDefinition: #WireTransfer category: #'Portfolio-Solucion'!
Object subclass: #WireTransfer
	instanceVariableNames: 'value sender receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:37:27'!
initializeFor: aValue

	value := aValue ! !

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:38:07'!
setTransactionsIn: wireIn out: wireOut
	sender := wireOut.
	receiver := wireIn.! !

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 17:21:43'!
value
	^value! !

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:48:46'!
wireTransferIn
	^receiver! !

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:48:40'!
wireTransferOut
	^sender! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransfer class' category: #'Portfolio-Solucion'!
WireTransfer class
	instanceVariableNames: ''!

!WireTransfer class methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:37:03'!
for: aValue

	^ self new initializeFor: aValue! !

!WireTransfer class methodsFor: 'as yet unclassified' stamp: 'gl 10/24/2019 16:51:26'!
register: aValue from: aSender to: aReceiver

	| transfer wireIn wireOut|
	
	transfer := self for: aValue.
	wireOut := WireTransferOut register: transfer on: aSender.
	wireIn := WireTransferIn register: transfer on: aReceiver.
	transfer setTransactionsIn: wireIn out: wireOut. 
	^ transfer.! !
