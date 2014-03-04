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

{ #category : #'instance-creation' }
OBDictionaryPrototype >> collectionMetaObjectClass [
	^ OBDictionaryMetaObject
]

{ #category : #cloning }
OBDictionaryPrototype >> collectionRealObjectClass [
	^ OBDictionary
]

{ #category : #cloning }
OBDictionaryPrototype >> createRealCollection [
	^self collectionRealObjectClass new.
]

{ #category : #accessing }
OBDictionaryPrototype >> id [
	^#dictionary
]
