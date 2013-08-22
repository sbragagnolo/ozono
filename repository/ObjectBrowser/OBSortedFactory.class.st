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
