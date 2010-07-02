Class {
	#name : #OBBaseOrderedCollection,
	#superclass : #OBBaseCollection,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBBaseOrderedCollection >> clone [
	^ObjectBrowserCollection newOrdered .
]

{ #category : #'as yet unclassified' }
OBBaseOrderedCollection >> cloneWithName: theName [
	^ObjectBrowserCollection newOrdered: theName.
]

{ #category : #'as yet unclassified' }
OBBaseOrderedCollection >> printString [
	^ 'a BaseOrderedCollection'
]
