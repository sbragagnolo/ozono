"
I am a failure from a test run
"
Class {
	#name : #OBTestFailure,
	#superclass : #OBTestResult,
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'instance creation' }
OBTestFailure class >> new: aSignal [
	^self new signal: aSignal;
		yourself 
]

{ #category : #testing }
OBTestFailure >> color [
	^ Color yellow
]

{ #category : #testing }
OBTestFailure >> description [
	^ signal messageText 
]

{ #category : #accessing }
OBTestFailure >> icon [
	^OBIcons warnIcon
]

{ #category : #testing }
OBTestFailure >> isFailure [
	^true
]
