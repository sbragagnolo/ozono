Class {
	#name : #ObjectBrowserObjectTestCase,
	#superclass : #LoopTestCase,
	#instVars : [
		'ob',
		'obo',
		'otroObo'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #running }
ObjectBrowserObjectTestCase >> setUp [
	super setUp.
	obo := ObjectBrowserObject new.
]

{ #category : #running }
ObjectBrowserObjectTestCase >> tearDown [
	super tearDown.
	obo removeClassFromSystem.
	obo := nil.
	otroObo ifNotNil: [otroObo removeClassFromSystem].
	otroObo := nil.
]

{ #category : #'attribute-tests' }
ObjectBrowserObjectTestCase >> testAddDuplicatedVariable [
	| varName |
	varName := 'energia'.
	obo addVariable: varName .
	self should: [obo addVariable: varName] raise:Error.
	self assert: obo variables size = 1.
]

{ #category : #'method-tests' }
ObjectBrowserObjectTestCase >> testAddMethod [
	| method |
	method := 'unMetodo ^2'.
	obo compileMethod: method.
	self assert: obo methods size = 1.
	self assert: (obo hasMethod: #unMetodo).
]

{ #category : #'method-tests' }
ObjectBrowserObjectTestCase >> testAddSintacticBadMethod [
	| method |
	method := 'unMetodo ^2['.
	self should:[obo compileMethod: method] raise: SyntaxErrorNotification .
]

{ #category : #'attribute-tests' }
ObjectBrowserObjectTestCase >> testAddVariable [
	| varName |
	varName := 'energia'.
	obo addVariable: varName .
	self assert: obo variables size = 1.
	self assert: (obo hasVariable: varName).
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testCloneClassName [
	otroObo := obo clone.
	self assert: (obo realClass name beginsWith: 'ObjectBrowserObject').
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testCloneHasDifferentClass [
	otroObo := obo clone.
	self assert: (obo realClass ~= otroObo realClass).
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testClonePrototype [
	otroObo := obo clone.
	self assert: (obo == otroObo prototype).
]

{ #category : #'realClass-tests' }
ObjectBrowserObjectTestCase >> testNewObjectBrowserObjectClass [
	self assert: (obo realClass name beginsWith: 'ObjectBrowserObject').
]

{ #category : #'method-tests' }
ObjectBrowserObjectTestCase >> testNewObjectBrowserObjectMethods [
	self assert: (obo methods isEmpty).
]

{ #category : #'attribute-tests' }
ObjectBrowserObjectTestCase >> testNewObjectBrowserObjectVariables [
	self assert: (obo variables isEmpty).
]

{ #category : #'method-tests' }
ObjectBrowserObjectTestCase >> testRemoveMethod [
	| methodString method |
	methodString := 'unMetodo ^2'.
	obo compileMethod: methodString.
	method := obo methodOfSelector: #unMetodo.
	obo removeMethod: method.
	
	self assert: obo methods size = 0.
	self assert: (obo hasMethod: #unMetodo) not.
	self assert: (obo realClass includesSelector: method selector) not
]
