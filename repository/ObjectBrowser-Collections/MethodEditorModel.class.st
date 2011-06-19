Class {
	#name : #MethodEditorModel,
	#superclass : #ObjectModel,
	#instVars : [
		'methodCode',
		'methodEditorMorph',
		'controller',
		'selectedClassOrMetaClass'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
MethodEditorModel >> acceptCode: unText notifying: someone [
	
	self errorHandler evaluate: [
		[self model compileMethod: unText notifying: someone] 
			on: SyntaxErrorNotification 
			do:[ :notification | methodEditorMorph editString: notification errorCode ]
	]

]

{ #category : #'as yet unclassified' }
MethodEditorModel >> completionController [
	^controller ifNil: [
		controller := (ECPreferences useECompletionInsteadOfOCompletion
			ifFalse: [ OController ]
			ifTrue: [ ECController ]) model: self
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
	^self model selectedMethod
]

{ #category : #'as yet unclassified' }
MethodEditorModel >> methodEditorMorph: aMorph [
	methodEditorMorph := aMorph.
]

{ #category : #accessing }
MethodEditorModel >> selectedClassOrMetaClass [
	^selectedClassOrMetaClass
]

{ #category : #accessing }
MethodEditorModel >> selectedClassOrMetaClass: aClassOrMetaClass [
	^selectedClassOrMetaClass := aClassOrMetaClass
]

{ #category : #'as yet unclassified' }
MethodEditorModel >> update: anObject [ 
	super update: anObject.
	self changed: #selectedMethodCode.
	self changed: #listModel
]
