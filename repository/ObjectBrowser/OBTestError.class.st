"
I am an erroneous result from a test run
"
Class {
	#name : #OBTestError,
	#superclass : #OBTestResult,
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'instance creation' }
OBTestError class >> new: aSignal [
	^self new signal: aSignal;
		yourself 
]

{ #category : #testing }
OBTestError >> color [
	^ Color red
]

{ #category : #accessing }
OBTestError >> icon [
	^OBIcons badIcon
]

{ #category : #testing }
OBTestError >> isError [
	^true
]
