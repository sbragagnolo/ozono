Class {
	#name : #OBBagFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBBagFactory >> clone [
	^ObjectBrowserCollection newBag .
]

{ #category : #'as yet unclassified' }
OBBagFactory >> collectionTypeName [
	^'Bag'
]

{ #category : #'as yet unclassified' }
OBBagFactory >> printString [
	^ 'aBag'
]
