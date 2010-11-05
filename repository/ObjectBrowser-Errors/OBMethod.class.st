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
	^object realClass sourceCodeAt: self selector
]

{ #category : #'as yet unclassified' }
OBMethod >> icon [
	| redefines isRedefined iHaveMethod |
	redefines := object redefines: self selector.
	isRedefined := object isRedefined: self selector.
	iHaveMethod := object myClassHasMethod: self selector.
	iHaveMethod not ifTrue: [ ^ObjectBrowserIcons prototype ].
	redefines & isRedefined ifTrue: [ ^ObjectBrowserIcons arrowUpAndDown ].
	redefines ifTrue: [ ^ObjectBrowserIcons arrowUp ].
	isRedefined  ifTrue: [ ^ObjectBrowserIcons arrowDown ].
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
