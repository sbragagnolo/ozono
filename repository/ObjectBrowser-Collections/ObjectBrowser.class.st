Class {
	#name : #ObjectBrowser,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'selectedObjectBrowserVariable',
		'selectedObjectBrowserSelector',
		'selectedObjectAttribute',
		'window',
		'organization',
		'selectedItem',
		'selectedWorkspace',
		'dependants',
		'objectSelectionInterested',
		'selectedTest',
		'selectedDerreferencedObject',
		'selectedTabIndex',
		'selectedPage',
		'selectedObjectMethod'
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

{ #category : #'dependents access' }
ObjectBrowser >> addObjectSelectionInterested: anInterested [
	self objectSelectionInterested add: anInterested
]

{ #category : #'dependents access' }
ObjectBrowser >> addTestSelectionInterested: anInterested [
"	anInterested classOrMetaClass:  self lesson loopExecutionContextClass"
]

{ #category : #menues }
ObjectBrowser >> attributeListMenu: aMenu shifted: shifted [
	^aMenu addList: (self actionsForAttributeListWith: self selectedObjectAttribute)
]

{ #category : #accessing }
ObjectBrowser >> borrarPosicionesDeLosNodos [
	self lesson borrarPosicionesDeLosNodos
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
		self createObject: [:objectName | 
			self createVariable: objectName referencingTo: (self selectedObjectBrowserVariable pointsTo clone)
			].
]

{ #category : #accessing }
ObjectBrowser >> compileMethod: aText notifying: someone [

	self errorHandler
		evaluate: [
			| method |
			method := self selectedObject compileMethod: aText notifying: someone.  self changed.
			self selectedObjectMethod: method.
			]
]

{ #category : #accessing }
ObjectBrowser >> compileTest: aText [ 
	self errorHandler
		evaluate: [	self selectedTest: (self lesson compileTest: aText).
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
		evaluate: [variableName := self request: 'Nombre de la referencia' default: ''.
			variableName ifNotNil: [self validateVariableName: variableName usingExistingVariables: self selectedObject variables  .self selectedObject addVariable: variableName]]).
	self changed
]

{ #category : #showing }
ObjectBrowser >> createBag [
	self createCollection: bag.
]

{ #category : #showing }
ObjectBrowser >> createCollection: type [
		self createObject: [:collectionName |  
			self createVariable: collectionName referencingTo: (ObjectBrowserCollection newWithRealObject: type clone) 
			].
	

]

{ #category : #showing }
ObjectBrowser >> createDictionary [  
	self createCollection: dictionary.
]

{ #category : #showing }
ObjectBrowser >> createObject [
	self createObject: [:objectName | self createVariable: objectName].
]

{ #category : #showing }
ObjectBrowser >> createObject: creationBlock [
	self errorHandler evaluate: [creationBlock value: self obtainObjectName].
	self changed.
]

{ #category : #showing }
ObjectBrowser >> createOrdered [
	self createCollection: ordered.
]

{ #category : #showing }
ObjectBrowser >> createSet [
	self createCollection: set.
]

{ #category : #showing }
ObjectBrowser >> createSorted [ 
	self createCollection: sorted.
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

{ #category : #'as yet unclassified' }
ObjectBrowser >> createVariable: aVariableNameString toRecover: anObjectBrowserObject [
	| newVariable |
	self validateVariableName: aVariableNameString.
	
	newVariable := (LessonVariable newNamed: aVariableNameString)
		pointTo: anObjectBrowserObject;
		yourself.
	self lesson addVariableWithExistentObject: newVariable.
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
	^self createWorkspace: workspaceLabel contents: ''.
]

{ #category : #showing }
ObjectBrowser >> createWorkspace: workspaceLabel contents: someContents [
	| workspace |
	workspace := self lesson createWorkspace: workspaceLabel contents: someContents.
	self selectedItem: workspace.
	self changed.
	^workspace 
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> delete [
	window delete.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> deleteLessonVariable [
	self errorHandler
		evaluate: [
			self selectedObject
				ifNil: [self error: 'No hay ninguna referencia elegida'].
			self confirmDeletion ifTrue:[self doDeleteLessonVariable].
			].
	self selectedObjectBrowserVariable: NullLessonVariable new.
	self changed
]

{ #category : #deleting }
ObjectBrowser >> deleteMethod [
	self errorHandler evaluate: [self selectedObject removeMethod: self selectedObjectMethod ].
	self selectedObjectMethod: NullOBMethod new.
	self changed.
]

{ #category : #deleting }
ObjectBrowser >> deleteTest [
	self errorHandler evaluate: [self lesson removeTest: self selectedTest  ].
	self selectedTest: nil.
	self changed.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> deleteVariable [
	self errorHandler
		evaluate: [
			self selectedObjectAttribute
				ifNil: [self error: 'No hay ninguna variable elegida'].
			self confirmDeletion ifTrue:[self doDeleteVariable].
			].
	self changed.
	
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
ObjectBrowser >> doDeleteLessonVariable [
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

{ #category : #accessing }
ObjectBrowser >> exportDiagram [
	self lesson exportDiagram
]

{ #category : #accessing }
ObjectBrowser >> exportWorkspace [
	selectedWorkspace export
]

{ #category : #accessing }
ObjectBrowser >> fileInWorkspace [
	| fileName inStream contents ws |
	fileName := UIManager default chooseFileMatching: #('*.ws') label: 'Selecciona el workspace a importar'.
	fileName ifNotNil:[
		[	inStream := StandardFileStream fileNamed: fileName.
			contents := inStream upToEnd.
		] 
		ensure: [inStream close.].
		ws := self createWorkspace: (fileName subStrings: '.') first contents: contents
	]
]

{ #category : #showing }
ObjectBrowser >> garbageCollectorButtonLabel [
	^'Run Garbage Collector'
]

{ #category : #'initialize-release' }
ObjectBrowser >> initialize [
	super initialize.
	self selectedTabIndex: 1.
	self selectedObjectBrowserVariable: NullLessonVariable new.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> isDiagramSelected [ 
	"Está hardcodeado el índice 3 para el diagrama..."
	^self selectedTabIndex = 3
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
		"with: (OBListItemWrapper with: (TestsOrganization for: self))"
		with: (OBListItemWrapper with: (RecicleBinOrganization for: self))
		with: (OBListItemWrapper with: (DiagramOrganization for: self))
		]
]

{ #category : #menues }
ObjectBrowser >> methodListMenu: aMenu shifted: shifted [
	aMenu addList: self selectedObjectMethod menuItems.
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
	"self selectedTabIndex:  1."
	selectedPage := #objects.
	self selectedObjectBrowserVariable: NullLessonVariable new.
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> obtainObjectName [
	| objectName |
	objectName := self request: 'Nombre de la referencia al objeto' default: 'nuevaReferencia'.
	objectName ifNil: [OperationCancelled new signal].
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
				self createVariable: variableName toRecover: self selectedDerreferencedObject realObject.
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
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> runAllTestsLabel [
	^'Probar Todos'
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> runGarbageCollector [
	self lesson runGarbageCollector.
	self changed .
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> selectDereferencedObject: aDerreferencedObject [
	selectedObjectAttribute := NullLessonVariable new.
	selectedObjectMethod := NullOBMethod new.
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
	selectedItem ifNotNil: [ selectedItem makeSelectionOn: self. ].
]

{ #category : #menues }
ObjectBrowser >> selectedItemMenu: aMenuMorph [ 
	^self selectedItem ifNotNil: [ :item | item menu: aMenuMorph]
]

{ #category : #accessing }
ObjectBrowser >> selectedMethodCode [
	"el codigo del metodo que esta seleccionado, Text vacio si no hay metodo seleccionado"

	^(self selectedObjectMethod isNil)
			ifTrue: [self selectorListEmpyText]
			ifFalse: [
				(self selectedObject sourceCodeAt: self selectedObjectMethod) ]
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
	selectedObjectMethod := NullOBMethod new.
	anOBVariable notifySelectionTo: self objectSelectionInterested.
	selectedPage := #objects.
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectMethod [
	^selectedObjectMethod
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectMethod: aMethod [
	selectedObjectMethod := aMethod.
	self changed.
]

{ #category : #accessing }
ObjectBrowser >> selectedObjectMethods [
	^self selectedObject methods" collect: [ :m | ShowingMethod object: self selectedObject method: m ]".
]

{ #category : #accessing }
ObjectBrowser >> selectedPage [
	^selectedPage ifNil: [ #objects ]
]

{ #category : #accessing }
ObjectBrowser >> selectedPage: aPageKey [
	selectedPage := aPageKey
]

{ #category : #accessing }
ObjectBrowser >> selectedTabIndex [
	^ selectedTabIndex ifNil: [1].
]

{ #category : #accessing }
ObjectBrowser >> selectedTabIndex: anObject [
	selectedTabIndex := anObject
]

{ #category : #accessing }
ObjectBrowser >> selectedTest [
	self lesson tests notEmpty & selectedTest ifNil: [ self selectedTest: self lesson tests asOrderedCollection first ].
	^selectedTest
]

{ #category : #accessing }
ObjectBrowser >> selectedTest: aTest [
	selectedTest := aTest.
	self changed.
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

{ #category : #accessing }
ObjectBrowser >> subMenuCollections [
	| menuCrearColeccion |
	self deprecated: 'esta en ObjectsOrganization'.
	menuCrearColeccion := MenuMorph new target: self; yourself .
	menuCrearColeccion add:'set' action: #createSet.
	menuCrearColeccion add:'bag' action: #createBag.
	menuCrearColeccion add:'ordered' action: #createOrdered.
	^menuCrearColeccion.
	
]

{ #category : #accessing }
ObjectBrowser >> subMenuCollectionsName [
self deprecated: 'esta en ObjectsOrganization'.
	^'Crear nuevo conjunto'
]

{ #category : #menues }
ObjectBrowser >> testListMenu: aMenu shifted: aBoolean [ 
	aMenu addList: #(
		('borrar test'			deleteTest)).
	^ aMenu
]

{ #category : #menues }
ObjectBrowser >> tests [
	^self lesson tests
]

{ #category : #menues }
ObjectBrowser >> testsOrganizationSelected [
	self selectedObjectBrowserVariable: NullLessonVariable new.
	selectedPage := #tests.
	self changed.
	
]

{ #category : #showing }
ObjectBrowser >> title [
	 ^self lesson title
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> validateVariableName: aVariableNameString [
	self validateVariableName: aVariableNameString  usingExistingVariables: self variables .
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> validateVariableName: aVariableNameString usingExistingVariables: variables [
	(aVariableNameString isNil or: [aVariableNameString isEmpty])
		ifTrue:[ self error: 'El nombre de la variable no debe ser vacío' ].
	(aVariableNameString matchesRegex: '[a-z]+([a-z]|[A-Z]|[0-9])*')
		ifFalse:[ self error: 'El nombre de la variable no puede contener espacios ni carácteres extraños, y debe empezar con minúscula' ].
	(variables anySatisfy: [:v | v name = aVariableNameString ])
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
