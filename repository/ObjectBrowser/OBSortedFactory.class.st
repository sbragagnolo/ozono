"
I am a sorted collection factory. My instances can create sorted collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBSortedFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBSortedFactory >> collectionTypeName [
	^'Sorted'
]

{ #category : #cloning }
OBSortedFactory >> createRealCollection [
	^SortedCollection new.
]

{ #category : #printing }
OBSortedFactory >> displayString [
	^ 'aSorted'
]
