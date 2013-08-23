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

{ #category : #adding }
LessonGraph >> addAssociation: anAssociation from: anOBCollection [
	| keyObject valueObject |
	(self includesObject: anAssociation)
		ifFalse: [ self addNoObjectBrowserObject: anAssociation.
				self addReferenceFrom: anOBCollection to: anAssociation named: 'asociacion'.
				(self includesObject: anAssociation key) 
					ifFalse: [
						keyObject := (lesson objectBrowserObjectForRealObject: anAssociation key).
						keyObject accept: self.
						].
				(self includesObject: anAssociation value) 
					ifFalse: [
						valueObject := (lesson objectBrowserObjectForRealObject: anAssociation value).
						valueObject accept: self.
						].
					self addReferenceFrom: anAssociation to: keyObject named: 'clave'.
					self addReferenceFrom: anAssociation to: valueObject named: 'valor'.
				]
]

{ #category : #adding }
LessonGraph >> addCollection: aCollection [

	self addObjectBrowserObject: aCollection
]

{ #category : #adding }
LessonGraph >> addDictionary: anObjectBrowserObject [

	(self includesObject: anObjectBrowserObject)
		ifTrue: [ ^ self ].
	self addObject: anObjectBrowserObject.
	anObjectBrowserObject realObject associations
		do: [ :association | self addAssociation: association from: anObjectBrowserObject ]
]

{ #category : #adding }
LessonGraph >> addLesson: aLesson [
	self lesson: aLesson.
	aLesson variables do: [ :v | 
			self addVariable: v.
			self addReferenceHolder: v pointsTo.
			v pointsTo accept: self.
			self addReferenceFrom: aLesson to: v pointsTo named: v name.
		 ]
]

{ #category : #'graph model' }
LessonGraph >> addNoObjectBrowserObject: aNoObjectBrowserObject [
	self addObject: aNoObjectBrowserObject
]

{ #category : #adding }
LessonGraph >> addObject: aRealObject [
	self objects add: aRealObject.
]

{ #category : #adding }
LessonGraph >> addObjectBrowserObject: anObjectBrowserObject [

	(self includesObject: anObjectBrowserObject)
		ifTrue: [ ^ self ].
	self addObject: anObjectBrowserObject.
	anObjectBrowserObject allRelationships do: [ :v | v accept: self ]
]

{ #category : #adding }
LessonGraph >> addReferenceFrom: aRealObject to: objectReferenced named: referenceName [
	^self references add: (LessonGraphReference from: aRealObject to: objectReferenced named: referenceName).
]

{ #category : #adding }
LessonGraph >> addReferenceHolder: referenceHolder [
	self referenceHolders add: referenceHolder
]

{ #category : #adding }
LessonGraph >> addVariable: aVariable [
	self variables add: aVariable.
]

{ #category : #'as yet unclassified' }
LessonGraph >> allTheObjects: allTheLessonObjects [
	derreferencedObjects := allTheLessonObjects difference: objects .
	allTheLessonObjects do: [ :o | o accept: self ].
]

{ #category : #accessing }
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

{ #category : #'initialize-release' }
LessonGraph >> initialize [ 
	super initialize .
	 objects := Set new.
]

{ #category : #accessing }
LessonGraph >> lesson [
	^lesson
]

{ #category : #accessing }
LessonGraph >> lesson: aLesson [
	lesson := aLesson.
	self addReferenceHolder: aLesson.
]

{ #category : #'as yet unclassified' }
LessonGraph >> objectBrowserObjects [
	^(self objects union: derreferencedObjects ).
]

{ #category : #accessing }
LessonGraph >> objects [
	^objects ifNil: [ objects := Bag new ].
]

{ #category : #'as yet unclassified' }
LessonGraph >> objectsWithLesson [
	^self objects copyWith: lesson
]

{ #category : #accessing }
LessonGraph >> referenceHolders [
	^ referenceHolders ifNil: [ referenceHolders := Set new ].
]

{ #category : #accessing }
LessonGraph >> references [
	^references ifNil: [ references := Set new ]
]

{ #category : #accessing }
LessonGraph >> variables [
	^variables ifNil: [ variables := Set new ].
]

{ #category : #visiting }
LessonGraph >> visitAttribute: anAttribute [

	| referencedObjectBrowserObject |
	referencedObjectBrowserObject := lesson objectBrowserObjectForRealObject: anAttribute pointsTo.
	referencedObjectBrowserObject accept: self.
	self addReferenceFrom: anAttribute owner to: referencedObjectBrowserObject named: anAttribute name
]

{ #category : #visiting }
LessonGraph >> visitCollection: aCollection [

	self addCollection: aCollection
]

{ #category : #visiting }
LessonGraph >> visitDictionary: aCollection [

	self addDictionary: aCollection
]

{ #category : #visiting }
LessonGraph >> visitDirectAttribute: anAttribute [

	self visitAttribute: anAttribute.
]

{ #category : #visiting }
LessonGraph >> visitOBExternalObject: anExternalObject [

	self addNoObjectBrowserObject: anExternalObject.
]

{ #category : #visiting }
LessonGraph >> visitObject: anObject [

	self addObjectBrowserObject: anObject
]

{ #category : #visiting }
LessonGraph >> visitSpecialAttribute: anAttribute [

	self visitAttribute: anAttribute.
]
