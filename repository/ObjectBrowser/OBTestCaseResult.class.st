"
I gather the results of a test case run
"
Class {
	#name : #OBTestCaseResult,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #accessing }
OBTestCaseResult >> add: aResult [
	self results add: aResult
]

{ #category : #ui }
OBTestCaseResult >> color [
	self hasErrors 
		ifTrue: [ ^ Color red ].
	self hasFailures 
		ifTrue: [ ^ Color yellow ].
	^Color green
]

{ #category : #accessing }
OBTestCaseResult >> errors [
	^self results select: [ :r | r isError ].
]

{ #category : #accessing }
OBTestCaseResult >> failures [
	^self results select: [ :r | r isFailure ].
]

{ #category : #testing }
OBTestCaseResult >> hasErrors [
	^self results anySatisfy: [ :r | r isError ].
]

{ #category : #testing }
OBTestCaseResult >> hasFailures [
	^self results anySatisfy: [ :r | r isFailure ].
]

{ #category : #printing }
OBTestCaseResult >> printString [
	^'Errores: ' translated , 
		self errors size printString, 
		' Fallas: ' translated , 
		self failures size printString, 
		' Exitos: ' translated , 
		self succeededTests size printString
]

{ #category : #accessing }
OBTestCaseResult >> results [
	^results ifNil: [ results := Set new ].
]

{ #category : #accessing }
OBTestCaseResult >> succeededTests [
	^self results select: [ :r | r isSuccess ].
]
