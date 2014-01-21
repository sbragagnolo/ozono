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
ObjectBrowserCollectionTestCase >> selectorsFor: aSymbol [
	^ (currentLesson literalNamed: aSymbol) clone metaObject methods collect: #selector
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> selectorsToDisplayFor: aClass [
	^ ((aClass allSuperclassesIncluding: Collection) gather: #methods) collect: #selector
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
ObjectBrowserCollectionTestCase >> testSelectorsToDisplay [
	self assert: ((self selectorsFor: #set) includesAll: (self selectorsToDisplayFor: Set)).
	self assert: ((self selectorsFor: #ordered) includesAll: (self selectorsToDisplayFor: OrderedCollection)).
	self assert: ((self selectorsFor: #bag) includesAll: (self selectorsToDisplayFor: Bag)).
	self assert: ((self selectorsFor: #sorted) includesAll: (self selectorsToDisplayFor: SortedCollection)).
	self assert: ((self selectorsFor: #dictionary) includesAll: (self selectorsToDisplayFor: Dictionary)).
]
