Class {
	#name : #MethodEditorModel,
	#superclass : #ObjectModel,
	#instVars : [
		'methodCode'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
MethodEditorModel >> acceptCode: unText [
	self model compileMethod: unText.

]

{ #category : #'as yet unclassified' }
MethodEditorModel >> acceptCode: unText notifying: someone [
	self model compileMethod: unText notifying: someone.

]

{ #category : #'as yet unclassified' }
MethodEditorModel >> menu: unMenu [ 
	unMenu addList: #(#('aceptar(s)' #accept) ).
	^ unMenu
]

{ #category : #'as yet unclassified' }
MethodEditorModel >> methodCode [
	^self model selectedSelector
]

{ #category : #'as yet unclassified' }
MethodEditorModel >> update: anObject [ 
	super update: anObject.
	self changed: #selectedSelectorCode.
	self changed: #listModel
]
