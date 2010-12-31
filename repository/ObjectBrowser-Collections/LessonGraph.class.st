Class {
	#name : #LessonGraph,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'objects',
		'references',
		'variables',
		'referenceHolders',
		'derreferencedObjects'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
LessonGraph >> addCollection: anObjectBrowserObject [
	| objectReferenced referencedObjectBrowserObject |
	(self includesObject: anObjectBrowserObject)
		ifFalse: [ self addObject: anObjectBrowserObject.
			  	 
				anObjectBrowserObject realObject do: [ :e |
						referencedObjectBrowserObject := (lesson objectBrowserObjectForRealObject: e).
						referencedObjectBrowserObject addToGraph: self.
						self addReferenceFrom: anObjectBrowserObject to: referencedObjectBrowserObject named: 'elemento'.
					]
				]
]

{ #category : #'as yet unclassified' }
LessonGraph >> addLesson: aLesson [
	self lesson: aLesson.
	aLesson variables do: [ :v | 
			self addVariable: v.
			self addReferenceHolder: v pointsTo.
			v pointsTo addToGraph: self.
			self addReferenceFrom: aLesson to: v pointsTo named: v name.
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
	| objectReferenced referencedObjectBrowserObject |
	
	(self includesObject: anObjectBrowserObject)
		ifFalse: [ self addObject: anObjectBrowserObject.
			  	 
				anObjectBrowserObject variables do: [ :v |
						objectReferenced := anObjectBrowserObject objectPointedByVariableNamed: v name asSymbol.
						referencedObjectBrowserObject := (lesson objectBrowserObjectForRealObject: objectReferenced).
						referencedObjectBrowserObject addToGraph: self.
						self addReferenceFrom: anObjectBrowserObject to: referencedObjectBrowserObject named: v name.
					].
				anObjectBrowserObject prototype addPrototypeRelationshipTo: anObjectBrowserObject in: self.
				]
]

{ #category : #'as yet unclassified' }
LessonGraph >> addReferenceFrom: aRealObject to: objectReferenced named: referenceName [
	^self references add: (LessonGraphReference from: aRealObject to: objectReferenced named: referenceName).
]

{ #category : #'as yet unclassified' }
LessonGraph >> addReferenceHolder: referenceHolder [
	self referenceHolders add: referenceHolder
]

{ #category : #'as yet unclassified' }
LessonGraph >> addVariable: aVariable [
	self variables add: aVariable.
]

{ #category : #'as yet unclassified' }
LessonGraph >> allTheObjects: allTheLessonObjects [
	derreferencedObjects := allTheLessonObjects difference: objects .
	allTheLessonObjects do: [ :o | o addToGraph: self ].
]

{ #category : #'as yet unclassified' }
LessonGraph >> dereferencedObjects [
"	^self objectBrowserObjects reject: [ :o |
			self referenceHolders anySatisfy: [ :h | h hasReferencesTo: o ]
		]"
	^ derreferencedObjects .
]

{ #category : #'as yet unclassified' }
LessonGraph >> includesObject: aRealObject [
	^self objects includes: aRealObject 
]

{ #category : #'as yet unclassified' }
LessonGraph >> initialize [ 
	super initialize .
	 objects := Set new.
]

{ #category : #accessing }
LessonGraph >> lesson [
	^lesson
]

{ #category : #'as yet unclassified' }
LessonGraph >> lesson: aLesson [
	lesson := aLesson.
	self addReferenceHolder: aLesson.
]

{ #category : #'as yet unclassified' }
LessonGraph >> objectBrowserObjects [
	^(self objects union: derreferencedObjects ).
]

{ #category : #'as yet unclassified' }
LessonGraph >> objects [
	^objects ifNil: [ objects := Bag new ].
]

{ #category : #'as yet unclassified' }
LessonGraph >> objectsWithLesson [
	^self objects copyWith: lesson
]

{ #category : #'as yet unclassified' }
LessonGraph >> referenceHolders [
	^ referenceHolders ifNil: [ referenceHolders := Set new ].
]

{ #category : #'as yet unclassified' }
LessonGraph >> references [
	^references ifNil: [ references := Set new ]
]

{ #category : #'as yet unclassified' }
LessonGraph >> variables [
	^variables ifNil: [ variables := Set new ].
]
