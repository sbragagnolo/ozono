Class {
	#name : #LOOPTestCaseResult,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #accessing }
LOOPTestCaseResult >> add: aResult [
	self results add: aResult
]

{ #category : #accessing }
LOOPTestCaseResult >> color [
	self hasErrors 
		ifTrue: [ ^ Color red ].
	self hasFailures 
		ifTrue: [ ^ Color yellow ].
	^Color green
]

{ #category : #accessing }
LOOPTestCaseResult >> errors [
	^self results select: [ :r | r isError ].
]

{ #category : #accessing }
LOOPTestCaseResult >> failures [
	^self results select: [ :r | r isFailure ].
]

{ #category : #accessing }
LOOPTestCaseResult >> hasErrors [
	^self results anySatisfy: [ :r | r isError ].
]

{ #category : #accessing }
LOOPTestCaseResult >> hasFailures [
	^self results anySatisfy: [ :r | r isFailure ].
]

{ #category : #accessing }
LOOPTestCaseResult >> printString [
	^'Errores: ', 
		self errors size printString, 
		' Fallas: ', 
		self failures size printString, 
		' Exitos: ', 
		self succeededTests size printString
]

{ #category : #accessing }
LOOPTestCaseResult >> results [
	^results ifNil: [ results := Set new ].
]

{ #category : #accessing }
LOOPTestCaseResult >> succeededTests [
	^self results select: [ :r | r isSuccess ].
]
