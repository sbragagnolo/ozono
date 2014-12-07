"
I am an object graph from a lesson
"
Class {
	#name : #OBLessonGraph,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'objects',
		'references',
		'derreferencedObjects',
		'mode'
	],
	#category : #'ObjectBrowser-Graph'
}

{ #category : #adding }
OBLessonGraph >> addObject: anObject [

	self objects add: anObject.
]

{ #category : #adding }
OBLessonGraph >> addReferenceFrom: aRealObject to: objectReferenced named: referenceName [

	^ self references add: (OBLessonGraphReference from: aRealObject to: objectReferenced named: referenceName).
]

{ #category : #querying }
OBLessonGraph >> allTheObjects: allTheLessonObjects [
	derreferencedObjects := allTheLessonObjects difference: objects .
	allTheLessonObjects do: [ :o | o accept: self ].
]

{ #category : #accessing }
OBLessonGraph >> dereferencedObjects [

	^ derreferencedObjects
]

{ #category : #querying }
OBLessonGraph >> includesObject: aRealObject [
	^self objects includes: aRealObject 
]

{ #category : #'initialize-release' }
OBLessonGraph >> initialize [
	super initialize.
	objects := Set new.
	references := Set new.
	derreferencedObjects := OrderedCollection new.
]

{ #category : #accessing }
OBLessonGraph >> lesson [
	^lesson
]

{ #category : #accessing }
OBLessonGraph >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #modes }
OBLessonGraph >> mark [
	mode := OBMarkGraphMode new graph: self; yourself
]

{ #category : #visiting }
OBLessonGraph >> markObject: anObject [

	derreferencedObjects remove: anObject.
	anObject allRelationships do: [ :v | v accept: self ].

]

{ #category : #querying }
OBLessonGraph >> objectBrowserObjects [
	^(self objects union: derreferencedObjects ).
]

{ #category : #accessing }
OBLessonGraph >> objects [

	^ objects
]

{ #category : #querying }
OBLessonGraph >> objectsWithLesson [
	^self objects copyWith: lesson
]

{ #category : #accessing }
OBLessonGraph >> references [

	^ references
]

{ #category : #modes }
OBLessonGraph >> trace [
	mode := OBTraceGraphMode new graph: self; yourself
]

{ #category : #visiting }
OBLessonGraph >> traceObject: anObject [

	self addObject: anObject.
	derreferencedObjects add: anObject.
	anObject allRelationships do: [ :v | v accept: self ].
]

{ #category : #visiting }
OBLessonGraph >> visitAssociationAttribute: anAttribute [

	(self includesObject: anAttribute objectPointed) ifTrue: [ ^self ].
	
	self visitAttribute: anAttribute.
	anAttribute keyAttribute accept: self.
	anAttribute valueAttribute accept: self.
]

{ #category : #visiting }
OBLessonGraph >> visitAttribute: anAttribute [

	| referencedObjectBrowserObject |
	referencedObjectBrowserObject := anAttribute pointsTo metaObject.
	referencedObjectBrowserObject accept: self.
	self addReferenceFrom: anAttribute owner to: referencedObjectBrowserObject named: anAttribute name
]

{ #category : #visiting }
OBLessonGraph >> visitCollection: aCollection [

	self visitObject: aCollection
]

{ #category : #visiting }
OBLessonGraph >> visitDictionary: aCollection [

	self visitCollection: aCollection
]

{ #category : #visiting }
OBLessonGraph >> visitDirectAttribute: anAttribute [

	self visitAttribute: anAttribute.
]

{ #category : #visiting }
OBLessonGraph >> visitLesson: aLesson [

	lesson := aLesson.
	self trace.
	aLesson objects do: [ :o | o accept: self ].
	self mark.
	aLesson variables do: [ :v | v accept: self ].
]

{ #category : #visiting }
OBLessonGraph >> visitLessonVariable: aLessonVariable [

	aLessonVariable pointsTo accept: self.
	self addReferenceFrom: lesson to: aLessonVariable pointsTo named: aLessonVariable name.
]

{ #category : #visiting }
OBLessonGraph >> visitOBExternalObject: anExternalObject [
	self addObject: anExternalObject
]

{ #category : #visiting }
OBLessonGraph >> visitObject: anObject [
	
	mode visitObject: anObject.
]

{ #category : #visiting }
OBLessonGraph >> visitSpecialAttribute: anAttribute [

	self visitAttribute: anAttribute.
]
