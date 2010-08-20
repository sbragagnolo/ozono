Class {
	#name : #LOOPExecutionContext,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'pepita'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #'as yet unclassified' }
LOOPExecutionContext class >> evaluatorClass [
	 ^LOOPEvaluator
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> commitChanges [
	lesson variables do:[:v | self getValueFromContext: v].
	
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> getValueFromContext: anOBVariable [
	| value |
	value := self instVarNamed: anOBVariable name.
	anOBVariable pointTo: value.
	
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> lesson: aLesson [
	lesson := aLesson.
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> prepare [
	lesson variables do:[:v | self putInContext: v].
]

{ #category : #'as yet unclassified' }
LOOPExecutionContext >> putInContext: anOBVariable [
	self instVarNamed: anOBVariable name put: anOBVariable pointsTo.
	
]
