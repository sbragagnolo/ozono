Class {
	#name : #LOOPWorkspace,
	#superclass : #SHWorkspace,
	#instVars : [
		'lesson'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPWorkspace >> bindingOf: aString [ 
	(self hasBindingOf: aString)
		ifTrue:[^ aString -> (lesson variableNamed: aString)]
		ifFalse: [self error: aString, ' no es una variable definida ni un literal válido'].
	
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> hasBindingOf: aString [ 
	^lesson hasVariable: aString.
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> lesson: aLesson [
	lesson := aLesson.
]
