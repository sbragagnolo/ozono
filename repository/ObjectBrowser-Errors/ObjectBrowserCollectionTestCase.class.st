Class {
	#name : #ObjectBrowserCollectionTestCase,
	#superclass : #LoopTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> agregarRepetidos: coleccion [
	coleccion add: 2.
	coleccion add: 2.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> setUp [
	super setUp.
	OBBaseCollection initialize.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testAddDuplicateVariablesBag [
	|miBolsa|
	miBolsa := bag clone.
	self assert: 0 equals: miBolsa size.
	self agregarRepetidos: miBolsa .
	self assert: 2 equals: miBolsa size.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testAddDuplicateVariablesSet [
	|sinRepetidos|	
	sinRepetidos := set clone .
	self agregarRepetidos: sinRepetidos .
	self assert: 1 equals: sinRepetidos size.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCreateBagCollection [
	|miConjunto |
	miConjunto:= bag clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCreateOrderedCollection [
	|miConjunto |
	miConjunto:= ordered clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCreateSetCollection [
	|miConjunto |
	miConjunto:= set clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testObtainFirst [
	|miConjunto |
	miConjunto:= ordered clone.
	miConjunto add: 1.
	miConjunto add: 2.
	self assert: 1 equals: miConjunto first .
]
