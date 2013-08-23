Class {
	#name : #ObjectBrowserVariableTestCase,
	#superclass : #LoopTestCase,
	#instVars : [
		'variable'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserVariableTestCase >> setUp [
	super setUp.
	variable := OBLessonVariable newNamed: 'pepita'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserVariableTestCase >> testDesreferenciarVariable [
	| anObject |
	anObject := 2.
	variable pointTo: anObject.
	self assert: variable pointsTo == anObject .
	variable desreference.
	self assert: variable pointsTo realObject == nil.
]

{ #category : #'as yet unclassified' }
ObjectBrowserVariableTestCase >> testNewVariableName [
	| varName |
	varName := 'pepita'.
	variable name: varName.
	self assert: variable name = varName.
]

{ #category : #'as yet unclassified' }
ObjectBrowserVariableTestCase >> testNewVariablePointsToNil [
	self assert: variable pointsTo == nil.
]

{ #category : #'as yet unclassified' }
ObjectBrowserVariableTestCase >> testPointVariableToObject [
	| anObject |
	anObject := 2.
	variable pointTo: anObject.
	self assert: variable pointsTo  = anObject .
]
