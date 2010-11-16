Class {
	#name : #OBSetFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBSetFactory >> clone [
	^ObjectBrowserCollection newSet .
]

{ #category : #'as yet unclassified' }
OBSetFactory >> collectionTypeName [
	^'Set'
]

{ #category : #'as yet unclassified' }
OBSetFactory >> displayString [
	^ 'aSet'
]

{ #category : #'as yet unclassified' }
OBSetFactory >> printString [
	^ 'aSet'
]
