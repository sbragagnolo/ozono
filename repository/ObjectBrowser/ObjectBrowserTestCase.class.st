Class {
	#name : #ObjectBrowserTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #tests }
ObjectBrowserTestCase >> testCreateDuplicatedVariable [
	| variableName |
	variableName :='pepita'.
	ob := OBLessonModel onLesson: currentLesson.
	ob createVariable: variableName .
	self should: [ob createVariable: variableName ] raise: Error
]

{ #category : #tests }
ObjectBrowserTestCase >> testCreateNonLowecaseVariable [
	self testCreateNonValidVariableNamed: 'Pepita'
]

{ #category : #tests }
ObjectBrowserTestCase >> testCreateNonValidVariableNamed: variableName [
	ob := OBLessonModel onLesson: currentLesson.
	self should: [ob createVariable: variableName ] raise: Error.
	self assert: (currentLesson hasVariableNamed: variableName) not
]

{ #category : #tests }
ObjectBrowserTestCase >> testCreateVariable [
	| variableName |
	variableName :='pepita'.
	ob := OBLessonModel onLesson: currentLesson.
	ob createVariable: variableName .
	self assert: (ob variableNamed: variableName) pointsTo class = OBMetaObject.
]

{ #category : #tests }
ObjectBrowserTestCase >> testCreateWrongCharVariable [
	' ,¡!¿?|%&()$#"''' do: [ :c |
			self testCreateNonValidVariableNamed: 'Pepita', c asString
		].
]
