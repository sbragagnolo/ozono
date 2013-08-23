Class {
	#name : #OBAbstractModel,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBAbstractModel class >> newOn: realModel [ 
	^ self new model: realModel;
		 yourself
]

{ #category : #'code completion' }
OBAbstractModel >> isCodeCompletionAllowed [
	^true
]

{ #category : #'as yet unclassified' }
OBAbstractModel >> model [
	^model
]

{ #category : #'as yet unclassified' }
OBAbstractModel >> model: aModel [ 
	model := aModel.
	aModel addDependent: self
]

{ #category : #'as yet unclassified' }
OBAbstractModel >> perform: aSelector [ 
	^ (super respondsTo: aSelector)
		ifTrue: [super perform: aSelector]
		ifFalse: [self model perform: aSelector]
]

{ #category : #'as yet unclassified' }
OBAbstractModel >> respondsTo: aSelector [
	^(super respondsTo: aSelector) or: [self model respondsTo: aSelector ]
]

{ #category : #'as yet unclassified' }
OBAbstractModel >> update: anObject [
	super update: anObject.
	self changed: self
]
