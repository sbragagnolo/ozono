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

{ #category : #'instance-creation' }
OBOrderedCollectionPrototype >> collectionMetaObjectClass [
	^ OBOrderedCollectionMetaObject
]

{ #category : #cloning }
OBOrderedCollectionPrototype >> collectionRealObjectClass [
	^ OBOrderedCollection
]

{ #category : #cloning }
OBOrderedCollectionPrototype >> createRealCollection [
	^self collectionRealObjectClass new.
]

{ #category : #accessing }
OBOrderedCollectionPrototype >> id [

	^ #ordered
]
