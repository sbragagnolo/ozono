"
I am a successful result from a test run
"
Class {
	#name : #OBTestSuccess,
	#superclass : #OBTestResult,
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #testing }
OBTestSuccess >> color [
	^ Color green
]

{ #category : #testing }
OBTestSuccess >> description [
	^ '¡Un éxito!' translated
]

{ #category : #accessing }
OBTestSuccess >> icon [
	^OBIcons okIcon
]

{ #category : #testing }
OBTestSuccess >> isSuccess [
	^true
]
