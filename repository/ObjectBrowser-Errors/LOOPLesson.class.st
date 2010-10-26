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
		'lessonEnvironment',
		'workspaces',
		'tests',
		'objectDiagram'
	],
	#classInstVars : [
		'lessons'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #creation }
LOOPLesson class >> addLesson: lesson. [
	self lessons add: lesson.
]

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
	self addLesson: lesson.
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
LOOPLesson class >> fileIn: aFileName [
	| lessonImported inStream |
	
	[ inStream := StandardFileStream fileNamed: aFileName.
		lessonImported := Compiler new 
			evaluate: inStream readStream
			in: nil
			to: self
			notifying: self
			ifFail: [FakeClassPool adopt: nil. ^ #failedDoit]
			logged: true.
		] ensure: [inStream close.].
		lessonImported isNil ifTrue: [self error: 'La Lección no pudo ser importada'].
		^ lessonImported.
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
LOOPLesson class >> select [
]

{ #category : #accessing }
LOOPLesson class >> selectFrom: start to: end [ 
	"asco para fileIn #2"
]

{ #category : #accessing }
LOOPLesson class >> selectionInterval [
	"asco para poder hacer fileins"
	^1 to: 0
]

{ #category : #accessing }
LOOPLesson >> addNewObject [
	| newObject |
	newObject := ObjectBrowserObject newOn: self.
	self addObject: newObject.
	^newObject
	
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
LOOPLesson >> addVariableNamed: theReferenceName pointingTo: anObject [
	|aVariable|
	aVariable :=	 (LessonVariable new)
		name: theReferenceName ;
		pointTo: anObject ;
		yourself.
	
	self addVariable: aVariable.

]

{ #category : #'as yet unclassified' }
LOOPLesson >> addWorkspace: aWorkspace [
	self workspaces add: aWorkspace 
]

{ #category : #'as yet unclassified' }
LOOPLesson >> buildGraph [
	| graph |
	graph := LessonGraph lesson: self.
	self objects do: [ :o | o addToGraph: graph ].
	^graph
]

{ #category : #accessing }
LOOPLesson >> clean [
	"hago una copia de la colección para no modificar la original.  Remuevo de la coleccion original cada objeto y le digo que remueva su clase."
	"self objects copy do:[:o | o removeClassFromSystem.]."
	self objects removeAll.
	self variables do:[:v | executionContext class removeInstVarName: v name].
	self variables removeAll.
	self removeFromSystem.
	self class instVarNames do: [ :vn | self instVarNamed: vn put: nil].
]

{ #category : #accessing }
LOOPLesson >> compileTest: aTestText [
	| result |
	result := self executionContext class compile: aTestText classified: #'tests'  notifying: nil.
	self testDictionary at: result put: (OBTest newText: result onLesson: self).
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
			category: 'Useless'
]

{ #category : #'as yet unclassified' }
LOOPLesson >> createWorkspace: workspaceLabel [
	| workspace |
	workspace := LOOPWorkspace new 
		openLabel: workspaceLabel;
		lesson: self.
	self addWorkspace: workspace.
	workspace containingWindow center: World center.
	^workspace
]

{ #category : #'as yet unclassified' }
LOOPLesson >> delete [
	browser ifNotNil: [ :br | br delete ]
]

{ #category : #accessing }
LOOPLesson >> dereferencedObjects [
	| referencedObjects dereferenced |
	referencedObjects := self referencedObjects.
	dereferenced := self objects reject:[:o | referencedObjects includes: o].
	^dereferenced asSet.
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
	[internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: self lessonIdentification asFileName isSt: true.
	
	] ensure: [ internalStream close ]
]

{ #category : #accessing }
LOOPLesson >> getObjectBrowserObjectFromRealObject: aRealObject [
	^(aRealObject isKindOf: ObjectBrowserClass)
		ifTrue: [ self objects detect: [ :o | o realObject == aRealObject ]] 
		ifFalse: [ NoObjectBrowserObject new: aRealObject ].
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
	objectDiagram := ObjectDiagram new.
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
	^loopExecutionContextClass ifNil: [ loopExecutionContextClass :=  self createClass: #LessonExecutionContext subclassOf: LOOPExecutionContext. ]
]

{ #category : #showing }
LOOPLesson >> menuActions [
	^OrderedCollection
		with: #('abrir' #openSelectedLesson)
		with: #('eliminar' #removeSelectedLesson)
		with: #('renombrar' #renameSelectedLesson)
		with: #('exportar' #fileOutSelectedLesson)
]

{ #category : #showing }
LOOPLesson >> objectBrowserObjectForRealObject: realObject [
	^self objects detect: [ :o | o realObject == realObject ] ifNone: [ NoObjectBrowserObject new: realObject ].
]

{ #category : #diagram }
LOOPLesson >> objectDiagram [
	^objectDiagram 
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
LOOPLesson >> referencedObjects [
	| referencedObjects |
	referencedObjects := Set new.
	self variables do:[ :v | v pointsTo fullfillObjectBrowserObjectsCollection: referencedObjects ].
	^referencedObjects
]

{ #category : #accessing }
LOOPLesson >> referencesObject: anObjectBrowserObject [
	^self variables anySatisfy: [:v | v isPointingTo: anObjectBrowserObject ].
]

{ #category : #accessing }
LOOPLesson >> removeDerrefencedObject: aDereferencedObject [ 
	self dereferencedObjects remove: aDereferencedObject .
]

{ #category : #'as yet unclassified' }
LOOPLesson >> removeFromSystem [
	self lessonEnvironment valuesDo: [ :c | c removeFromSystem ].
	self lessonEnvironment removeAll.
]

{ #category : #'as yet unclassified' }
LOOPLesson >> removeObject: anObjectBrowserObject [ 
	self objects remove: anObjectBrowserObject.
]

{ #category : #'as yet unclassified' }
LOOPLesson >> removeVariable: anOBVariable [ 
	self variables remove: anOBVariable .
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
LOOPLesson >> testDictionary [
	^tests ifNil: [ tests := Dictionary new ]
]

{ #category : #accessing }
LOOPLesson >> tests [
	^self testDictionary values
]

{ #category : #accessing }
LOOPLesson >> title [
	^ title
]

{ #category : #accessing }
LOOPLesson >> title: anObject [
	title := anObject
]

{ #category : #diagram }
LOOPLesson >> updateObjectDiagram [
	 
	objectDiagram updateDiagramNodesFrom: self buildGraph objects. "Clears the unreferenced objects and adds the new ones"
	objectDiagram resetConnections.
	objectDiagram connectNodes.
	^objectDiagram
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
LOOPLesson >> workspaces [
	^ workspaces ifNil:[ workspaces := OrderedCollection new]
]

{ #category : #accessing }
LOOPLesson >> writeAddScriptToLessonOn: stream [
	self variables do: [ :variable | stream nextPutAll: self lessonIdentification ,' addVariableNamed: ''', variable name , ''' pointingTo: ', variable referencePosibleName, '.'. stream cr].
	stream nextPutAll: '^ ', self lessonIdentification , '.'.
	stream cr.
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
	
	"primero la definicion de variables"
	self writeAllTheVariablesOn: stream .
	
	"ahora la definicion de la leccion"
	self writeLessonCreationOn: stream.
	
	"despues la descripcion del objeto: su creacion, variables y metodos"
	self objects do:[ :anObject | anObject writeObjectDescriptionScriptOn: stream lesson: self. stream cr] .
	
	"despues el estado"
	self objects do:[ :anObject | anObject writeStateScriptOn: stream. stream cr] .
	
	"despues la incorporacion a la lesson"
	self writeAddScriptToLessonOn: stream .
	
	self writeWorkspacesOn: stream.
	
]

{ #category : #accessing }
LOOPLesson >> writeLessonCreationOn: stream. [
	stream nextPutAll: self lessonIdentification, ' := LOOPLesson new title: ''',self title ,'''.'.
	stream cr.
	stream nextPutAll: 'self addLesson: ', self lessonIdentification , '.'.
	stream cr.
]

{ #category : #accessing }
LOOPLesson >> writeWorkspacesOn: stream [
	
	stream cr.
	stream nextPutAll: '"Workspaces exported"'.
	self workspaces do:[ :aWorkspace | 
		stream cr.
		stream nextPutAll: 
			'(self createWorkspace: ', '''' , aWorkspace label , '''' , ') contents: '.
		stream cr.
		stream nextPutAll: '''' , aWorkspace contents , '''' , '.'] .
	stream cr.
]
