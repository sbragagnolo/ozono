"
I am a ordered collection factory. My instances can create ordered collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBOrderedCollectionPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBOrderedCollectionPrototype >> baseDisplayString [
	^'anOrderedCollection'
]

{ #category : #'as yet unclassified' }
OBOrderedCollectionPrototype >> collectionMetaObjectClass [
	^ OBOrderedCollectionMetaObject
]

{ #category : #cloning }
OBOrderedCollectionPrototype >> createRealCollection [
	^OBOrderedCollection new.
]

{ #category : #accessing }
OBOrderedCollectionPrototype >> id [

	^ #ordered
]
