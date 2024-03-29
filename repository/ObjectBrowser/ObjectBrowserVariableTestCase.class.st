Class {
	#name : #ObjectBrowserVariableTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'variable'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #fixture }
ObjectBrowserVariableTestCase >> setUp [
	super setUp.
	variable := OBLessonVariable newNamed: 'pepita'.
]

{ #category : #tests }
ObjectBrowserVariableTestCase >> testDesreferenciarVariable [
	| anObject |
	anObject := 2.
	variable pointTo: anObject metaObject.
	self assert: variable pointsTo baseObject == anObject .
	variable desreference.
	self assert: variable pointsTo baseObject == nil.
]

{ #category : #tests }
ObjectBrowserVariableTestCase >> testNewVariableName [
	| varName |
	varName := 'pepita'.
	variable name: varName.
	self assert: variable name = varName.
]

{ #category : #tests }
ObjectBrowserVariableTestCase >> testNewVariablePointsToNil [
	self assert: variable pointsTo baseObject == nil.
]

{ #category : #tests }
ObjectBrowserVariableTestCase >> testPointVariableToObject [
	| anObject |
	anObject := 2.
	variable pointTo: anObject metaObject.
	self assert: variable pointsTo baseObject  = anObject .
]
