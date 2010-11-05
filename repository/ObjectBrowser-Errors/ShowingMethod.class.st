Class {
	#name : #ShowingMethod,
	#superclass : #Object,
	#instVars : [
		'object',
		'method'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
ShowingMethod class >> object: anObject method: aMethod [
	^self new object: anObject ; method: aMethod ; yourself
]

{ #category : #accessing }
ShowingMethod >> code [
	^method code
]

{ #category : #'as yet unclassified' }
ShowingMethod >> icon [
	^method iconFor: object
]

{ #category : #'as yet unclassified' }
ShowingMethod >> method: aMethod [
	method := aMethod
]

{ #category : #'as yet unclassified' }
ShowingMethod >> object: anObject [
	object := anObject 
]

{ #category : #'as yet unclassified' }
ShowingMethod >> printString [
	^method printString
]
