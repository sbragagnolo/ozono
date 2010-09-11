Class {
	#name : #LOOPWindow,
	#superclass : #Object,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPWindow class >> on: aLessonBrowser [
	^self new on: aLessonBrowser; yourself.
]
