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
OBBaseBagCollection >> cloneWithName: theName [
	^ObjectBrowserCollection newBag: theName.
]

{ #category : #'as yet unclassified' }
OBBaseBagCollection >> collectionTypeName [
	^'Bag'
]

{ #category : #'as yet unclassified' }
OBBaseBagCollection >> printString [
	^ 'a BaseBagCollection'
]
