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
	| lesson |
	lesson := LOOPLesson new.
	ob := ObjectBrowser onLesson: lesson.
	self should: [ob createVariable: variableName ] raise: Error.
	self assert: (lesson hasVariableNamed: variableName) not
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateVariable [
	| variableName lesson |
	variableName :='pepita'.
	lesson := LOOPLesson new.
	ob := ObjectBrowser onLesson: lesson.
	ob createVariable: variableName .
	self assert: (ob variableNamed: variableName) pointsTo class = ObjectBrowserObject.
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateWrongCharVariable [
	' ,¡!¿?|%&()$#"''' do: [ :c |
			self testCreateNonValidVariableNamed: 'Pepita', c asString
		].
]
