"
I am an abstract collection prototype. My sub instances can create collections and are used as prototypes in the lesson workspace.
"
Class {
	#name : #OBCollectionPrototype,
	#superclass : #Object,
	#instVars : [
		'lesson'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'instance-creation' }
OBCollectionPrototype class >> newForLesson: aLesson [

	^self new
			lesson: aLesson;
			yourself.
]

{ #category : #attributes }
OBCollectionPrototype >> allAttributeNames [

	^ #()
]

{ #category : #printing }
OBCollectionPrototype >> baseDisplayString [

	self subclassResponsibility
]

{ #category : #cloning }
OBCollectionPrototype >> basicClone [

	| collection |
	collection := self newMetaObjectForCollection: self createRealCollection.
	lesson addObject: collection.
	^collection
]

{ #category : #cloning }
OBCollectionPrototype >> clone [

	^self basicClone baseObject
]

{ #category : #'instance-creation' }
OBCollectionPrototype >> collectionMetaObjectClass [
	^ self subclassResponsibility 
]

{ #category : #'instance-creation' }
OBCollectionPrototype >> collectionRealObjectClass [
	^ self subclassResponsibility  
]

{ #category : #cloning }
OBCollectionPrototype >> createRealCollection [
	^self collectionRealObjectClass new.
]

{ #category : #printing }
OBCollectionPrototype >> displayString [

	^ self baseDisplayString , 'Prototype'
]

{ #category : #accessing }
OBCollectionPrototype >> lesson: aLesson [

	lesson := aLesson
]

{ #category : #methods }
OBCollectionPrototype >> methods [

	^ #()
]

{ #category : #cloning }
OBCollectionPrototype >> new [
	^ self clone
]

{ #category : #'instance-creation' }
OBCollectionPrototype >> newMetaObjectForCollection: aRealCollection [

	| metaCollection |
	metaCollection := self collectionMetaObjectClass
						newWithRealObject: aRealCollection
						inLesson: lesson
						prototype: self.
	aRealCollection metaObject: metaCollection.
	^metaCollection.
]

{ #category : #printing }
OBCollectionPrototype >> printString [

	^self displayString 
]

{ #category : #cloning }
OBCollectionPrototype >> relationWith: aClone [
	
	^OBNullAttribute new
]
