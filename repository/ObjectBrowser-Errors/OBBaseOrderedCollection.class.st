Class {
	#name : #OBBaseOrderedCollection,
	#superclass : #OBBaseCollection,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBBaseOrderedCollection >> clone [
	^ObjectBrowserCollection newOrdered .
]

{ #category : #'as yet unclassified' }
OBBaseOrderedCollection >> collectionTypeName [
	^'OrderedCollection'
]

{ #category : #'as yet unclassified' }
OBBaseOrderedCollection >> printString [
	^ 'anOrderedCollection'
]
