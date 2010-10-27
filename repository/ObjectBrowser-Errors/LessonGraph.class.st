Class {
	#name : #LessonGraph,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'objects',
		'references',
		'variables'
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
	self references add: (LessonGraphReference from: aRealObject to: objectReferenced named: referenceName).
]

{ #category : #'as yet unclassified' }
LessonGraph >> addVariable: aVariable [
	self variables add: aVariable.
]

{ #category : #'as yet unclassified' }
LessonGraph >> dereferencedObjects [
	^self objects reject: [ :o |
			self referenceHolders anySatisfy: [ :h | h hasReferencesTo: o ]
		]
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
LessonGraph >> referenceHolders [
	^self variables union: self objects
]

{ #category : #'as yet unclassified' }
LessonGraph >> references [
	^references ifNil: [ references := Set new ]
]

{ #category : #'as yet unclassified' }
LessonGraph >> variables [
	^variables ifNil: [ variables := Set new ].
]
