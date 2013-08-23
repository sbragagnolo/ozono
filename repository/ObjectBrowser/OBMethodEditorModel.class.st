Class {
	#name : #OBMethodEditorModel,
	#superclass : #OBAbstractModel,
	#instVars : [
		'methodCode',
		'methodEditorMorph',
		'controller',
		'selectedClassOrMetaClass'
	],
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #actions }
OBMethodEditorModel >> acceptCode: unText notifying: someone [
	
	self errorHandler evaluate: [
		[self model compileMethod: unText notifying: someone.
		^true
		] 
		on: SyntaxErrorNotification
		do:[ :notification | 
			methodEditorMorph editString: notification errorCode. 
			^false 
		]
	]

]

{ #category : #actions }
OBMethodEditorModel >> errorHandler [
	^ErrorHandler  default.
]

{ #category : #'code completion' }
OBMethodEditorModel >> guessTypeForName: aString [
	| object |
	object := self model selectedObject.
	^(object hasAttributeNamed: aString)
		ifTrue: [ (object attributeNamed: aString) objectPointed class ]
		ifFalse: [ nil ]
]

{ #category : #actions }
OBMethodEditorModel >> menu: unMenu [ 
	unMenu addList: (OrderedCollection  with: (Array braceWith: 'aceptar(s)' translated with: #accept)).
	^ unMenu
]

{ #category : #accessing }
OBMethodEditorModel >> methodEditorMorph: aMorph [
	methodEditorMorph := aMorph.
]

{ #category : #accessing }
OBMethodEditorModel >> selectedClassOrMetaClass [
	^selectedClassOrMetaClass
]

{ #category : #accessing }
OBMethodEditorModel >> selectedClassOrMetaClass: aClassOrMetaClass [
	^selectedClassOrMetaClass := aClassOrMetaClass
]

{ #category : #accessing }
OBMethodEditorModel >> selectedMethodCode [
	^self model selectedMethodCode
]

{ #category : #styling }
OBMethodEditorModel >> shoutAboutToStyle: aPluggableShoutMorphOrView [ 
	aPluggableShoutMorphOrView classOrMetaClass: self selectedClassOrMetaClass.
	^ true
]

{ #category : #updating }
OBMethodEditorModel >> update: anObject [ 
	super update: anObject.
	self changed: #selectedMethodCode.
	self changed: #listModel
]
