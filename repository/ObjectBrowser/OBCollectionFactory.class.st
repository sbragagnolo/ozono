"
I am an abstract collection factory. My sub instances can create collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBCollectionFactory,
	#superclass : #Object,
	#instVars : [
		'lesson'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'instance-creation' }
OBCollectionFactory class >> newForLesson: aLesson [

	^self new
			lesson: aLesson;
			yourself.
]

{ #category : #cloning }
OBCollectionFactory >> basicClone [

	| collection |
	collection := self newMetaObjectForCollection: self createRealCollection.
	lesson addObject: collection.
	^collection
]

{ #category : #cloning }
OBCollectionFactory >> clone [

	^self basicClone concreteObject
]

{ #category : #printing }
OBCollectionFactory >> collectionTypeName [

	self subclassResponsibility
]

{ #category : #cloning }
OBCollectionFactory >> createRealCollection [

	self subclassResponsibility
]

{ #category : #accessing }
OBCollectionFactory >> lesson: aLesson [

	lesson := aLesson
]

{ #category : #'instance-creation' }
OBCollectionFactory >> newMetaObjectForCollection: aRealCollection [

	| metaCollection |
	metaCollection := OBCollectionMetaObject
						newWithRealObject: aRealCollection
						inLesson: lesson.
	aRealCollection metaObject: metaCollection.
	^metaCollection.
]

{ #category : #printing }
OBCollectionFactory >> printString [

	^self displayString 
]
