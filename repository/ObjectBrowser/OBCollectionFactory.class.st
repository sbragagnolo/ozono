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
OBCollectionFactory >> clone [

	| realCollection |
	realCollection := self createRealCollection.
	lesson addObject: (self newMetaObjectForCollection: realCollection).
	^realCollection
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

	^OBCollectionMetaObject
			newWithRealObject: aRealCollection
			inLesson: lesson.
]

{ #category : #printing }
OBCollectionFactory >> printString [

	^self displayString 
]
