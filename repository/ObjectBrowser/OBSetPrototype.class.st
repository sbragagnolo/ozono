"
I am a set factory. My instances can create sets and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBSetPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBSetPrototype >> baseDisplayString [
	^ 'aSet'
]

{ #category : #'as yet unclassified' }
OBSetPrototype >> collectionMetaObjectClass [
	^ OBSetMetaObject
]

{ #category : #cloning }
OBSetPrototype >> createRealCollection [
	^OBSet new.
]

{ #category : #accessing }
OBSetPrototype >> id [

	^ #set
]
