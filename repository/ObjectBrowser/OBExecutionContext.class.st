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
	#name : #OBExecutionContext,
	#superclass : #TestCase,
	#instVars : [
		'_lesson'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #compiling }
OBExecutionContext class >> evaluatorClass [
	 ^OBLessonEvaluator
]

{ #category : #execution }
OBExecutionContext >> commitChanges [

	_lesson variables do:[:v | self getValueFromContext: v].
	_lesson changed.
]

{ #category : #execution }
OBExecutionContext >> getValueFromContext: anOBVariable [

	| value |
	value := self instVarNamed: anOBVariable name.
	anOBVariable pointTo: value metaObject.
]

{ #category : #accessing }
OBExecutionContext >> lesson: aLesson [

	_lesson := aLesson
]

{ #category : #execution }
OBExecutionContext >> prepare [

	_lesson variables do:[:v | self putInContext: v].
]

{ #category : #execution }
OBExecutionContext >> putInContext: anOBVariable [

	self
		instVarNamed: anOBVariable name
		put: anOBVariable pointsTo concreteObject.
]
