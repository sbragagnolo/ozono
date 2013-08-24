"
I am a set factory. My instances can create sets and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBSetFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBSetFactory >> collectionTypeName [
	^'Set'
]

{ #category : #cloning }
OBSetFactory >> createRealCollection [
	^OBSet new.
]

{ #category : #printing }
OBSetFactory >> displayString [
	^ 'aSet'
]
