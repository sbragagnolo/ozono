"
I am a sorted collection factory. My instances can create sorted collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBSortedPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBSortedPrototype >> baseDisplayString [
	^ 'aSorted'
]

{ #category : #printing }
OBSortedPrototype >> collectionTypeName [
	^'Sorted'
]

{ #category : #cloning }
OBSortedPrototype >> createRealCollection [
	^OBSortedCollection new.
]
