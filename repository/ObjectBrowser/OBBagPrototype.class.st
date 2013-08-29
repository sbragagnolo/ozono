"
I am a bag factory. My instances can create bags and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBBagPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBBagPrototype >> baseDisplayString [
	^'aBag'
]

{ #category : #printing }
OBBagPrototype >> collectionTypeName [
	^'Bag'
]

{ #category : #cloning }
OBBagPrototype >> createRealCollection [
	^OBBag new.
]
