Class {
	#name : #LOOPLesson,
	#superclass : #Object,
	#instVars : [
		'variables',
		'title',
		'objects'
	],
	#classInstVars : [
		'Lessons',
		'CurrentLesson'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #accessing }
LOOPLesson class >> addLesson: aLesson [
	self lessons add: aLesson 
]

{ #category : #accessing }
LOOPLesson class >> currentLesson [
	^ CurrentLesson ifNil:[ CurrentLesson := self freeLesson ] ifNotNil:[ CurrentLesson ]
]

{ #category : #accessing }
LOOPLesson class >> currentLesson: anObject [
	CurrentLesson := anObject
]

{ #category : #accessing }
LOOPLesson class >> freeLesson [
	^self new title:'Free Lesson'
	
]

{ #category : #accessing }
LOOPLesson class >> lessons [
	^ Lessons
]

{ #category : #accessing }
LOOPLesson class >> lessons: anObject [
	Lessons := anObject
]

{ #category : #accessing }
LOOPLesson class >> openFreeLesson [
	self currentLesson: self freeLesson.
	ObjectBrowser open.
	
]

{ #category : #accessing }
LOOPLesson >> addVariable: aVariable [
	self variables add: aVariable.
	self objects add: aVariable pointsTo.
]

{ #category : #accessing }
LOOPLesson >> objects [
	^objects ifNil: [objects := OrderedCollection new].
]

{ #category : #accessing }
LOOPLesson >> objects: anObject [
	objects := anObject
]

{ #category : #accessing }
LOOPLesson >> title [
	^ title
]

{ #category : #accessing }
LOOPLesson >> title: anObject [
	title := anObject
]

{ #category : #'as yet unclassified' }
LOOPLesson >> variableNamed: aByteString [ 
	^self variables detect:[ :var | var name = aByteString  ].
]

{ #category : #accessing }
LOOPLesson >> variables [
	^ variables ifNil:[variables := OrderedCollection new]
]

{ #category : #accessing }
LOOPLesson >> variables: anObject [
	variables := anObject
]
