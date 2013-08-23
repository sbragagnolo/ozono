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
		'loopExecutionContextClass',
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

{ #category : #creation }
OBLesson class >> addLesson: lesson. [
	self lessons add: lesson.
]

{ #category : #accessing }
OBLesson class >> browseLessons [ 
	(OBLessonBrowserModel on: self) openInWorld
]

{ #category : #accessing }
OBLesson class >> cleanAllLessons [
	self lessons do: [ :lesson | lesson clean  ].
]

{ #category : #creation }
OBLesson class >> createFreeLesson [
	| lesson |
	lesson := self newFreeLesson.
	self addLesson: lesson.
	^lesson.
]

{ #category : #creation }
OBLesson class >> createLessonNamed: title [ 
	^self createFreeLesson title:  title; yourself .
]

{ #category : #accessing }
OBLesson class >> deleteAllLessons [
	self cleanAllLessons .
	lessons := OrderedCollection new.
]

{ #category : #accessing }
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

{ #category : #accessing }
OBLesson class >> newFreeLesson [
	^self new title:'Free Lesson'
	
]

{ #category : #accessing }
OBLesson class >> select [
]

{ #category : #accessing }
OBLesson class >> selectFrom: start to: end [ 
	"asco para fileIn #2"
]

{ #category : #accessing }
OBLesson class >> selectionInterval [
	"asco para poder hacer fileins"
	^1 to: 0
]

{ #category : #'system-events' }
OBLesson class >> suspendAllWhile: aBlock [

	SystemAnnouncer uniqueInstance suspendAllWhile: aBlock
]

{ #category : #'object-handling' }
OBLesson >> addObject: anObject [
	^self objects add: anObject.
]

{ #category : #'reference-handling' }
OBLesson >> addVariable: aVariable [
	self basicAddVariable: aVariable.
	(aVariable pointsTo isKindOf: OBExternalObjectMetaObject) ifFalse: [self addObject: aVariable pointsTo.].
]

{ #category : #'reference-handling' }
OBLesson >> addVariableNamed: theReferenceName pointingTo: anObject [
	|aVariable|
	aVariable :=	 (LessonVariable new)
		name: theReferenceName ;
		pointTo: anObject ;
		yourself.
	
	self addVariable: aVariable.

]

{ #category : #accessing }
OBLesson >> addWorkspace: aWorkspace [
	self workspaces add: aWorkspace 
]

{ #category : #accessing }
OBLesson >> asString [
	^self displayString copyReplaceAll: ' ' with: ''
]

{ #category : #'reference-handling' }
OBLesson >> basicAddVariable: aVariable [
	self variables add: aVariable.
	self suspendAllWhile: [
		self executionContext class addInstVarNamed: aVariable name.
	].
]

{ #category : #diagram }
OBLesson >> buildGraph [
	| graph |
	graph := LessonGraph new.
	graph addLesson: self.
	graph allTheObjects: self objects.
	^graph
]

{ #category : #'as yet unclassified' }
OBLesson >> changed [
	super changed .
	browser changed .
]

{ #category : #accessing }
OBLesson >> clean [
	self objects removeAll.
	self variables do:[:v | executionContext class removeFromSystem ].
	self variables removeAll.
	self removeFromSystem.
	self class instVarNames do: [ :vn | self instVarNamed: vn put: nil].
]

{ #category : #accessing }
OBLesson >> compileTest: aTestText [
	| result newTest |
	self suspendAllWhile: [
		result := self executionContext class compile: aTestText classified: #'tests'  notifying: nil.
		newTest := (OBTest newText: result onLesson: self).
		self testDictionary at: result put: newTest.
		^newTest
	]
]

{ #category : #accessing }
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

{ #category : #'object-handling' }
OBLesson >> createObject [
	| newObject |
	newObject := OBMetaObject newOn: self.
	self addObject: newObject.
	^newObject
	
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
OBLesson >> delete [
	browser ifNotNil: [ :br | br delete ]
]

{ #category : #accessing }
OBLesson >> dereferencedObjects [
	^self buildGraph dereferencedObjects
]

{ #category : #accessing }
OBLesson >> displayString [
	^self title
]

{ #category : #accessing }
OBLesson >> executionContext [
	^executionContext lesson: self; yourself
]

{ #category : #diagram }
OBLesson >> exportDiagram [
	self objectDiagram exportDiagram
]

{ #category : #'as yet unclassified' }
OBLesson >> exportTest: anOBTest [

	|internalStream|

	internalStream := (String new: 50) writeStream.
	anOBTest writeYourOwnCodeOn:  internalStream lesson: self.
	FileStream writeSourceCodeFrom: internalStream baseName: self lessonIdentification asFileName isSt: true.
	
]

{ #category : #exportation }
OBLesson >> fileIn: aFileName [
	^Compiler new 
			evaluate: aFileName readStream
			in: nil
			to: self
			notifying: self
			ifFail: [^nil ]
			logged: true.
]

{ #category : #exportation }
OBLesson >> fileInSomethingInFile: aFileName [
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
OBLesson >> fileOut [

	| internalStream |
	[internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: self lessonIdentification asFileName isSt: true.
	
	] ensure: [ internalStream close ]
]

{ #category : #accessing }
OBLesson >> getObjectBrowserObjectFromRealObject: aRealObject [
	(self realObjects anySatisfy: [:realObject | realObject == aRealObject])
		ifTrue:  [ ^self objects detect: [ :o | o realObject == aRealObject ] ]
		ifFalse: [ ^OBExternalObjectMetaObject for: aRealObject . ]
]

{ #category : #accessing }
OBLesson >> hasObject: anObject [
	^objects includes: anObject.
]

{ #category : #accessing }
OBLesson >> hasReferencesTo: anObjectBrowserObject [
	^self variables anySatisfy: [ :v | v hasReferencesTo: anObjectBrowserObject ].
]

{ #category : #'as yet unclassified' }
OBLesson >> hasVariable: aVariableName [
	^self variables anySatisfy: [:v | v name = aVariableName ].
]

{ #category : #'as yet unclassified' }
OBLesson >> hasVariableNamed: aVariableName [
	^self variables anySatisfy: [:v | v name = aVariableName ].
]

{ #category : #literals }
OBLesson >> includesLiteralNamed: aLiteralName [
	
	^literals includesKey: aLiteralName 
]

{ #category : #'initialize-release' }
OBLesson >> initialize [
	executionContext := self loopExecutionContextClass new
							lesson: self;
							yourself.
	objectDiagram := LOOPObjectDiagramFactory buildDiagram lesson: self; yourself.
	self initializeLiterals.
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
	^lessonEnvironment ifNil: [ 
		lessonEnvironment := SystemDictionary withOrganizer: SystemOrganizer new.
		 ].
]

{ #category : #exportation }
OBLesson >> lessonIdentification [
	^self title asLegalSelector
]

{ #category : #literals }
OBLesson >> literalNamed: aLiteralName [

	^literals at: aLiteralName
]

{ #category : #accessing }
OBLesson >> loopExecutionContextClass [
	^loopExecutionContextClass ifNil: [ 
		loopExecutionContextClass :=  
			self createClass: #LessonExecutionContext 
				subclassOf: LOOPExecutionContext. ]
]

{ #category : #showing }
OBLesson >> menuActions [
^OrderedCollection
		with: (Array braceWith: 'abrir' translated with: #openSelectedLesson)
		with: (Array braceWith: 'eliminar' translated with: #removeSelectedLesson)
		with: (Array braceWith: 'renombrar' translated with: #renameSelectedLesson)
		with: (Array braceWith: 'exportar' translated with: #fileOutSelectedLesson)
]

{ #category : #showing }
OBLesson >> objectBrowserObjectForRealObject: realObject [
	^self objects detect: [ :o | o realObject == realObject ] ifNone: [ OBExternalObjectMetaObject for: realObject ].
]

{ #category : #diagram }
OBLesson >> objectDiagram [
	^objectDiagram 
]

{ #category : #accessing }
OBLesson >> objects [
	^objects ifNil: [objects := Set new].
]

{ #category : #accessing }
OBLesson >> objects: anObject [
	objects := anObject
]

{ #category : #showing }
OBLesson >> openInWorld [
	browser := (OBLessonModel onLesson: self) openInWorld
]

{ #category : #accessing }
OBLesson >> parseTestCodeFrom: stream [

]

{ #category : #accessing }
OBLesson >> printString [
	^self title
]

{ #category : #accessing }
OBLesson >> realObjects [
	^self objects collect: [ :o | o realObject ].
]

{ #category : #accessing }
OBLesson >> referencesObject: anObjectBrowserObject [
	^self variables anySatisfy: [:v | v isPointingTo: anObjectBrowserObject ].
]

{ #category : #accessing }
OBLesson >> removeDerrefencedObject: aDereferencedObject [ 
	self deprecated: 'no se usa'.
	self dereferencedObjects remove: aDereferencedObject .
]

{ #category : #'as yet unclassified' }
OBLesson >> removeFromSystem [
	self loopExecutionContextClass removeFromSystem.
	self lessonEnvironment do: [ :c | c isBehavior ifTrue: [ c removeFromSystem ] ].
	self lessonEnvironment removeAll.
]

{ #category : #'as yet unclassified' }
OBLesson >> removeObject: anObjectBrowserObject [ 
	self objects remove: anObjectBrowserObject.
]

{ #category : #'as yet unclassified' }
OBLesson >> removeTest: aTest [
	tests removeKey: aTest selector
]

{ #category : #'as yet unclassified' }
OBLesson >> removeVariable: anOBVariable [ 
	self variables remove: anOBVariable .
	self suspendAllWhile: [
		self executionContext class removeInstVarNamed: anOBVariable name.
	]
]

{ #category : #accessing }
OBLesson >> runAllTests [
	| results result |
	results := LOOPTestCaseResult new.
	self tests do: [ :t | 
		results add:( t run ).
		].
	^results

]

{ #category : #accessing }
OBLesson >> runGarbageCollector [ 
	self dereferencedObjects do: [:o | 
		o removeClassFromSystem.
		self removeObject: o ].
]

{ #category : #accessing }
OBLesson >> selectFrom: start to: end [ 
	"asco para poder hacer fileins"
]

{ #category : #accessing }
OBLesson >> selectionInterval [
	"asco para poder hacer fileins"
	^1 to: 0
]

{ #category : #'system-events' }
OBLesson >> suspendAllWhile: aBlock [
	"we suspend the system announcements"
	self class suspendAllWhile: aBlock
]

{ #category : #accessing }
OBLesson >> testDictionary [
	^tests ifNil: [ tests := Dictionary new ]
]

{ #category : #accessing }
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

{ #category : #'as yet unclassified' }
OBLesson >> variableNamed: aByteString [ 
	^self variables detect:[ :var | var name = aByteString  ].
]

{ #category : #accessing }
OBLesson >> variables [
	^ variables ifNil:[variables := OrderedCollection new]
]

{ #category : #accessing }
OBLesson >> variables: anObject [
	variables := anObject
]

{ #category : #accessing }
OBLesson >> workspaces [
	^ workspaces ifNil:[ workspaces := OrderedCollection new]
]

{ #category : #exportation }
OBLesson >> writeAddScriptToLessonOn: stream [
	self variables
		do: [ :variable | 
			stream
				nextPutAll:
					self lessonIdentification , ' addVariableNamed: ''' , variable name , ''' pointingTo: ' , variable pointsTo posibleName
						, '.'.
			stream cr ].
	self objects
		do: [ :object | 
			stream nextPutAll: self lessonIdentification , ' addObject: ' , object posibleName , '.'.
			stream cr ].
	stream nextPutAll: '^ ' , self lessonIdentification , '.'.
	stream cr
]

{ #category : #exportation }
OBLesson >> writeAllTheVariablesOn: stream [ 
	
	stream nextPutAll: '| '.
	self objects do:[ :anObject | stream nextPutAll:  anObject posibleName , ' ' ] .
	stream nextPutAll: self lessonIdentification,' |'.
	stream cr ; cr.
]

{ #category : #exportation }
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

{ #category : #exportation }
OBLesson >> writeLessonCreationOn: stream. [
	stream nextPutAll: self lessonIdentification, ' := LOOPLesson new title: ''',self title ,'''.'.
	stream cr.
	stream nextPutAll: 'self addLesson: ', self lessonIdentification , '.'.
	stream cr.
]

{ #category : #exportation }
OBLesson >> writeWorkspacesOn: stream [
	
	stream cr.
	stream nextPutAll: '"Workspaces exported"'.
	self workspaces do:[ :aWorkspace | 
		stream cr.
		aWorkspace writeOn: stream withLessonIdentification: self lessonIdentification.
		] .
	stream cr.
]
