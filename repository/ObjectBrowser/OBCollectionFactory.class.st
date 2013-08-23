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

{ #category : #'as yet unclassified' }
OBCollectionFactory class >> newForLesson: aLesson [

	^self new
			lesson: aLesson;
			yourself.
]

{ #category : #cloning }
OBCollectionFactory >> clone [
	| col |
	col := self createCollection.
	lesson addObject: (self newObjectBrowserObjectWithRealObject: col).
	^col
]

{ #category : #testing }
OBCollectionFactory >> isObjectBrowserLiteral [
	^true
]

{ #category : #accessing }
OBCollectionFactory >> lesson: aLesson [

	lesson := aLesson
]

{ #category : #'instance-creation' }
OBCollectionFactory >> newObjectBrowserObjectWithRealObject: aRealCollection [

	^OBCollectionMetaObject
			newWithRealObject: aRealCollection
			inLesson: lesson.
]

{ #category : #printing }
OBCollectionFactory >> printString [
	^self displayString 
]
