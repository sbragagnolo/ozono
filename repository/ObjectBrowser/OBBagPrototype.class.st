"
I am a bag factory. My instances can create bags and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBBagPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBBagPrototype >> baseDisplayString [
	^'aBag'
]

{ #category : #'instance-creation' }
OBBagPrototype >> collectionMetaObjectClass [
	^ OBBagMetaObject
]

{ #category : #cloning }
OBBagPrototype >> collectionRealObjectClass [
	^ OBBag
]

{ #category : #cloning }
OBBagPrototype >> createRealCollection [
	^self collectionRealObjectClass new.
]

{ #category : #accessing }
OBBagPrototype >> id [

	^#bag
]
