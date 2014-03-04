"
I am a sorted collection factory. My instances can create sorted collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBSortedPrototype,
	#superclass : #OBCollectionPrototype,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBSortedPrototype >> baseDisplayString [
	^ 'aSorted'
]

{ #category : #'instance-creation' }
OBSortedPrototype >> collectionMetaObjectClass [
	^ OBSortedMetaObject
]

{ #category : #cloning }
OBSortedPrototype >> collectionRealObjectClass [
	^ OBSortedCollection
]

{ #category : #cloning }
OBSortedPrototype >> createRealCollection [
	^self collectionRealObjectClass new.
]

{ #category : #accessing }
OBSortedPrototype >> id [

	^ #sorted
]
