"
I am the object that is used to execute code from the lesson. On top of me is executed both:
- the code from the workspace
- the tests

Every time some code is going to be executed, the following steps are followed:

- put all the objects from the lesson variables into my instance variables
- run the code
- put the objects referenced by my instance variables into the lesson variables, in case they were assigned
"
Class {
	#name : #LOOPExecutionContext,
	#superclass : #TestCase,
	#instVars : [
		'_lesson'
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
	anOBVariable pointTo: (_lesson getObjectBrowserObjectFromRealObject: value).
	
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
	self instVarNamed: anOBVariable name put: anOBVariable pointsTo realObject.
	
]
