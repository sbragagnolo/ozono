Class {
	#name : #OBBaseSetCollection,
	#superclass : #OBBaseCollection,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBBaseSetCollection >> clone [
	^ObjectBrowserCollection newSet .
]

{ #category : #'as yet unclassified' }
OBBaseSetCollection >> cloneWithName: theName [
	^ObjectBrowserCollection newSet: theName.
]

{ #category : #'as yet unclassified' }
OBBaseSetCollection >> collectionTypeName [
	^'Set'
]

{ #category : #'as yet unclassified' }
OBBaseSetCollection >> printString [
	^ 'a BaseSetCollection'
]
