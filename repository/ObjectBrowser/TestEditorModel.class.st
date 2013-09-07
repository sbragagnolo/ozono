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
	
	self errorHandler evaluate: [ [ [
		self model compileTest: unText notifying: someone
		] on: UndeclaredVariable
		do: [ :warn | warn asOBUndeclaredVariable signal ] 
		] on: SyntaxErrorNotification 
		do: [ :notification | testEditorMorph editString: notification errorCode. ]
	]
]

{ #category : #'as yet unclassified' }
TestEditorModel >> errorHandler [
	^ErrorHandler  default.
]

{ #category : #'code completion' }
TestEditorModel >> guessTypeForName: aString [
	| binding |
	(model lesson hasVariableNamed: aString) ifTrue: [
		^(model lesson variableNamed: aString) pointsTo realClass.
	] ifFalse: [
		^nil.
	].
]

{ #category : #'as yet unclassified' }
TestEditorModel >> menu: unMenu [ 
	unMenu addList: (OrderedCollection with: (Array braceWith: 'aceptar(s)' translated with: #accept)).
	^ unMenu
]

{ #category : #'as yet unclassified' }
TestEditorModel >> methodCode [
	^self model selectedTest code
]

{ #category : #accessing }
TestEditorModel >> selectedClassOrMetaClass [
	^self model lesson executionContext class
]

{ #category : #'as yet unclassified' }
TestEditorModel >> selectedTestCode [
	| c |
	c := self model selectedTest ifNotNil: [ :t | t code ].
	^c
]

{ #category : #styling }
TestEditorModel >> shoutAboutToStyle: aPluggableShoutMorphOrView [ 
	aPluggableShoutMorphOrView classOrMetaClass: self selectedClassOrMetaClass.
	^ true
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
