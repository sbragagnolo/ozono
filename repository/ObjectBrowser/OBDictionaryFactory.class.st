"
I am a dictionary factory. My instances can create dictionaries and are used as prototypes in the lesson workspace.
"
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

{ #category : #'as yet unclassified' }
OBDictionaryFactory >> newObjectBrowserObjectWithRealObject: aRealCollection [

	^OBDictionaryMetaObject
			newWithRealObject: aRealCollection
			inLesson: lesson.
]
