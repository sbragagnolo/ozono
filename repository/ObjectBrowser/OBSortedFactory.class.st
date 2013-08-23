"
I am a sorted collection factory. My instances can create sorted collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBSortedFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBSortedFactory >> collectionTypeName [
	^'Sorted'
]

{ #category : #'as yet unclassified' }
OBSortedFactory >> createCollection [
	^SortedCollection new.
]

{ #category : #'as yet unclassified' }
OBSortedFactory >> displayString [
	^ 'aSorted'
]
