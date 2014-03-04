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

{ #category : #'instance-creation' }
OBSetPrototype >> collectionMetaObjectClass [
	^ OBSetMetaObject
]

{ #category : #cloning }
OBSetPrototype >> collectionRealObjectClass [
	^ OBSet
]

{ #category : #cloning }
OBSetPrototype >> createRealCollection [
	^self collectionRealObjectClass new.
]

{ #category : #accessing }
OBSetPrototype >> id [

	^ #set
]
