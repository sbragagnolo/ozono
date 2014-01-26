"
I am a dictionary factory. My instances can create dictionaries and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBDictionaryPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBDictionaryPrototype >> baseDisplayString [
	^ 'aDictionary'
]

{ #category : #'as yet unclassified' }
OBDictionaryPrototype >> collectionMetaObjectClass [
	^ OBDictionaryMetaObject
]

{ #category : #cloning }
OBDictionaryPrototype >> createRealCollection [
	^OBDictionary new.
]

{ #category : #accessing }
OBDictionaryPrototype >> id [
	^#dictionary
]
