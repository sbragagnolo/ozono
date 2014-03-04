Class {
	#name : #ObjectBrowserCollectionTestCase,
	#superclass : #OBTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> agregarRepetidos: coleccion [
	coleccion add: 2.
	coleccion add: 2.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> allCollectionSelectorsFor: aClass [
	^ (aClass selectors union: (aClass allSelectorsAboveUntil: Collection)) asSet
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> selectorsFor: aSymbol [
	^ (currentLesson literalNamed: aSymbol) clone metaObject methods collect: #selector
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testAddDuplicateVariablesBag [
	|miBolsa|
	miBolsa := (currentLesson literalNamed: #bag) clone.
	self assert: 0 equals: miBolsa size.
	self agregarRepetidos: miBolsa .
	self assert: 2 equals: miBolsa size.
	
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testAddDuplicateVariablesSet [
	|sinRepetidos|	
	sinRepetidos := (currentLesson literalNamed: #set) clone.
	self agregarRepetidos: sinRepetidos .
	self assert: 1 equals: sinRepetidos size.
	
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testCollectionsCreatedWithClassesWorkInMethods [
	| pepita |
	pepita := currentLesson createObject.
	currentLesson createVariableNamed: 'pepita' pointingTo: pepita.
	self assert: (currentLesson hasVariableNamed: 'pepita').
	pepita addAttributeNamed: 'col'.
	pepita compileMethod: 'initialize
		col := Bag new.
		col add: 1.
		col add: 2.'.
	pepita compileMethod: 'size
		^ col size'.
	pepita baseObject initialize.
	self assert: pepita baseObject size equals: 2.
	
	
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testCollectionsCreatedWithClassesWorkInTests [
	|test|
	test := currentLesson compileTest: 'testHelloNurse
	| col |
	col := OrderedCollection new.
	col add: 1.
	col add: 2.
	self assert: col size equals: 2.'.
	
	self assert: test run isSuccess.
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testCollectionsCreatedWithClassesWorkInWorkspace [
	OrderedCollection new.
	'must create workspace'
	self assert: false.
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testConstantSelectorList [
	self testConstantSelectorListsForLiteral: #set.
	self testConstantSelectorListsForLiteral: #ordered.
	self testConstantSelectorListsForLiteral: #dictionary.
	self testConstantSelectorListsForLiteral: #sorted.
	self testConstantSelectorListsForLiteral: #bag.
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testConstantSelectorListsForLiteral: aSymbol [
	| aCollection |
	aCollection := (currentLesson literalNamed: aSymbol) clone.
	self assert: aCollection metaObject selectorsToDisplay == aCollection metaObject selectorsToDisplay
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testCreateBagCollection [
	|miConjunto |
	miConjunto:= (currentLesson literalNamed: #bag) clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testCreateOrderedCollection [
	|miConjunto |
	miConjunto:= (currentLesson literalNamed: #ordered) clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testCreateSetCollection [
	|miConjunto |
	miConjunto:= (currentLesson literalNamed: #set) clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testObtainFirst [
	|miConjunto |
	miConjunto:= (currentLesson literalNamed: #ordered) clone.
	miConjunto add: 1.
	miConjunto add: 2.
	self assert: 1 equals: miConjunto first .
]

{ #category : #tests }
ObjectBrowserCollectionTestCase >> testSelectorsBelongToCorrespondingClass [

	self assert: ((self allCollectionSelectorsFor: Set) includesAll: (self selectorsFor: #set)).
	self assert: ((self allCollectionSelectorsFor: Bag) includesAll: (self selectorsFor: #bag)).
	self assert: ((self allCollectionSelectorsFor: SortedCollection) includesAll: (self selectorsFor: #sorted)).
	self assert: ((self allCollectionSelectorsFor: OrderedCollection) includesAll: (self selectorsFor: #ordered)).
	self assert: ((self allCollectionSelectorsFor: Dictionary) includesAll: (self selectorsFor: #dictionary))
]
