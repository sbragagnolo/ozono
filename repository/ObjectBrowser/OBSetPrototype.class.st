"
I am a set factory. My instances can create sets and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBSetPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBSetPrototype >> basDisplayString [
	^ 'aSet'
]

{ #category : #printing }
OBSetPrototype >> collectionTypeName [
	^'Set'
]

{ #category : #cloning }
OBSetPrototype >> createRealCollection [
	^OBSet new.
]
