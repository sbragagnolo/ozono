Class {
	#name : #ObjectBrowser,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'selectedObjectBrowserVariable',
		'selectedObjectBrowserSelector',
		'selectedObjectAttribute',
		'selectedObjectSelector',
		'window',
		'organization',
		'selectedItem',
		'selectedWorkspace',
		'dependants',
		'objectSelectionInterested',
		'selectedTest',
		'selectedDerreferencedObject'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #creation }
ObjectBrowser class >> onLesson: aLOOPLesson [ 
	^self new lesson: aLOOPLesson;
		yourself.
]

{ #category : #accessing }
ObjectBrowser >> actionsForAttributeListWith: selectedAttribute [
	^self selectedObject actionsForAttributeListWith: selectedAttribute
]

{ #category : #accessing }
ObjectBrowser >> actionsForObjectVariableList [
	^(OrderedCollection with: #('crear nuevo objeto' #createObject))
		addAll: self selectedObject actionsForObjectVariableList;
		asArray.
]

{ #category : #accessing }
ObjectBrowser >> addExtraItems: aMenu [
	"Aca nos pasan el menu y le agregamos los submenus que querramos, en mi caso le agrego todo lo de las colecciones :)"

	aMenu add: self subMenuCollectionsName subMenu: self subMenuCollections. 
]

{ #category : #'dependents access' }
ObjectBrowser >> addObjectSelectionInterested: anInterested [
	self objectSelectionInterested add: anInterested
]

{ #category : #'dependents access' }
ObjectBrowser >> addTestSelectionInterested: anInterested [
	anInterested classOrMetaClass: self lesson loopExecutionContextClass
]

{ #category : #menues }
ObjectBrowser >> attributeListMenu: aMenu shifted: shifted [
	^aMenu addList: (self actionsForAttributeListWith: self selectedObjectAttribute)
]

{ #category : #ObjectBrowser }
ObjectBrowser >> canDelete: anObjectBrowserObject [

	^self objects allSatisfy: [ :anOBObject | (anOBObject hasReferencesTo: anObjectBrowserObject) not ]
]

{ #category : #ObjectBrowser }
ObjectBrowser >> changed [
	super changed.
	self dependants do: [ :d | d refresh ].
]

{ #category : #showing }
ObjectBrowser >> cloneObject [
	| objectName |
	(self errorHandler
		evaluate: [
			objectName := self obtainObjectName.
			objectName ifNotNil: [self createVariable: objectName referencingTo: self selectedObjectBrowserVariable pointsTo clone].
			]).
	self changed
]

{ #category : #accessing }
ObjectBrowser >> compileMethod: aText [ 
	self errorHandler
		evaluate: [	self selectedObject compileMethod: aText.
					self changed]
]

{ #category : #accessing }
ObjectBrowser >> compileTest: aText [ 
	self errorHandler
		evaluate: [	self lesson compileTest: aText.
					self changed]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> confirmDeletion [ 
	^UIManager default confirm: '¿Esta seguro de eliminar?' trueChoice: 'Si' falseChoice: 'No' .
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createAttribute [
	| variableName |
	(self errorHandler
		evaluate: [variableName := self request: 'Nombre de la variable' default: ''.
			variableName ifNotNil: [self selectedObject addVariable: variableName]]).
	self changed
]

{ #category : #showing }
ObjectBrowser >> createBag [
	self createCollection: bag.
]

{ #category : #showing }
ObjectBrowser >> createCollection: type [
	|collectionName|

	(self errorHandler
		evaluate: [
			collectionName := self obtainObjectName.
			collectionName 
				ifNotNil: [ self createVariable: collectionName referencingTo: type clone ].
		]).
	self changed.
	

]

{ #category : #showing }
ObjectBrowser >> createObject [
	| objectName |

	(self errorHandler
		evaluate: [
			objectName := self obtainObjectName.
			objectName ifNotNil: [self createVariable: objectName]]).
	self changed
]

{ #category : #showing }
ObjectBrowser >> createOrdered [
	self createCollection: ordered.
]

{ #category : #showing }
ObjectBrowser >> createSet [
	self createCollection: set.
]

{ #category : #menues }
ObjectBrowser >> createTest [
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createVariable: aVariableNameString [
	self createVariable: aVariableNameString  referencingTo: (ObjectBrowserObject newOn: self lesson).
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createVariable: aVariableNameString referencingTo: anObjectBrowserObject [
	| newVariable |
	self validateVariableName: aVariableNameString.
	
	newVariable := (LessonVariable newNamed: aVariableNameString)
		pointTo: anObjectBrowserObject;
		yourself.
	self lesson addVariable: newVariable.
	self selectedItem: newVariable.
]

{ #category : #showing }
ObjectBrowser >> createWorkspace [
	| workspaceLabel |
	(self errorHandler
		evaluate: [
			workspaceLabel := self obtainWorkpaceLabel.
			workspaceLabel ifNotNil:[
			self createWorkspace: workspaceLabel.
			]]).
	self changed
]

{ #category : #showing }
ObjectBrowser >> createWorkspace: workspaceLabel [
	| workspace |
	workspace := self lesson createWorkspace: workspaceLabel.
	self selectedItem: workspace.
	self changed.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> delete [
	window delete.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> deleteObject [
	self errorHandler
		evaluate: [
			self selectedObject
				ifNil: [self error: 'No hay ninguna referencia elegida'].
			self selectedObject canDelete ifFalse: [self error: 'El objeto no puede ser borrado'].
			self confirmDeletion ifTrue:[self doDeleteObject].
			].
	self changed
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> deleteVariable [
	self errorHandler
		evaluate: [
			self selectedObjectAttribute
				ifNil: [self error: 'No hay ninguna variable elegida'].
			self confirmDeletion ifTrue:[self doDeleteVariable].
			].
	self changed
]

{ #category : #ObjectBrowser }
ObjectBrowser >> dependant: aDependant [
	self dependants add: aDependant.
]

{ #category : #ObjectBrowser }
ObjectBrowser >> dependants [
	^dependants ifNil: [ dependants := Set new].
]

{ #category : #accessing }
ObjectBrowser >> dereferenceSelectedVariable [
	self selectedObjectBrowserVariable desreference.
	self selectDereferencedObject: self selectedObjectBrowserVariable.
	self changed .
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> deselectVariables [
	self selectedObjectAttribute: NullLessonVariable new.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> doDeleteObject [
	self lesson removeVariable: self selectedObjectBrowserVariable .
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> doDeleteVariable [
	self selectedObject removeVariable: self selectedObjectAttribute.
	self deselectVariables 
	
]

{ #category : #accessing }
ObjectBrowser >> errorHandler [
	^ErrorHandler default
]

{ #category : #showing }
ObjectBrowser >> garbageCollectorButtonLabel [
	^'Run Garbage Collector'
]

{ #category : #'initialize-release' }
ObjectBrowser >> initialize [
	super initialize.
	self selectedObjectBrowserVariable: NullLessonVariable new.
	Smalltalk at:#bag ifAbsentPut: (OBBaseBagCollection new).
	Smalltalk at:#set ifAbsentPut: (OBBaseSetCollection new).
	Smalltalk at:#ordered ifAbsentPut: (OBBaseSetCollection new).
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> lesson [
	^lesson
]

{ #category : #accessing }
ObjectBrowser >> lesson: aLOOPLesson [ 
	lesson := aLOOPLesson.
]

{ #category : #accessing }
ObjectBrowser >> lessonOrganization [
	^organization ifNil: [ organization := OrderedCollection 
		with: (OBListItemWrapper with: (ObjectsOrganization for: self))
		with: (OBListItemWrapper with: (WorkspacesOrganization for: self))
		with: (OBListItemWrapper with: (TestsOrganization for: self))
		with: (OBListItemWrapper with: (RecicleBinOrganization for: self))
		]
]

{ #category : #menues }
ObjectBrowser >> methodListMenu: aMenu shifted: shifted [
	aMenu addList: #(
		('borrar metodo'			deleteMethod)).
	^ aMenu
]

{ #category : #ObjectBrowser }
ObjectBrowser >> objectBrowserVariables [
	^self lesson variables
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> objectNames [
	^self objects collect:[:each | each name]
]

{ #category : #'dependents access' }
ObjectBrowser >> objectSelectionInterested [
	^objectSelectionInterested ifNil: [ objectSelectionInterested := Set new ]
]

{ #category : #ObjectBrowser }
ObjectBrowser >> objects [
	^self lesson objects
]

{ #category : #accessing }
ObjectBrowser >> objectsOrganizationSelected [
	self selectedObjectBrowserVariable: NullLessonVariable new.
]

{ #category : #accessing }
ObjectBrowser >> obtainObjectName [
	| objectName |
	objectName := self request: 'Nombre de la referencia al objeto' default: 'nuevaReferencia'.
	self validateVariableName: objectName .
	^ objectName
]

{ #category : #showing }
ObjectBrowser >> obtainWorkpaceLabel [
	^self request: 'Nombre del workspace' default: 'nuevoWorkspace'.
]

{ #category : #'initialize-release' }
ObjectBrowser >> openInWorld [
	window := ObjectBrowserWindow show: self.
	
]

{ #category : #showing }
ObjectBrowser >> openWorkspace [
	self selectedItem openInWorld
]

{ #category : #menues }
ObjectBrowser >> orphanObjects [
	^(self lesson dereferencedObjects) collect: [ :o | DereferencedObject newOn: o].
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> recoverObject [
	| variableName |
	(self errorHandler
		evaluate: [
			variableName := self request: 'Nombre de la referencia' default: 'recuperadoDeLaPapelera'.
			variableName ifNotNil: [ 
				self createVariable: variableName referencingTo: self selectedDerreferencedObject realObject.
				]
		]).
	self changed
]

{ #category : #model }
ObjectBrowser >> removeObject: anObject [
	self objects remove: anObject.
]

{ #category : #showing }
ObjectBrowser >> removeWorkspace [
	self confirmDeletion ifTrue: [self workspaces remove: self selectedItem].
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> request: aTitle default: aDefaultValue [
	^ UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #testing }
ObjectBrowser >> runAllTests [
	| results |
	results := self lesson runAllTests.
	(self dependants detect: [ :d | d isKindOf: ObjectBrowserWindow ]) setTestsResults: results.
]

{ #category : #accessing }
ObjectBrowser >> runAllTestsLabel [
	^'Probar Todos'
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> runGarbageCollector [
	self lesson runGarbageCollector.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> selectDereferencedObject: aDerreferencedObject [
	selectedObjectBrowserVariable  := NullLessonVariable new.
	selectedObjectAttribute := NullLessonVariable new.
	selectedObjectSelector := NullOBMethod new.
	selectedDerreferencedObject := aDerreferencedObject .
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> selectedDerreferencedObject [
	^selectedDerreferencedObject  .
]

{ #category : #accessing }
ObjectBrowser >> selectedItem [
	^selectedItem
]

{ #category : #accessing }
ObjectBrowser >> selectedItem: anItem [
	selectedItem := anItem.
	selectedItem ifNotNil: [ selectedItem makeSelectionOn: self. ]
]

{ #category : #menues }
ObjectBrowser >> selectedItemMenu: aMenuMorph [ 
	^self selectedItem ifNotNil: [ :item | item menu: aMenuMorph]
]

{ #category : #accessing }
ObjectBrowser >> selectedMethodCode [
	"el codigo del metodo que esta seleccionado, Text vacio si no hay metodo seleccionado"

	^(self selectedObjectSelector isNil)
			ifTrue: [self selectorListEmpyText]
			ifFalse: [
				(self selectedObject sourceCodeAt: self selectedObjectSelector) ]
]

{ #category : #accessing }
ObjectBrowser >> selectedObject [
	^self selectedObjectBrowserVariable pointsTo
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectAttribute [
	^selectedObjectAttribute
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectAttribute: anAttribute [
	selectedObjectAttribute := anAttribute.
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectAttributes [
	^self selectedObject variables
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectBrowserVariable [
	^selectedObjectBrowserVariable
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectBrowserVariable: anOBVariable [
	selectedObjectBrowserVariable  := anOBVariable.
	selectedObjectAttribute := NullLessonVariable new.
	selectedObjectSelector := NullOBMethod new.
	anOBVariable notifySelectionTo: self objectSelectionInterested.
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectMethods [
	^self selectedObject methods
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectSelector [
	^selectedObjectSelector
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectSelector: aMethod [
	selectedObjectSelector := aMethod.
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> selectedTest [
	^selectedTest
]

{ #category : #accessing }
ObjectBrowser >> selectedTest: aTest [
	selectedTest := aTest.
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> selectedTestCode [
	"el codigo del metodo que esta seleccionado, Text vacio si no hay metodo seleccionado"

	^self selectedTest ifNil: [ 'newwww testtt' ]
						ifNotNil: [ 'existee' ]
]

{ #category : #accessing }
ObjectBrowser >> selectedWorkspace: aWorkspace [
	selectedWorkspace := aWorkspace
]

{ #category : #showing }
ObjectBrowser >> selectorListEmpyText [
	| string|

	string := 'messageSelectorAndArgumentNames
	"comment stating purpose of message"

	| temporary variable names |
	statements'.

	^ (Text fromString: string) makeSelectorBold 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> showObjectGraph [

]

{ #category : #accessing }
ObjectBrowser >> subMenuCollections [
	| menuCrearColeccion |
	menuCrearColeccion := MenuMorph new target: self; yourself .
	menuCrearColeccion add:'set' action: #createSet.
	menuCrearColeccion add:'bag' action: #createBag.
	menuCrearColeccion add:'ordered' action: #createOrdered.
	^menuCrearColeccion.
	
]

{ #category : #accessing }
ObjectBrowser >> subMenuCollectionsName [
	^'Crear nuevo conjunto'
]

{ #category : #'dependents access' }
ObjectBrowser >> testSelectionInterested [
	^testSelectionInterested ifNil: [ testSelectionInterested := Set new ]
]

{ #category : #menues }
ObjectBrowser >> tests [
	^self lesson tests
]

{ #category : #menues }
ObjectBrowser >> testsOrganizationSelected [
	self selectedObjectBrowserVariable: NullLessonVariable new.
]

{ #category : #showing }
ObjectBrowser >> title [
	 ^self lesson title
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> validateVariableName: aVariableNameString [
	(self variables anySatisfy: [:v | v name = aVariableNameString ])
		ifTrue: [ self error: 'Ya se ha definido una variable de nombre ', aVariableNameString  ]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> variableNamed: aVariableNameString [
	^self lesson variableNamed: aVariableNameString.
]

{ #category : #ObjectBrowser }
ObjectBrowser >> variables [
	^self lesson variables
]

{ #category : #accessing }
ObjectBrowser >> workspaceSelected: aWorkspace [
	self selectedObjectBrowserVariable: NullLessonVariable new.
	self selectedWorkspace: aWorkspace.
]

{ #category : #menues }
ObjectBrowser >> workspaces [
	^self lesson workspaces
]

{ #category : #selection }
ObjectBrowser >> workspacesOrganizationSelected [
	self selectedObjectBrowserVariable: NullLessonVariable new.
]
