Class {
	#name : #OBOrderedCollectionFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> clone [
	^ObjectBrowserCollection newOrdered .
]

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> collectionTypeName [
	^'OrderedCollection'
]

{ #category : #'as yet unclassified' }
OBOrderedCollectionFactory >> printString [
	^ 'anOrderedCollection'
]
