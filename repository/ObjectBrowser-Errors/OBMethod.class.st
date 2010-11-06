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
	^self iconFor: object
]

{ #category : #'as yet unclassified' }
OBMethod >> iconFor: anObject [
	| redefines isRedefined iHaveMethod |
	redefines := anObject redefines: self selector.
	isRedefined := anObject isRedefined: self selector.
	"(anObject myClassHasMethod: self) ifTrue: [ ^ObjectBrowserIcons prototype ]."
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
