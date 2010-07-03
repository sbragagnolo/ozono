Class {
	#name : #LoopTestCase,
	#superclass : #TestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
LoopTestCase >> setUp [
	LOOPLesson currentLesson: LOOPLesson freeLesson.
]

{ #category : #'as yet unclassified' }
LoopTestCase >> tearDown [ 
	LOOPLesson currentLesson clean
]
