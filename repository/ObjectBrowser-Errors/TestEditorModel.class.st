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
TestEditorModel >> testEditorMorph: aMorph [
	testEditorMorph := aMorph.
]
