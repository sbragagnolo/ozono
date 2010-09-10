Class {
	#name : #LOOPExecutionContext,
	#superclass : #Object,
	#instVars : [
		'_lesson',
		'sss',
		'hola',
		'tengo',
		'peipyo',
		'joaco',
		'anotonio',
		'ahora',
		'bolsita',
		'ordenadito',
		'pepita',
		'pepota',
		'esto',
		'esTest'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #'as yet unclassified' }
LOOPExecutionContext class >> evaluatorClass [
	 ^LOOPEvaluator
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> commitChanges [
	_lesson variables do:[:v | self getValueFromContext: v].
	_lesson changed.
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> getValueFromContext: anOBVariable [
	| value |
	value := self instVarNamed: anOBVariable name.
	(_lesson hasObject: value) 
		ifTrue: [anOBVariable pointTo: value] 
		ifFalse: [anOBVariable pointTo: (NoObjectBrowserObject new: value)].
	
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> lesson: aLesson [
	_lesson := aLesson.
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> prepare [
	_lesson variables do:[:v | self putInContext: v].
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> putInContext: anOBVariable [
	self instVarNamed: anOBVariable name put: anOBVariable pointsTo object.
	
]
