"
I am a bag factory. My instances can create bags and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBBagFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBBagFactory >> collectionTypeName [
	^'Bag'
]

{ #category : #cloning }
OBBagFactory >> createRealCollection [
	^OBBag new.
]

{ #category : #printing }
OBBagFactory >> displayString [
	^'aBag'
]
