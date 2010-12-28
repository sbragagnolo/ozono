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
	[ [
		ClassBuilder beSilent: true.
		inStream := StandardFileStream fileNamed: aFileName.
		lessonImported := Compiler new 
			evaluate: inStream readStream
			in: nil
			to: self
			notifying: nil
			ifFail: [FakeClassPool adopt: nil. ^ #failedDoit]
			logged: true.
		] valueSuppressingAllMessages
	] ensure: [ 
		ClassBuilder beSilent: false.
		inStream close.
	].
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
	self executionContext class addInstVarNamed: aVariable name.
	(aVariable pointsTo isKindOf: NoObjectBrowserObject) ifFalse: [self addObject: aVariable pointsTo.].
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

{ #category : #accessing }
LOOPLesson >> addVariableWithExistentObject: aVariable [
	self variables add: aVariable.
	self executionContext class addInstVarName: aVariable name.
]

{ #category : #accessing }
LOOPLesson >> addWorkspace: aWorkspace [
	self workspaces add: aWorkspace 
]

{ #category : #accessing }
LOOPLesson >> asString [
	^self displayString copyReplaceAll: ' ' with: ''
]

{ #category : #diagram }
LOOPLesson >> buildGraph [
	| graph |
	graph := LessonGraph new.
	graph addLesson: self.
	graph allTheObjects: self objects.
	^graph
]

{ #category : #'as yet unclassified' }
LOOPLesson >> changed [
	super changed .
	browser changed .
]

{ #category : #accessing }
LOOPLesson >> clean [
	self objects removeAll.
	self variables do:[:v | executionContext class removeFromSystem ].
	self variables removeAll.
	self removeFromSystem.
	self class instVarNames do: [ :vn | self instVarNamed: vn put: nil].
]

{ #category : #accessing }
LOOPLesson >> compileTest: aTestText [
	| result newTest |
	result := self executionContext class compile: aTestText classified: #'tests'  notifying: nil.
	newTest := (OBTest newText: result onLesson: self).
	self testDictionary at: result put: newTest.
	^newTest
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
			category: 'Useless'.
]

{ #category : #'as yet unclassified' }
LOOPLesson >> createWorkspace: workspaceLabel contents: someContents [
	| workspace |
	workspace := LOOPWorkspace new
		label: workspaceLabel;
		contents: someContents;
		lesson: self.
	self addWorkspace: workspace.
	workspace openLabel: workspaceLabel.
	workspace containingWindow center: World center.
	^workspace
]

{ #category : #'as yet unclassified' }
LOOPLesson >> delete [
	browser ifNotNil: [ :br | br delete ]
]

{ #category : #accessing }
LOOPLesson >> dereferencedObjects [
	^self buildGraph dereferencedObjects
]

{ #category : #accessing }
LOOPLesson >> displayString [
	^self title
]

{ #category : #accessing }
LOOPLesson >> executionContext [
	^executionContext lesson: self; yourself
]

{ #category : #diagram }
LOOPLesson >> exportDiagram [
	self objectDiagram exportDiagram
]

{ #category : #exportation }
LOOPLesson >> fileIn: aFileName [
	^Compiler new 
			evaluate: aFileName readStream
			in: nil
			to: self
			notifying: self
			ifFail: [FakeClassPool adopt: nil. ^ #failedDoit]
			logged: true.
]

{ #category : #exportation }
LOOPLesson >> fileInSomethingInFile: aFileName [
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
		lessonImported isNil ifTrue: [self error: 'Falló la importación'].
		^ lessonImported.
]

{ #category : #exportation }
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
	(self realObjects anySatisfy: [:realObject | realObject == aRealObject])
		ifTrue:  [ ^self objects detect: [ :o | o realObject == aRealObject ] ]
		ifFalse: [ ^NoObjectBrowserObject new: aRealObject . ]
]

{ #category : #accessing }
LOOPLesson >> hasObject: anObject [
	^objects includes: anObject.
]

{ #category : #accessing }
LOOPLesson >> hasReferencesTo: anObjectBrowserObject [
	^self variables anySatisfy: [ :v | v hasReferencesTo: anObjectBrowserObject ].
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
	objectDiagram := LOOPObjectDiagramFactory buildDiagram lesson: self; yourself.
]

{ #category : #accessing }
LOOPLesson >> lessonEnvironment [
	^lessonEnvironment ifNil: [ 
		lessonEnvironment := SystemDictionary new.
		lessonEnvironment organization: SystemOrganizer new.
		lessonEnvironment
		 ].
]

{ #category : #exportation }
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
	^objects ifNil: [objects := Set new].
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
LOOPLesson >> realObjects [
	^self objects collect: [ :o | o realObject ].
]

{ #category : #accessing }
LOOPLesson >> referencedObjects [
	| referencedObjects |
	self deprecated: 'use self buildGraph objects'.
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
	self deprecated: 'no se usa'.
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
LOOPLesson >> removeTest: aTest [
	tests removeKey: aTest selector
]

{ #category : #'as yet unclassified' }
LOOPLesson >> removeVariable: anOBVariable [ 
	self variables remove: anOBVariable .
	self executionContext class removeInstVarName: anOBVariable name.
]

{ #category : #accessing }
LOOPLesson >> runAllTests [
	| results result |
	results := LOOPTestCaseResult new.
	self tests do: [ :t | 
		results add:( t run ).
		].
	^results

]

{ #category : #accessing }
LOOPLesson >> runGarbageCollector [ 
	self dereferencedObjects do: [:o | 
		o removeClassFromSystem.
		self removeObject: o ].
]

{ #category : #accessing }
LOOPLesson >> selectFrom: start to: end [ 
	"asco para poder hacer fileins"
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
	objectDiagram update
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

{ #category : #exportation }
LOOPLesson >> writeAddScriptToLessonOn: stream [
	self variables do: [ :variable | stream nextPutAll: self lessonIdentification ,' addVariableNamed: ''', variable name , ''' pointingTo: ', variable referencePosibleName, '.'. stream cr].
	self objects do: [ :object | stream nextPutAll: self lessonIdentification ,' addObject: ', object posibleName , '.'. stream cr].
	stream nextPutAll: '^ ', self lessonIdentification , '.'.
	stream cr.
]

{ #category : #exportation }
LOOPLesson >> writeAllTheVariablesOn: stream [ 
	
	stream nextPutAll: '| '.
	self objects do:[ :anObject | stream nextPutAll:  anObject posibleName , ' ' ] .
	stream nextPutAll: self lessonIdentification,' |'.
	stream cr ; cr.
]

{ #category : #exportation }
LOOPLesson >> writeCreationScriptOver: stream [
	
	"primero la definicion de variables"
	self writeAllTheVariablesOn: stream .
	
	stream cr.
	
	"ahora la definicion de la leccion"
	self writeLessonCreationOn: stream.
	
	stream cr.
	
	"despues la descripcion del objeto: su creacion, variables y metodos"
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

{ #category : #exportation }
LOOPLesson >> writeLessonCreationOn: stream. [
	stream nextPutAll: self lessonIdentification, ' := LOOPLesson new title: ''',self title ,'''.'.
	stream cr.
	stream nextPutAll: 'self addLesson: ', self lessonIdentification , '.'.
	stream cr.
]

{ #category : #exportation }
LOOPLesson >> writeWorkspacesOn: stream [
	
	stream cr.
	stream nextPutAll: '"Workspaces exported"'.
	self workspaces do:[ :aWorkspace | 
		stream cr.
		aWorkspace writeOn: stream withLessonIdentification: self lessonIdentification.
		] .
	stream cr.
]
