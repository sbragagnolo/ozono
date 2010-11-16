Class {
	#name : #OBOrderedCollectionFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> clone [
	^OrderedCollection new.
]

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> collectionTypeName [
	^'OrderedCollection'
]

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> displayString [
	^'anOrderedCollection'
]
