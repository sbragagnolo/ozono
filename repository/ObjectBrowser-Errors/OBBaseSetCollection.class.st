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
OBBaseSetCollection >> collectionTypeName [
	^'Set'
]

{ #category : #'as yet unclassified' }
OBBaseSetCollection >> displayString [
	^ 'aSet'
]

{ #category : #'as yet unclassified' }
OBBaseSetCollection >> printString [
	^ 'a BaseSetCollection'
]
