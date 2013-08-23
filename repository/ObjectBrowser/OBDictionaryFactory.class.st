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
	^Dictionary new.
]

{ #category : #printing }
OBDictionaryFactory >> displayString [
	^ 'aDictionary'
]

{ #category : #'instance-creation' }
OBDictionaryFactory >> newMetaObjectForCollection: aRealCollection [

	^OBDictionaryMetaObject
			newWithRealObject: aRealCollection
			inLesson: lesson.
]
