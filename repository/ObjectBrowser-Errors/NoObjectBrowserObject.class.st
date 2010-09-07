Class {
	#name : #NoObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'methods'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
NoObjectBrowserObject class >> new: anObject [
	^self new realObject: anObject; yourself.
]

{ #category : #accessing }
NoObjectBrowserObject >> actionsForObjectVariableList [
	^OrderedCollection new.
]

{ #category : #compiling }
NoObjectBrowserObject >> compileMethod: aText [ 
	self error: 'No puede modificarse este objeto'
]

{ #category : #accessing }
NoObjectBrowserObject >> methods [
	^methods
]

{ #category : #accessing }
NoObjectBrowserObject >> object [
	^realObject
]

{ #category : #accessing }
NoObjectBrowserObject >> realObject: anObject [ 
	realObject := anObject.
	methods := realObject class methods 
				collect:[:m | OBMethod new selector: (m selector); yourself ].
]

{ #category : #accessing }
NoObjectBrowserObject >> sourceCodeAt: anOBMethod [ 
	^(realObject class sourceCodeAt: anOBMethod selector)
				makeSelectorBoldIn: realObject class.
]

{ #category : #accessing }
NoObjectBrowserObject >> variables [
	^OrderedCollection new.
]