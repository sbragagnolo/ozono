Class {
	#name : #ObjectBrowserTestCase,
	#superclass : #LoopTestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateDuplicatedVariable [
	| variableName |
	variableName :='pepita'.
	ob := ObjectBrowser onLesson: currentLesson.
	ob createVariable: variableName .
	self should: [ob createVariable: variableName ] raise: Error
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateNonLowecaseVariable [
	self testCreateNonValidVariableNamed: 'Pepita'
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateNonValidVariableNamed: variableName [
	ob := ObjectBrowser onLesson: currentLesson.
	self should: [ob createVariable: variableName ] raise: Error.
	self assert: (currentLesson hasVariableNamed: variableName) not
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateVariable [
	| variableName |
	variableName :='pepita'.
	ob := ObjectBrowser onLesson: currentLesson.
	ob createVariable: variableName .
	self assert: (ob variableNamed: variableName) pointsTo class = OBNormalMetaObject.
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateWrongCharVariable [
	' ,¡!¿?|%&()$#"''' do: [ :c |
			self testCreateNonValidVariableNamed: 'Pepita', c asString
		].
]
