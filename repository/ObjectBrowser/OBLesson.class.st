"
I am a loop lesson. I contain the objects the lesson have, the tests and workspaces.
"
Class {
	#name : #OBLesson,
	#superclass : #Object,
	#instVars : [
		'variables',
		'title',
		'objects',
		'executionContext',
		'browser',
		'lessonEnvironment',
		'workspaces',
		'tests',
		'objectDiagram',
		'literals'
	],
	#classInstVars : [
		'lessons'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #accessing }
OBLesson class >> addLesson: lesson [

	self lessons add: lesson.
]

{ #category : #show }
OBLesson class >> browseLessons [ 

	(OBLessonBrowserModel on: self) openInWorld
]

{ #category : #accessing }
OBLesson class >> cleanAllLessons [

	self lessons do: [ :lesson | lesson clean ]
]

{ #category : #'instance-creation' }
OBLesson class >> createFreeLesson [

	| lesson |
	lesson := self newFreeLesson.
	self addLesson: lesson.
	^lesson.
]

{ #category : #'instance-creation' }
OBLesson class >> createLessonNamed: title [

	^ self createFreeLesson
			title: title;
			yourself
]

{ #category : #accessing }
OBLesson class >> deleteAllLessons [

	self cleanAllLessons.
	lessons := OrderedCollection new.
]

{ #category : #importing }
OBLesson class >> fileIn: aFileEntry [

	| lessonImported inStream |
	
	Author fullName ifNil: [Author requestFullName].	
	self suspendAllWhile: [
		[ [
			ClassBuilder beSilent: true.
			inStream := aFileEntry readStream.
			lessonImported := Compiler new 
				evaluate: inStream
				in: nil
				to: self
				notifying: nil
				ifFail: [ ^nil ]
				logged: true.
			] valueSuppressingAllMessages.
		] ensure: [ 
			ClassBuilder beSilent: false.
			inStream ifNotNilDo: [ :s | s close ]
		].
		lessonImported isNil ifTrue: [self error: 'La Lección no pudo ser importada'].
		^ lessonImported.
	]
]

{ #category : #accessing }
OBLesson class >> lessons [

	^lessons ifNil: [ lessons := OrderedCollection new ].
]

{ #category : #'instance-creation' }
OBLesson class >> newFreeLesson [

	^self new title: 'Nueva Leccion'
]

{ #category : #importing }
OBLesson class >> select [
	"asco para fileIn #3"
]

{ #category : #importing }
OBLesson class >> selectFrom: start to: end [ 
	"asco para fileIn #2"
]

{ #category : #importing }
OBLesson class >> selectionInterval [
	"asco para poder hacer fileins"
	^1 to: 0
]

{ #category : #'system-events' }
OBLesson class >> suspendAllWhile: aBlock [

	SystemAnnouncer uniqueInstance suspendAllWhile: aBlock
]

{ #category : #visiting }
OBLesson >> accept: aVisitor [

	aVisitor visitLesson: self
]

{ #category : #objects }
OBLesson >> addObject: anObject [

	^self objects add: anObject.
]

{ #category : #'lesson-variables' }
OBLesson >> addVariable: aVariable [
	self variables add: aVariable.
	self suspendAllWhile: [
		self executionContext class addInstVarNamed: aVariable name.
	].
]

{ #category : #workspaces }
OBLesson >> addWorkspace: aWorkspace [

	self workspaces add: aWorkspace 
]

{ #category : #printing }
OBLesson >> asString [

	^self displayString copyReplaceAll: ' ' with: ''
]

{ #category : #diagram }
OBLesson >> buildGraph [

	| graph |
	graph := OBLessonGraph new.
	self accept: graph.
	^ graph
]

{ #category : #'ui-actions' }
OBLesson >> changed [

	super changed.
	browser changed.
]

{ #category : #cleaning }
OBLesson >> clean [

	"We force everything to be garbage collected by releasing the references. Specially from special objects such as classes"
	self objects removeAll.
	self variables do:[:v | executionContext class removeFromSystem ].
	self variables removeAll.
	self removeFromSystem.
	self class instVarNames do: [ :vn | self instVarNamed: vn put: nil].
]

{ #category : #tests }
OBLesson >> compileTest: aTestText [

	| result newTest |
	self suspendAllWhile: [
		result := self executionContext class compile: aTestText classified: #'tests'  notifying: nil.
		newTest := (OBTest newWithSelector: result onLesson: self).
		self testDictionary at: result put: newTest.
		^newTest
	]
]

{ #category : #tests }
OBLesson >> createClass: aClassName subclassOf: aSuperClass [

	self suspendAllWhile: [
		^ClassBuilder new
			name: aClassName
			inEnvironment: self lessonEnvironment
			subclassOf: aSuperClass
			type: aSuperClass typeOfClass
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: 'Useless'.
	]
]

{ #category : #objects }
OBLesson >> createObject [

	| newObject |
	newObject := OBMetaObject newOn: self.
	self addObject: newObject.
	^ newObject
]

{ #category : #'lesson-variables' }
OBLesson >> createVariableNamed: aVariableName pointingTo: anObject [
	
	| newVariable |
	newVariable := (OBLessonVariable newNamed: aVariableName)
		pointTo: anObject;
		yourself.
	self addVariable: newVariable.
	^newVariable
]

{ #category : #workspaces }
OBLesson >> createWorkspace: workspaceLabel contents: someContents [

	| workspace |
	workspace := OBWorkspace new
		label: workspaceLabel;
		contents: someContents;
		lesson: self.
	self addWorkspace: workspace.
	workspace openInWorld.
	workspace containingWindow center: World center.
	^workspace
]

{ #category : #'ui-actions' }
OBLesson >> delete [

	browser ifNotNil: [ :br | br delete ]
]

{ #category : #'garbage-collection' }
OBLesson >> dereferencedObjects [

	^ self buildGraph dereferencedObjects
]

{ #category : #printing }
OBLesson >> displayString [

	^self title
]

{ #category : #accessing }
OBLesson >> executionContext [

	^ executionContext
]

{ #category : #diagram }
OBLesson >> exportDiagram [

	self objectDiagram exportDiagram
]

{ #category : #exporting }
OBLesson >> fileOut [
	| internalStream |
	[internalStream := (String new: 100) writeStream.
	
	self writeCreationScriptOver: internalStream.
	
	FileStream
		writeSourceCodeFrom: internalStream
		baseName: self lessonIdentification asFileName
		isSt: true
	] ensure: [ internalStream close ]
]

{ #category : #'lesson-variables' }
OBLesson >> hasVariableNamed: aVariableName [

	^self variables anySatisfy: [:v | v name = aVariableName ].
]

{ #category : #literals }
OBLesson >> includesLiteralNamed: aLiteralName [
	
	^literals includesKey: aLiteralName 
]

{ #category : #'initialize-release' }
OBLesson >> initialize [
	
	|  loopExecutionContextClass |
	super initialize.
	objects := Set new.
	variables := OrderedCollection new.
	workspaces := OrderedCollection new.
	tests := Dictionary new.
	
	lessonEnvironment := SystemDictionary withOrganizer: SystemOrganizer new.
	loopExecutionContextClass := self createClass: #LessonExecutionContext subclassOf: OBExecutionContext.
	executionContext := loopExecutionContextClass new
		lesson: self;
		yourself.
	objectDiagram := LOOPObjectDiagramFactory buildDiagram
		lesson: self;
		yourself.
	self initializeLiterals
]

{ #category : #literals }
OBLesson >> initializeLiterals [
	literals := Dictionary new.
	
	literals at:#bag put: (OBBagFactory newForLesson: self).
	literals at:#set put: (OBSetFactory newForLesson: self).
	literals at:#ordered put: (OBOrderedCollectionFactory newForLesson: self).
	literals at:#orderedcollection put: (OBOrderedCollectionFactory newForLesson: self).
	literals at:#sorted put: (OBSortedFactory newForLesson: self).
	literals at:#sortedcollection put: (OBSortedFactory newForLesson: self).
	literals at:#dictionary put: (OBDictionaryFactory newForLesson: self).
]

{ #category : #accessing }
OBLesson >> lessonEnvironment [

	^ lessonEnvironment
]

{ #category : #exporting }
OBLesson >> lessonIdentification [

	^self title asLegalSelector
]

{ #category : #literals }
OBLesson >> literalNamed: aLiteralName [

	^literals at: aLiteralName
]

{ #category : #'ui-actions' }
OBLesson >> menuActions [

	^ OrderedCollection
		with: { 'abrir' translated 		. #openSelectedLesson }
		with: { 'eliminar' translated 		. #removeSelectedLesson }
		with: { 'renombrar' translated 	. #renameSelectedLesson }
		with: { 'exportar' translated 	. #fileOutSelectedLesson }
]

{ #category : #diagram }
OBLesson >> objectDiagram [

	^ objectDiagram
]

{ #category : #objects }
OBLesson >> objects [

	^ objects
]

{ #category : #'ui-actions' }
OBLesson >> openInWorld [

	browser := (OBLessonModel onLesson: self) openInWorld
]

{ #category : #printing }
OBLesson >> printString [

	^self title
]

{ #category : #cleaning }
OBLesson >> removeFromSystem [

	executionContext class removeFromSystem.
	self lessonEnvironment do: [ :c | c isBehavior ifTrue: [ c removeFromSystem ] ].
	self lessonEnvironment removeAll.
]

{ #category : #objects }
OBLesson >> removeObject: anObjectBrowserObject [

	self objects remove: anObjectBrowserObject
]

{ #category : #tests }
OBLesson >> removeTest: aTest [

	tests removeKey: aTest selector
]

{ #category : #'lesson-variables' }
OBLesson >> removeVariable: anOBVariable [

	self variables remove: anOBVariable .
	self suspendAllWhile: [
		self executionContext class removeInstVarNamed: anOBVariable name.
	]
]

{ #category : #tests }
OBLesson >> runAllTests [

	| results |
	results := OBTestCaseResult new.
	self tests do: [ :t | 
		results add:( t run ).
		].
	^results

]

{ #category : #'garbage-collection' }
OBLesson >> runGarbageCollector [ 
	self dereferencedObjects do: [:o | 
		o removeClassFromSystem.
		self removeObject: o ].
]

{ #category : #'pharo-interaction' }
OBLesson >> suspendAllWhile: aBlock [

	"we suspend the system announcements"
	self class suspendAllWhile: aBlock
]

{ #category : #tests }
OBLesson >> testDictionary [

	^tests
]

{ #category : #tests }
OBLesson >> tests [

	^self testDictionary values
]

{ #category : #accessing }
OBLesson >> title [

	^ title
]

{ #category : #accessing }
OBLesson >> title: anObject [

	title := anObject
]

{ #category : #diagram }
OBLesson >> updateObjectDiagram [

	objectDiagram update
]

{ #category : #'lesson-variables' }
OBLesson >> variableNamed: aByteString [ 

	^ self variables detect:[ :var | var name = aByteString ]
]

{ #category : #'lesson-variables' }
OBLesson >> variables [

	^ variables
]

{ #category : #workspaces }
OBLesson >> workspaces [

	^ workspaces
]

{ #category : #exporting }
OBLesson >> writeAddScriptToLessonOn: stream [

	self variables
		do: [ :variable | 
			stream
				nextPutAll:
					self lessonIdentification , ' ', (self class>>#createVariableNamed:pointingTo:) selector separateKeywords substrings first ,' ''' , variable name , ''' ', (self class >> #createVariableNamed:pointingTo:) selector separateKeywords substrings second ,' ' , variable pointsTo posibleName
						, '.'.
			stream cr ].
	self objects
		do: [ :object | 
			stream nextPutAll: self lessonIdentification , ' addObject: ' , object posibleName , '.'.
			stream cr ].
	stream nextPutAll: '^ ' , self lessonIdentification , '.'.
	stream cr
]

{ #category : #exporting }
OBLesson >> writeAllTheVariablesOn: stream [ 
	
	stream nextPutAll: '| '.
	self objects do:[ :anObject | stream nextPutAll:  anObject posibleName , ' ' ] .
	stream nextPutAll: self lessonIdentification,' |'.
	stream cr ; cr.
]

{ #category : #exporting }
OBLesson >> writeCreationScriptOver: stream [
	
	"primero la definicion de variables"
	self writeAllTheVariablesOn: stream .
	
	stream cr.
	
	"ahora la definicion de la leccion"
	self writeLessonCreationOn: stream.
	
	stream cr.
	
	"la creacion del objeto"
	self objects do:[ :anObject | anObject writeCreateObjectOn: stream lesson: self].
	
	"despues la descripcion del objeto: variables, metodos y prototipo"
	self objects do:[ :anObject | anObject writeObjectDescriptionScriptOn: stream lesson: self].
	
	stream cr.
	
	"despues el estado"
	self objects do:[ :anObject | anObject writeStateScriptOn: stream lesson: self.] .
	
	stream cr.
	
	self writeWorkspacesOn: stream.
	
	stream cr.
	
	self tests do: [ :aTest | aTest writeExportScriptOn: stream  lesson: self. ].
	
	stream cr.
	
	"despues la incorporacion a la lesson"
	self writeAddScriptToLessonOn: stream .
]

{ #category : #exporting }
OBLesson >> writeLessonCreationOn: stream. [

	stream nextPutAll: self lessonIdentification, ' := ', self class name ,' new title: ''',self title ,'''.'.
	stream cr.
	stream nextPutAll: 'self addLesson: ', self lessonIdentification , '.'.
	stream cr.
]

{ #category : #exporting }
OBLesson >> writeWorkspacesOn: stream [
	
	stream cr.
	stream nextPutAll: '"Workspaces exported"'.
	self workspaces do:[ :aWorkspace | 
		stream cr.
		aWorkspace writeOn: stream withLessonIdentification: self lessonIdentification.
		] .
	stream cr.
]
