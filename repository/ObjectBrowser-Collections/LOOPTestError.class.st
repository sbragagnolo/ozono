Class {
	#name : #LOOPTestError,
	#superclass : #Object,
	#instVars : [
		'signal'
	],
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'as yet unclassified' }
LOOPTestError class >> new: aSignal [
	^self new signal: aSignal;
		yourself 
]

{ #category : #'as yet unclassified' }
LOOPTestError >> icon [
	^ObjectBrowserIcons badIcon
]

{ #category : #'as yet unclassified' }
LOOPTestError >> isError [
	^true
]

{ #category : #'as yet unclassified' }
LOOPTestError >> isFailure [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestError >> isSuccess [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestError >> signal: aSignal [
	signal := aSignal
]
