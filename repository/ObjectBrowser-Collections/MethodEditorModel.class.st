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

{ #category : #actions }
MethodEditorModel >> acceptCode: unText notifying: someone [
	
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
MethodEditorModel >> errorHandler [
	^ErrorHandler  default.
]

{ #category : #'code completion' }
MethodEditorModel >> guessTypeForName: aString [
	| object |
	object := self model selectedObject.
	^(object hasVariable: aString)
		ifTrue: [ (object variableNamed: aString) objectPointed class ]
		ifFalse: [ nil ]
]

{ #category : #actions }
MethodEditorModel >> menu: unMenu [ 
	unMenu addList: (OrderedCollection  with: (Array braceWith: 'aceptar(s)' translated with: #accept)).
	^ unMenu
]

{ #category : #accessing }
MethodEditorModel >> methodCode [
	^self model selectedMethod
]

{ #category : #accessing }
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

{ #category : #styling }
MethodEditorModel >> shoutAboutToStyle: aPluggableShoutMorphOrView [ 
	aPluggableShoutMorphOrView classOrMetaClass: self selectedClassOrMetaClass.
	^ true
]

{ #category : #updating }
MethodEditorModel >> update: anObject [ 
	super update: anObject.
	self changed: #selectedMethodCode.
	self changed: #listModel
]
