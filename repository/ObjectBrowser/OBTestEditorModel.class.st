Class {
	#name : #OBTestEditorModel,
	#superclass : #OBAbstractModel,
	#instVars : [
		'testEditorMorph'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBTestEditorModel >> acceptCode: unText notifying: someone [
	
	self errorHandler evaluate: [
		[self model compileTest: unText] 
			on: SyntaxErrorNotification 
			do:[ :notification | testEditorMorph editString: notification errorCode ]
	]

]

{ #category : #'as yet unclassified' }
OBTestEditorModel >> errorHandler [
	^ErrorHandler  default.
]

{ #category : #'code completion' }
OBTestEditorModel >> guessTypeForName: aString [
	| binding |
	(model lesson hasVariableNamed: aString) ifTrue: [
		^(model lesson variableNamed: aString) pointsTo realClass.
	] ifFalse: [
		^nil.
	].
]

{ #category : #'as yet unclassified' }
OBTestEditorModel >> menu: unMenu [ 
	unMenu addList: (OrderedCollection with: (Array braceWith: 'aceptar(s)' translated with: #accept)).
	^ unMenu
]

{ #category : #'as yet unclassified' }
OBTestEditorModel >> methodCode [
	^self model selectedTest code
]

{ #category : #accessing }
OBTestEditorModel >> selectedClassOrMetaClass [
	^self model lesson executionContext class
]

{ #category : #'as yet unclassified' }
OBTestEditorModel >> selectedTestCode [
	| c |
	c := self model selectedTest ifNotNil: [ :t | t code ].
	^c
]

{ #category : #styling }
OBTestEditorModel >> shoutAboutToStyle: aPluggableShoutMorphOrView [ 
	aPluggableShoutMorphOrView classOrMetaClass: self selectedClassOrMetaClass.
	^ true
]

{ #category : #'as yet unclassified' }
OBTestEditorModel >> testEditorMorph: aMorph [
	testEditorMorph := aMorph.
]

{ #category : #'as yet unclassified' }
OBTestEditorModel >> update: anObject [ 
	super update: anObject.
	self changed: #selectedTestCode.
	self changed: #listModel
]
