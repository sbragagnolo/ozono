"
I am a ordered collection factory. My instances can create ordered collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBOrderedCollectionFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBOrderedCollectionFactory >> collectionTypeName [
	^'OrderedCollection'
]

{ #category : #cloning }
OBOrderedCollectionFactory >> createRealCollection [
	^OrderedCollection new.
]

{ #category : #printing }
OBOrderedCollectionFactory >> displayString [
	^'anOrderedCollection'
]
