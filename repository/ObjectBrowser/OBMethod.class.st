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

{ #category : #ui }
OBMethod >> icon [

	^self iconFor: object
]

{ #category : #ui }
OBMethod >> iconFor: anObject [

	| redefines isRedefined |
	redefines := anObject redefines: self selector.
	isRedefined := anObject isRedefined: self selector.
	redefines & isRedefined ifTrue: [ ^ObjectBrowserIcons arrowUpAndDown ].
	redefines ifTrue: [ ^ObjectBrowserIcons arrowUp ].
	isRedefined ifTrue: [ ^ObjectBrowserIcons arrowDown ].
	^nil
]

{ #category : #ui }
OBMethod >> menuItems [

	^#(('borrar metodo'			deleteMethod))
]

{ #category : #accessing }
OBMethod >> object: anOBO [

	^object := anOBO.
]

{ #category : #printing }
OBMethod >> printString [

	^selector asString.
]

{ #category : #accessing }
OBMethod >> selector [

	^selector
]

{ #category : #accessing }
OBMethod >> selector: aByteSymbol [ 

	selector := aByteSymbol 
]
