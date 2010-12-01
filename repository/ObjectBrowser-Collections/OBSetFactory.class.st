Class {
	#name : #OBSetFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBSetFactory >> collectionTypeName [
	^'Set'
]

{ #category : #'as yet unclassified' }
OBSetFactory >> createCollection [
	^Set new.
]

{ #category : #'as yet unclassified' }
OBSetFactory >> displayString [
	^ 'aSet'
]
