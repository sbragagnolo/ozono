"
I am a dictionary factory. My instances can create dictionaries and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBDictionaryFactory,
	#superclass : #OBCollectionFactory,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBDictionaryFactory >> collectionTypeName [
	^'Dictionary'
]

{ #category : #cloning }
OBDictionaryFactory >> createRealCollection [
	^OBDictionary new.
]

{ #category : #printing }
OBDictionaryFactory >> displayString [
	^ 'aDictionary'
]

{ #category : #'instance-creation' }
OBDictionaryFactory >> newMetaObjectForCollection: aRealCollection [

	| metaCollection |
	metaCollection := OBDictionaryMetaObject
						newWithRealObject: aRealCollection
						inLesson: lesson.
	aRealCollection metaObject: metaCollection.
	^metaCollection.
]
