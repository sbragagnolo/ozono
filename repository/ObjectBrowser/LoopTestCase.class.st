Class {
	#name : #LoopTestCase,
	#superclass : #TestCase,
	#instVars : [
		'currentLesson'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #running }
LoopTestCase >> setUp [
	"LOOPLesson currentLesson: LOOPLesson freeLesson."
	currentLesson := OBLesson new.
]

{ #category : #running }
LoopTestCase >> tearDown [ 
	currentLesson clean.
	OBLesson lessons removeAll.
]
