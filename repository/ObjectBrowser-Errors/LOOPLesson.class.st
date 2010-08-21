Class {
	#name : #LOOPLesson,
	#superclass : #Object,
	#instVars : [
		'variables',
		'title',
		'objects',
		'executionContext'
	],
	#classVars : [
		'CurrentLesson'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #accessing }
LOOPLesson class >> freeLesson [
	^CurrentLesson ifNil:[ CurrentLesson := self new title:'Free Lesson'].
	
]

{ #category : #accessing }
LOOPLesson class >> openFreeLesson [
	(ObjectBrowser onLesson: self freeLesson) openInWorld
	
]

{ #category : #accessing }
LOOPLesson >> addVariable: aVariable [
	self variables add: aVariable.
	self objects add: aVariable pointsTo.
	self executionContext class addInstVarName: aVariable name.
]

{ #category : #accessing }
LOOPLesson >> clean [
	"hago una copia de la colección para no modificar la original.  Remuevo de la coleccion original cada objeto y le digo que remueva su clase."
	
	self objects copy do:[:o | o removeClassFromSystem.].
	self objects removeAll.
	self variables do:[:v | executionContext class removeInstVarName: v name].
	self variables removeAll.
	self initialize.
]

{ #category : #accessing }
LOOPLesson >> dereferencedObjects [
	^self objects select:[:o | (self referencesObject: o ) not].
]

{ #category : #accessing }
LOOPLesson >> executionContext [
	^executionContext
]

{ #category : #accessing }
LOOPLesson >> hasObject: anObject [
	^objects includes: anObject.
]

{ #category : #'as yet unclassified' }
LOOPLesson >> hasVariable: aVariableName [
	^self variables anySatisfy: [:v | v name = aVariableName ].
]

{ #category : #'as yet unclassified' }
LOOPLesson >> hasVariableNamed: aVariableName [
	^self variables anySatisfy: [:v | v name = aVariableName ].
]

{ #category : #accessing }
LOOPLesson >> initialize [
	 executionContext := LOOPExecutionContext new
							lesson: self;
							yourself.
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
LOOPLesson >> referencesObject: anObjectBrowserObject [
	^self variables anySatisfy: [:v | v isPointingTo: anObjectBrowserObject ].
]

{ #category : #'as yet unclassified' }
LOOPLesson >> removeObject: anObjectBrowserObject [ 
	self objects remove: anObjectBrowserObject.
]

{ #category : #accessing }
LOOPLesson >> runGarbageCollector [ 
	self dereferencedObjects do: [:o | 
		o removeClassFromSystem.
		self removeObject: o ].
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
