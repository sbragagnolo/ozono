"
I am a meta-object representing a method inside the object browser. I implement mostly accessors for the method data such as selector and code.

I also implement some UI related stuff such as the icon and menu items.
"
Class {
	#name : #OBMethod,
	#superclass : #Object,
	#instVars : [
		'object',
		'selector'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #visiting }
OBMethod >> accept: aVisitor [

	aVisitor visitMethod: self
]

{ #category : #accessing }
OBMethod >> code [

	^ OBPharoReflection uniqueInstance inClassOfObject: object baseObject sourceCodeOfMethodWithSelector: self selector
]

{ #category : #ui }
OBMethod >> deleteConfirmationMessage [
	^ '¿Está seguro de eliminar el método?' translated
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
	redefines & isRedefined ifTrue: [ ^OBIcons arrowUpAndDown ].
	redefines ifTrue: [ ^OBIcons arrowUp ].
	isRedefined ifTrue: [ ^OBIcons arrowDown ].
	^nil
]

{ #category : #ui }
OBMethod >> menuItems [

	^#(('Eliminar Metodo' deleteMethod))
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
