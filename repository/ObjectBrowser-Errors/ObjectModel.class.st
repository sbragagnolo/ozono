Class {
	#name : #ObjectModel,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectModel class >> newOn: realModel [ 
	^ self new model: realModel;
		 yourself
]

{ #category : #'as yet unclassified' }
ObjectModel >> model [
	^model
]

{ #category : #'as yet unclassified' }
ObjectModel >> model: aModel [ 
	model := aModel.
	aModel addDependent: self
]

{ #category : #'as yet unclassified' }
ObjectModel >> perform: aSelector [ 
	^ (super respondsTo: aSelector)
		ifTrue: [super perform: aSelector]
		ifFalse: [self model perform: aSelector]
]

{ #category : #'as yet unclassified' }
ObjectModel >> respondsTo: aSelector [
	^(super respondsTo: aSelector) or: [self model respondsTo: aSelector ]
]

{ #category : #'as yet unclassified' }
ObjectModel >> update: anObject [
	super update: anObject.
	self changed: self
]
