Class {
	#name : #GarbageCollectorTestCase,
	#superclass : #LoopTestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
GarbageCollectorTestCase >> testRunGarbageCollector [
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
