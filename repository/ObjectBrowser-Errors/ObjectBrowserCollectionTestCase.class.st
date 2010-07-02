Class {
	#name : #ObjectBrowserCollectionTestCase,
	#superclass : #TestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> agregarRepetidos: coleccion [
	coleccion add: 2.
	coleccion add: 2.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> setUp [
	Smalltalk at:#set put: (OBBaseSetCollection new). "esto deberia de estar en el initialize de clase del object browser"	
	Smalltalk at:#bag ifAbsentPut: (OBBaseBagCollection new). "esto deberia de estar en el initialize de clase del object browser"
	Smalltalk at:#ordered put: OBBaseOrderedCollection new. "esto deberia de estar en el initialize de clase del object browser"
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testAddDuplicateVariablesBag [
	|miBolsa|
	miBolsa := bolsa clone.
	self assert: 0 equals: miBolsa size.
	self agregarRepetidos: miBolsa .
	self assert: 2 equals: miBolsa size.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testAddDuplicateVariablesSet [
	|sinRepetidos|	
	sinRepetidos := conjunto clone .
	self agregarRepetidos: sinRepetidos .
	self assert: 1 equals: sinRepetidos size.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCloneCollectionNameExists [
	conjunto cloneWithName: 'unSet'.
	conjunto cloneWithName: 'unSet'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCreateBagCollection [
	|miConjunto |
	Smalltalk at:#bolsa ifAbsentPut: (OBBaseBagCollection new). 
	miConjunto:= bolsa clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCreateOrderedCollection [
	|miConjunto |
	miConjunto:= conjuntoOrdenado clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCreateSetCollection [
	|miConjunto |
	miConjunto:= conjunto clone.
	self assert: 0 equals: miConjunto size.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollectionTestCase >> testCreateSetCollectionFromObject [
	| method obo |
	obo := ObjectBrowserObject new.
	method := 'clonarUnaColeccion ^conjunto clone'.
	obo compileMethod: method.
	self assert: obo methods size = 1.
	self assert: (obo hasMethod: #unMetodo).
]
