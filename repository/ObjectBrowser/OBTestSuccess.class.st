"
I am a successful result from a test run
"
Class {
	#name : #OBTestSuccess,
	#superclass : #OBTestResult,
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #accessing }
OBTestSuccess >> icon [
	^OBIcons okIcon
]

{ #category : #testing }
OBTestSuccess >> isSuccess [
	^true
]
