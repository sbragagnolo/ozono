Class {
	#name : #LOOPTestFailure,
	#superclass : #Object,
	#instVars : [
		'signal'
	],
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'as yet unclassified' }
LOOPTestFailure class >> new: aSignal [
	^self new signal: aSignal;
		yourself 
]

{ #category : #'as yet unclassified' }
LOOPTestFailure >> icon [
	^ObjectBrowserIcons warnIcon
]

{ #category : #'as yet unclassified' }
LOOPTestFailure >> isError [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestFailure >> isFailure [
	^true
]

{ #category : #'as yet unclassified' }
LOOPTestFailure >> isNotRan [
	^false.
]

{ #category : #'as yet unclassified' }
LOOPTestFailure >> isSuccess [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestFailure >> signal: aSignal [
	signal := aSignal
]
