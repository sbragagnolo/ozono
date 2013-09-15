"
I represent a test was not yet run
"
Class {
	#name : #OBTestNotRun,
	#superclass : #OBTestResult,
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #accessing }
OBTestNotRun >> icon [
	^OBIcons notRanIcon
]

{ #category : #testing }
OBTestNotRun >> isNotRun [
	^true.
]
