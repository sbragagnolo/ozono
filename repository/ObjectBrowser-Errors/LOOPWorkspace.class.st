Class {
	#name : #LOOPWorkspace,
	#superclass : #SHWorkspace,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPWorkspace >> bindingOf: aString [ 
	"Variables must be always declared, and they are bound to the current object browser"
	bindings isNil
		ifTrue: [self initializeBindings].
	(bindings includesKey: aString)
		ifTrue:[^ (bindings associationAt: aString)]
		ifFalse: [self error: aString, ' no es una variable definida ni un literal válido'].
	
]
