"
I am a meta-object representing an special object attribute like the prototype relation. I implement mostly accessors for the attribute data such as the name of the attribute and the object referenced by it.
"
Class {
	#name : #OBSpecialAttribute,
	#superclass : #OBAbstractAttribute,
	#instVars : [
		'objectPointed'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBSpecialAttribute class >> newNamed: aNameString owner: owner pointingTo: anObject [

	^self new 
		name: aNameString;
		owner: owner; 
		objectPointed: anObject;
		yourself
]

{ #category : #visiting }
OBSpecialAttribute >> accept: aVisitor [

	aVisitor visitSpecialAttribute: self.
]

{ #category : #reference }
OBSpecialAttribute >> objectPointed [

	^objectPointed
]

{ #category : #reference }
OBSpecialAttribute >> objectPointed: anObject [

	objectPointed := anObject
]

{ #category : #reference }
OBSpecialAttribute >> pointsTo [
	^self objectPointed realObject
]

{ #category : #printing }
OBSpecialAttribute >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPutAll: '(';
		nextPutAll: self objectPointed printString;
		nextPutAll: ')'
]

{ #category : #reference }
OBSpecialAttribute >> withRelationships: someOtherRelationships [

	^someOtherRelationships copyWith: self
]
