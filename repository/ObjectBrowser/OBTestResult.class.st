"
I am a result from a test run
"
Class {
	#name : #OBTestResult,
	#superclass : #Object,
	#instVars : [
		'signal'
	],
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #accessing }
OBTestResult >> icon [

	self subclassResponsibility
]

{ #category : #testing }
OBTestResult >> isError [

	^false
]

{ #category : #testing }
OBTestResult >> isFailure [

	^false
]

{ #category : #testing }
OBTestResult >> isNotRun [

	^false
]

{ #category : #testing }
OBTestResult >> isSuccess [

	^false
]

{ #category : #accessing }
OBTestResult >> signal: aSignal [

	signal := aSignal
]
