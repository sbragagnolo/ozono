Class {
	#name : #LOOPLesson,
	#superclass : #Object,
	#instVars : [
		'variables',
		'title',
		'objects',
		'executionContext',
		'browser',
		'loopExecutionContextClass',
		'lessonEnvironment'
	],
	#classVars : [
		'CurrentLesson'
	],
	#classInstVars : [
		'lessons'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #accessing }
LOOPLesson class >> browseLessons [ 
	(LOOPBrowser on: self) openInWorld
	
	
]

{ #category : #accessing }
LOOPLesson class >> cleanAllLessons [
	self lessons do: [ :lesson | lesson clean  ].
]

{ #category : #creation }
LOOPLesson class >> createFreeLesson [
	| lesson |
	lesson := self newFreeLesson.
	self lessons add: lesson.
	^lesson.
]

{ #category : #creation }
LOOPLesson class >> createLessonNamed: title [ 
	^self createFreeLesson title:  title; yourself .
]

{ #category : #accessing }
LOOPLesson class >> deleteAllLessons [
	self cleanAllLessons .
	lessons := OrderedCollection new.
]

{ #category : #accessing }
LOOPLesson class >> freeLesson [
	^CurrentLesson ifNil:[ CurrentLesson := self new title:'Free Lesson'].
	
]

{ #category : #accessing }
LOOPLesson class >> lessons [
	^lessons ifNil: [ lessons := OrderedCollection new ].
]

{ #category : #accessing }
LOOPLesson class >> newFreeLesson [
	^self new title:'Free Lesson'
	
]

{ #category : #accessing }
LOOPLesson class >> openFreeLesson [
	(ObjectBrowser onLesson: self freeLesson) openInWorld
	
]

{ #category : #accessing }
LOOPLesson >> addObject: anObject [
	self objects add: anObject.
]

{ #category : #accessing }
LOOPLesson >> addVariable: aVariable [
	self variables add: aVariable.
	self addObject: aVariable pointsTo.
	self executionContext class addInstVarName: aVariable name.
]

{ #category : #accessing }
LOOPLesson >> clean [
	"hago una copia de la colección para no modificar la original.  Remuevo de la coleccion original cada objeto y le digo que remueva su clase."
	self objects copy do:[:o | o removeClassFromSystem.].
	self objects removeAll.
	self variables do:[:v | executionContext class removeInstVarName: v name].
	self variables removeAll.
	self removeFromSystem.
	self initialize.
]

{ #category : #accessing }
LOOPLesson >> createClass: aClassName subclassOf: aSuperClass [

		^ClassBuilder new
			name: aClassName
			inEnvironment: self lessonEnvironment
			subclassOf: aSuperClass
			type: aSuperClass typeOfClass
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: 'ObjectBrowser-Lessons'
]

{ #category : #'as yet unclassified' }
LOOPLesson >> delete [
	browser ifNotNil: [ :br | br delete ]
]

{ #category : #accessing }
LOOPLesson >> dereferencedObjects [
	^self objects select:[:o | (self referencesObject: o ) not].
]

{ #category : #accessing }
LOOPLesson >> executionContext [
	^executionContext
]

{ #category : #'as yet unclassified' }
LOOPLesson >> fileIn: aFileName [
	^Compiler new 
			evaluate: aFileName readStream
			in: nil
			to: self
			notifying: self
			ifFail: [FakeClassPool adopt: nil. ^ #failedDoit]
			logged: true.
]

{ #category : #accessing }
LOOPLesson >> fileOut [

	| internalStream |
	internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: self title asFileName isSt: true.
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
	executionContext := self loopExecutionContextClass new
							lesson: self;
							yourself.
]

{ #category : #accessing }
LOOPLesson >> lessonEnvironment [
	^lessonEnvironment ifNil: [ lessonEnvironment := SystemDictionary new ].
]

{ #category : #accessing }
LOOPLesson >> lessonIdentification [
	^self title asLegalSelector
]

{ #category : #accessing }
LOOPLesson >> loopExecutionContextClass [
	^loopExecutionContextClass ifNil: [ loopExecutionContextClass :=  self createClass: #LOOPExecutionContext subclassOf: LOOPExecutionContext.	 ]
]

{ #category : #showing }
LOOPLesson >> menuActions [
	^OrderedCollection
		with: #('abrir' #openSelectedLesson)
		with: #('eliminar' #removeSelectedLesson)
]

{ #category : #accessing }
LOOPLesson >> objects [
	^objects ifNil: [objects := OrderedCollection new].
]

{ #category : #accessing }
LOOPLesson >> objects: anObject [
	objects := anObject
]

{ #category : #showing }
LOOPLesson >> openInWorld [
	browser := (ObjectBrowser onLesson: self) openInWorld
]

{ #category : #accessing }
LOOPLesson >> printString [
	^self title
]

{ #category : #accessing }
LOOPLesson >> referencesObject: anObjectBrowserObject [
	^self variables anySatisfy: [:v | v isPointingTo: anObjectBrowserObject ].
]

{ #category : #'as yet unclassified' }
LOOPLesson >> removeFromSystem [
	self lessonEnvironment removeAll.
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
LOOPLesson >> selectFrom: start to: end [ 
]

{ #category : #accessing }
LOOPLesson >> selectionInterval [
	"asco para poder hacer fileins"
	^1 to: 0
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

{ #category : #accessing }
LOOPLesson >> writeAllTheVariablesOn: stream [ 
	
	stream nextPutAll: '| '.
	self objects do:[ :anObject | stream nextPutAll:  anObject posibleName, ' ' ] .
	stream nextPutAll: self lessonIdentification,' |'.
	stream cr ; cr.
]

{ #category : #accessing }
LOOPLesson >> writeCreationScriptOver: stream [

	self writeAllTheVariablesOn: stream .
	
	self objects do:[ :anObject | anObject writeStateScriptOn: stream. stream cr ; cr] .
	stream nextPutAll: self lessonIdentification, ' := LOOPLesson new title: ''',self title ,''''.
	self objects do:[ :anObject | stream nextPutAll: self lessonIdentification, ' addObject: ', anObject posibleName, '.' . stream cr] .
	
	stream cr.
	
]
