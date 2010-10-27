Class {
	#name : #LessonGraph,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'objects',
		'references'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
LessonGraph class >> lesson: aLesson [
	^self new
		lesson: aLesson; 
		yourself 
]

{ #category : #'as yet unclassified' }
LessonGraph >> addCollection: anObjectBrowserObject [
	| objectReferenced |
	(self includesObject: anObjectBrowserObject realObject)
		ifFalse: [ self addObject: anObjectBrowserObject realObject.
			  	 
				anObjectBrowserObject realObject do: [ :e |
						(lesson objectBrowserObjectForRealObject: e) addToGraph: self.
						self addReferenceFrom: anObjectBrowserObject realObject to: e named: 'elemento'.
					]
				]
]

{ #category : #'graph model' }
LessonGraph >> addNoObjectBrowserObject: aNoObjectBrowserObject [
	self addObject: aNoObjectBrowserObject
]

{ #category : #'as yet unclassified' }
LessonGraph >> addObject: aRealObject [
	self objects add: aRealObject.
]

{ #category : #'as yet unclassified' }
LessonGraph >> addObjectBrowserObject: anObjectBrowserObject [
	| objectReferenced |
	(self includesObject: anObjectBrowserObject realObject)
		ifFalse: [ self addObject: anObjectBrowserObject realObject.
			  	 
				anObjectBrowserObject variables do: [ :v |
						objectReferenced := anObjectBrowserObject objectPointedByVariableNamed: v name asSymbol.
						(lesson objectBrowserObjectForRealObject: objectReferenced) addToGraph: self.
						self addReferenceFrom: anObjectBrowserObject realObject to: objectReferenced named: v name.
					].
				anObjectBrowserObject prototype addPrototypeRelationshipTo: anObjectBrowserObject in: self.
				]
]

{ #category : #'as yet unclassified' }
LessonGraph >> addReferenceFrom: aRealObject to: objectReferenced named: referenceName [
	self references add: (LessonGraphReference from: aRealObject to: objectReferenced named: referenceName).
]

{ #category : #'as yet unclassified' }
LessonGraph >> includesObject: aRealObject [
	^self objects includes: aRealObject 
]

{ #category : #'as yet unclassified' }
LessonGraph >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #'as yet unclassified' }
LessonGraph >> objects [
	^objects ifNil: [ objects := Bag new ].
]

{ #category : #'as yet unclassified' }
LessonGraph >> references [
	^references ifNil: [ references := Set new ]
]
