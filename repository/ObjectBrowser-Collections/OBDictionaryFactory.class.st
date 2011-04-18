Class {
	#name : #OBDictionaryFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBDictionaryFactory >> collectionTypeName [
	^'Dictionary'
]

{ #category : #'as yet unclassified' }
OBDictionaryFactory >> createCollection [
	^Dictionary new.
]

{ #category : #'as yet unclassified' }
OBDictionaryFactory >> displayString [
	^ 'aDictionary'
]
