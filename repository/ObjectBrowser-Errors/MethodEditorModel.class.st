Class {
	#name : #MethodEditorModel,
	#superclass : #ObjectModel,
	#instVars : [
		'methodCode',
		'methodEditorMorph'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
MethodEditorModel >> acceptCode: unText [
	self error: 'No deberia estar aca.'.
	self model compileMethod: unText.

]

{ #category : #'as yet unclassified' }
MethodEditorModel >> acceptCode: unText notifying: someone [
	
	self errorHandler evaluate: [
		[self model compileMethod: unText] 
			on: SyntaxErrorNotification 
			do:[ :notification | methodEditorMorph editString: notification errorCode ]
	]

]

{ #category : #'as yet unclassified' }
MethodEditorModel >> errorHandler [
	^ErrorHandler  default.
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
MethodEditorModel >> methodEditorMorph: aMorph [
	methodEditorMorph := aMorph.
]

{ #category : #'as yet unclassified' }
MethodEditorModel >> update: anObject [ 
	super update: anObject.
	self changed: #selectedSelectorCode.
	self changed: #listModel
]
