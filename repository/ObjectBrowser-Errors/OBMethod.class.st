Class {
	#name : #OBMethod,
	#superclass : #Object,
	#instVars : [
		'object',
		'selector'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBMethod >> icon [
	^nil
]

{ #category : #'as yet unclassified' }
OBMethod >> object: anOBO [
	^object := anOBO.
]

{ #category : #'as yet unclassified' }
OBMethod >> printString [
	^selector asString.
]

{ #category : #'as yet unclassified' }
OBMethod >> selector [
	^selector
]

{ #category : #'as yet unclassified' }
OBMethod >> selector: aByteSymbol [ 
	selector := aByteSymbol 
]
