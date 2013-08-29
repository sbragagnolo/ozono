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

{ #category : #printing }
OBDictionaryPrototype >> collectionTypeName [
	^'Dictionary'
]

{ #category : #cloning }
OBDictionaryPrototype >> createRealCollection [
	^OBDictionary new.
]

{ #category : #'instance-creation' }
OBDictionaryPrototype >> newMetaObjectForCollection: aRealCollection [

	| metaCollection |
	metaCollection := OBDictionaryMetaObject
						newWithRealObject: aRealCollection
						inLesson: lesson.
	aRealCollection metaObject: metaCollection.
	^metaCollection.
]
