Class {
	#name : #TestEditorModel,
	#superclass : #ObjectModel,
	#instVars : [
		'testEditorMorph'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
TestEditorModel >> acceptCode: unText notifying: someone [
	
	self errorHandler evaluate: [
		[self model compileTest: unText] 
			on: SyntaxErrorNotification 
			do:[ :notification | testEditorMorph editString: notification errorCode ]
	]

]

{ #category : #'as yet unclassified' }
TestEditorModel >> errorHandler [
	^ErrorHandler  default.
]

{ #category : #'as yet unclassified' }
TestEditorModel >> menu: aMenu [
	^ aMenu
	
]

{ #category : #'as yet unclassified' }
TestEditorModel >> methodCode [
	^self model selectedTest code
]

{ #category : #'as yet unclassified' }
TestEditorModel >> selectedTestCode [
	| c |
	c := self model selectedTest ifNotNil: [ :t | t code ].
	^c
]

{ #category : #'as yet unclassified' }
TestEditorModel >> testEditorMorph: aMorph [
	testEditorMorph := aMorph.
]

{ #category : #'as yet unclassified' }
TestEditorModel >> update: anObject [ 
	super update: anObject.
	self changed: #selectedTestCode.
	self changed: #listModel
]
