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
	currentLesson := OBLesson new.
]

{ #category : #'as yet unclassified' }
LoopTestCase >> tearDown [ 
	currentLesson clean.
	OBLesson lessons removeAll.
]
