Class {
	#name : #OBBaseBagCollection,
	#superclass : #OBBaseCollection,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBBaseBagCollection >> clone [
	^ObjectBrowserCollection newBag .
]

{ #category : #'as yet unclassified' }
OBBaseBagCollection >> collectionTypeName [
	^'Bag'
]

{ #category : #'as yet unclassified' }
OBBaseBagCollection >> printString [
	^ 'aBag'
]
