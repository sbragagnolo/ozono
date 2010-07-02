Class {
	#name : #ObjectBrowserTestCase,
	#superclass : #TestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> setUp [
	LOOPLesson currentLesson: LOOPLesson freeLesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> tearDown [ 
	ob clean
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateDuplicatedVariable [
	| variableName |
	variableName :='pepita'.
	ob := ObjectBrowser new.
	ob createVariable: variableName .
	self should: [ob createVariable: variableName ] raise: Error
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateVariable [
	| variableName |
	variableName :='pepita'.
	ob := ObjectBrowser new.
	ob createVariable: variableName .
	self assert: (ob variableNamed: variableName) pointsTo class = ObjectBrowserObject.
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testRunGarbageCollector [
	| variableName variableToPepita pepita |
	variableName :='pepita'.
	ob := ObjectBrowser new.
	ob createVariable: variableName .
	variableToPepita := ob variableNamed: variableName.
	pepita := variableToPepita pointsTo.
	variableToPepita desreference.
	ob runGarbageCollector.
	self assert:(ob objects includes: pepita) not
]
