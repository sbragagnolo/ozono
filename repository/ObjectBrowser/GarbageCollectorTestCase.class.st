Class {
	#name : #GarbageCollectorTestCase,
	#superclass : #LoopTestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
GarbageCollectorTestCase >> testComplexRunGarbageCollector [
	| variableName variableToPepita pepita anotherVariableName anotherVariable popote |
	"En este test feo se crean 2 objetos y uno pasa a conocer al otro (pepita conoce a popote).  Luego desreferencio a popote y corro el garbage collector. "
	
	variableName :='pepita'.
	anotherVariableName := 'popote'.
	ob := OBLessonModel onLesson: currentLesson.
	
	ob createVariable: variableName .
	variableToPepita := ob variableNamed: variableName.
	pepita := variableToPepita pointsTo.
	
	ob createVariable:  anotherVariableName.
	anotherVariable := ob variableNamed: anotherVariableName.
	popote := anotherVariable pointsTo.
	
	pepita addAttributeNamed: 'alguien'.
	pepita compileMethod: 'a: a alguien := a'.
	
	pepita realObject a: popote realObject.
	anotherVariable desreference.
	
	ob runGarbageCollector.
	self assert:(ob objects includes: popote)
]

{ #category : #'as yet unclassified' }
GarbageCollectorTestCase >> testSimpleRunGarbageCollector [
	| variableName variableToPepita pepita |
	variableName :='pepita'.
	ob := OBLessonModel onLesson: currentLesson.
	ob createVariable: variableName .
	variableToPepita := ob variableNamed: variableName.
	pepita := variableToPepita pointsTo.
	variableToPepita desreference.
	
	ob runGarbageCollector.
	
	self assert:(ob objects includes: pepita) not
]
