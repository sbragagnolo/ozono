Class {
	#name : #OBTestsTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'pepita'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
OBTestsTestCase >> setUp [ 
	super setUp.
	pepita := currentLesson createObject.
	currentLesson createVariableNamed: 'pepita' pointingTo: pepita.
]

{ #category : #'as yet unclassified' }
OBTestsTestCase >> testReferenceAreNotClearedAfterTestCase [
	| test |
	self assert: (currentLesson hasVariableNamed: 'pepita').
	test := currentLesson compileTest: 'simpleTest.
		self assert: pepita isNotNil.' notifying: nil.
		
	test run.
	
	self assert: (currentLesson hasVariableNamed: 'pepita').
	self assert: (currentLesson variableNamed: 'pepita') pointsTo = pepita.
]
