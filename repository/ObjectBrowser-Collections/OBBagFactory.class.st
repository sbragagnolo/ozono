Class {
	#name : #OBBagFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBBagFactory >> collectionTypeName [
	^'Bag'
]

{ #category : #'as yet unclassified' }
OBBagFactory >> createCollection [
	^Bag new.
]

{ #category : #'as yet unclassified' }
OBBagFactory >> displayString [
	^'aBag'
]
