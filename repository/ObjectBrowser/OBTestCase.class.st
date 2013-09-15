Class {
	#name : #OBTestCase,
	#superclass : #TestCase,
	#instVars : [
		'currentLesson'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #running }
OBTestCase >> setUp [
	"LOOPLesson currentLesson: LOOPLesson freeLesson."
	currentLesson := OBLesson new.
]

{ #category : #running }
OBTestCase >> tearDown [ 
	currentLesson clean.
	OBLesson lessons removeAll.
]
