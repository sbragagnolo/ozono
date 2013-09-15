Class {
	#name : #OBGarbageCollectorTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #tests }
OBGarbageCollectorTestCase >> testComplexRunGarbageCollector [
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
	
	pepita baseObject a: popote baseObject.
	anotherVariable desreference.
	
	ob runGarbageCollector.
	self assert:(ob objects includes: popote)
]

{ #category : #tests }
OBGarbageCollectorTestCase >> testSimpleRunGarbageCollector [
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
