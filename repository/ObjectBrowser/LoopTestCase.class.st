Class {
	#name : #LoopTestCase,
	#superclass : #TestCase,
	#instVars : [
		'currentLesson'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
LoopTestCase >> setUp [
	"LOOPLesson currentLesson: LOOPLesson freeLesson."
	currentLesson := LOOPLesson new.
]

{ #category : #'as yet unclassified' }
LoopTestCase >> tearDown [ 
	currentLesson clean.
	LOOPLesson lessons removeAll.
]
