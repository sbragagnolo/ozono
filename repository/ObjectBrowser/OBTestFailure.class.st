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

{ #category : #accessing }
OBTestFailure >> icon [
	^OBIcons warnIcon
]

{ #category : #testing }
OBTestFailure >> isFailure [
	^true
]
