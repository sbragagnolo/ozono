"
I am a ordered collection factory. My instances can create ordered collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBOrderedCollectionFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> collectionTypeName [
	^'OrderedCollection'
]

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> createCollection [
	^OrderedCollection new.
]

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> displayString [
	^'anOrderedCollection'
]
