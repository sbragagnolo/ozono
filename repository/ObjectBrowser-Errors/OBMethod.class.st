Class {
	#name : #OBMethod,
	#superclass : #Object,
	#instVars : [
		'object',
		'selector'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #accessing }
OBMethod >> code [
	^(object myClassHasMethod: self)
		ifTrue: [(object realClass sourceCodeAt: self selector)
				makeSelectorBoldIn: object realClass]
		ifFalse: [object prototype sourceCodeAt: self]
]

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
