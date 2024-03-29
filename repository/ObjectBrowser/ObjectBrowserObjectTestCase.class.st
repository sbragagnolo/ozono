Class {
	#name : #ObjectBrowserObjectTestCase,
	#superclass : #OBTestCase,
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
	obo := currentLesson createObject.
]

{ #category : #'attribute-tests' }
ObjectBrowserObjectTestCase >> testAddDuplicatedVariable [
	| varName |
	varName := 'energia'.
	obo addAttributeNamed: varName .
	self should: [obo addAttributeNamed: varName] raise: Exception.
	self assert: obo attributes size = 1.
]

{ #category : #'method-tests' }
ObjectBrowserObjectTestCase >> testAddMethod [
	| method |
	method := 'unMetodo ^2'.
	obo compileMethod: method.
	self assert: obo methods size = 1.
	self assert: (obo includesSelector: #unMetodo).
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
	obo addAttributeNamed: varName .
	self assert: obo attributes size = 1.
	self assert: (obo hasAttributeNamed: varName).
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testCloneAnObjectWithAnAttribute [
	| varName |
	varName := 'energia'.
	obo addAttributeNamed: varName .
	otroObo := obo clone.
	self assert: (otroObo hasAttributeNamed: varName).
	self assert: (otroObo basicObjectAtAttributeNamed: varName) equals: nil. 
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testCloneClassName [
	otroObo := obo clone.
	self assert: ((OBPharoReflection uniqueInstance classNameOfObject: obo baseObject) beginsWith: OBObject name).
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testCloneHasDifferentClass [
	otroObo := obo clone.
	self assert: ((OBPharoReflection uniqueInstance classOf: obo baseObject) ~= (OBPharoReflection uniqueInstance classOf: otroObo baseObject)).
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testClonePrototype [
	otroObo := obo clone.
	self assert: (obo == otroObo prototype).
]

{ #category : #'clone-tests' }
ObjectBrowserObjectTestCase >> testCloneUnderstandsItsPrototypesMessage [
	| method |
	method := 'unMetodo ^2'.
	obo compileMethod: method.
	otroObo := obo clone.
	self assert: (otroObo includesSelector: #unMetodo).
	self assert: otroObo baseObject unMetodo equals: 2
]

{ #category : #'realClass-tests' }
ObjectBrowserObjectTestCase >> testNewObjectBrowserObjectClass [
	self assert: ((OBPharoReflection uniqueInstance classNameOfObject: obo baseObject) beginsWith: OBObject name).
]

{ #category : #'method-tests' }
ObjectBrowserObjectTestCase >> testNewObjectBrowserObjectMethods [
	self assert: (obo methods isEmpty).
]

{ #category : #'attribute-tests' }
ObjectBrowserObjectTestCase >> testNewObjectBrowserObjectVariables [
	self assert: (obo attributes isEmpty).
]

{ #category : #'method-tests' }
ObjectBrowserObjectTestCase >> testRemoveMethod [
	| methodString method |
	methodString := 'unMetodo ^2'.
	obo compileMethod: methodString.
	method := obo >> #unMetodo.
	obo removeMethod: method.
	
	self assert: obo methods size = 0.
	self assert: (obo includesSelector: #unMetodo) not.
	self assert: ((OBPharoReflection uniqueInstance classOf: obo baseObject) includesSelector: method selector) not
]
