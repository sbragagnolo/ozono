"
I am the model of the lesson in the lesson window.
"
Class {
	#name : #OBLessonModel,
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
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #creation }
OBLessonModel class >> onLesson: aLOOPLesson [ 
	^self new lesson: aLOOPLesson;
		yourself.
]

{ #category : #accessing }
OBLessonModel >> actionsForAttributeListWith: selectedAttribute [
	^self selectedObject actionsForAttributeListWith: selectedAttribute
]

{ #category : #accessing }
OBLessonModel >> actionsForObjectBrowserReferencesList [
	^(OrderedCollection with: #('crear nuevo objeto' #createObject))
		addAll: self selectedObject actionsForObjectBrowserReferencesList;
		asArray.
]

{ #category : #'dependents access' }
OBLessonModel >> addObjectSelectionInterested: anInterested [
	self objectSelectionInterested add: anInterested
]

{ #category : #'dependents access' }
OBLessonModel >> addTestSelectionInterested: anInterested [
"	anInterested classOrMetaClass:  self lesson loopExecutionContextClass"
]

{ #category : #menues }
OBLessonModel >> attributeListMenu: aMenu shifted: shifted [
	^aMenu addList: (self actionsForAttributeListWith: self selectedObjectAttribute)
]

{ #category : #ObjectBrowser }
OBLessonModel >> changed [
	super changed.
	self dependants do: [ :d | d refresh ].
]

{ #category : #showing }
OBLessonModel >> cloneObject [
		self createObject: [:objectName | 
			self createVariable: objectName referencingTo: (self selectedObjectBrowserVariable pointsTo clone)
			].
]

{ #category : #'as yet unclassified' }
OBLessonModel >> closeWorkspaces [
 	self workspaces do:[:wk | wk closeYourself].
]

{ #category : #accessing }
OBLessonModel >> compileMethod: aText notifying: someone [

	| method |
	method := self selectedObject compileMethod: aText notifying: someone.
	self changed.
	self selectedObjectMethod: method.
]

{ #category : #accessing }
OBLessonModel >> compileTest: aText notifying: someone [
	self selectedTest: (self lesson compileTest: aText notifying: someone).
	self changed
]

{ #category : #'as yet unclassified' }
OBLessonModel >> confirmDeletion [ 
	^UIManager default confirm: '¿Esta seguro de eliminar la referencia a este objeto?  El objeto aparecerá en la papelera si no tiene referencias' trueChoice: 'Si' falseChoice: 'No' .
]

{ #category : #'as yet unclassified' }
OBLessonModel >> createAttribute [
	| variableName |
	self errorHandler
		evaluate: [ 
			variableName := self request: '¿Qué nombre deseas ponerle a este nuevo atributo?' default: ''.
			variableName
				ifNotNil: [ 
					self validateVariableName: variableName usingExistingVariables: self selectedObject attributes.
					self selectedObject addAttributeNamed: variableName ] ].
	self changed
]

{ #category : #showing }
OBLessonModel >> createBag [
	self createCollection: (lesson literalNamed: #bag).
]

{ #category : #showing }
OBLessonModel >> createCollection: aCollectionFactory [

	self createObject: [ :collectionName | | realClone obClone |
		realClone := aCollectionFactory clone.
		obClone := realClone metaObject.
		self 
			createVariable: collectionName 
			referencingTo: obClone ]
]

{ #category : #showing }
OBLessonModel >> createDictionary [  
	self createCollection: (lesson literalNamed: #dictionary).
]

{ #category : #showing }
OBLessonModel >> createObject [
	self createObject: [:objectName | self createVariable: objectName].
]

{ #category : #showing }
OBLessonModel >> createObject: creationBlock [
	self errorHandler evaluate: [creationBlock value: self obtainObjectName].
	self changed.
]

{ #category : #showing }
OBLessonModel >> createOrdered [
	self createCollection: (lesson literalNamed: #ordered).
]

{ #category : #showing }
OBLessonModel >> createSet [
	self createCollection: (lesson literalNamed: #set).
]

{ #category : #showing }
OBLessonModel >> createSorted [ 
	self createCollection: (lesson literalNamed: #sorted).
]

{ #category : #menues }
OBLessonModel >> createTest: testLabel contents: someContents [
	| testCase |
	testCase := self lesson compileTest: someContents notifying: nil.
	self selectedItem: testCase.
	self changed.
	^testCase
]

{ #category : #'as yet unclassified' }
OBLessonModel >> createVariable: aVariableNameString [
	self createVariable: aVariableNameString  referencingTo: self lesson createObject.
]

{ #category : #'as yet unclassified' }
OBLessonModel >> createVariable: aVariableNameString referencingTo: anObject [

	| newVariable |
	self validateVariableName: aVariableNameString.
	
	newVariable := self lesson
							createVariableNamed: aVariableNameString
							pointingTo: anObject.
	self selectedItem: newVariable.
]

{ #category : #'as yet unclassified' }
OBLessonModel >> createVariable: aVariableNameString toRecover: anObject [

	self createVariable: aVariableNameString referencingTo: anObject
]

{ #category : #showing }
OBLessonModel >> createWorkspace [
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
OBLessonModel >> createWorkspace: workspaceLabel [
	^self createWorkspace: workspaceLabel contents: ''.
]

{ #category : #showing }
OBLessonModel >> createWorkspace: workspaceLabel contents: someContents [
	| workspace |
	workspace := self lesson createWorkspace: workspaceLabel contents: someContents.
	self selectedItem: workspace.
	self changed.
	^workspace 
]

{ #category : #'as yet unclassified' }
OBLessonModel >> delete [
	window delete.
]

{ #category : #'as yet unclassified' }
OBLessonModel >> deleteLessonVariable [
	self errorHandler
		evaluate: [
			self selectedObject
				ifNil: [self error: 'No hay ninguna referencia elegida'].
			self confirmDeletion ifTrue: [
				self doDeleteLessonVariable.
				self selectedObjectBrowserVariable: OBNullLessonVariable new.
				].
			].
	self changed
]

{ #category : #deleting }
OBLessonModel >> deleteMethod [
	self errorHandler evaluate: [self selectedObject removeMethod: self selectedObjectMethod ].
	self selectedObjectMethod: OBNullMethod new.
	self changed.
]

{ #category : #deleting }
OBLessonModel >> deleteTest [
	self errorHandler evaluate: [self lesson removeTest: self selectedTest  ].
	self selectedTest: nil.
	self changed.
]

{ #category : #'as yet unclassified' }
OBLessonModel >> deleteVariable [
	self errorHandler
		evaluate: [
			self selectedObjectAttribute
				ifNil: [self error: 'No hay ninguna variable elegida'].
			self confirmDeletion ifTrue:[self doDeleteVariable].
			].
	self changed.
	
]

{ #category : #ObjectBrowser }
OBLessonModel >> dependant: aDependant [
	self dependants add: aDependant.
]

{ #category : #ObjectBrowser }
OBLessonModel >> dependants [
	^dependants ifNil: [ dependants := Set new].
]

{ #category : #accessing }
OBLessonModel >> dereferenceSelectedVariable [
	self selectedObjectBrowserVariable desreference.
	self selectDereferencedObject: self selectedObjectBrowserVariable.
	self changed .
]

{ #category : #'as yet unclassified' }
OBLessonModel >> deselectVariables [
	self selectedObjectAttribute: OBNullLessonVariable new.
]

{ #category : #'as yet unclassified' }
OBLessonModel >> doDeleteLessonVariable [
	self lesson removeVariable: self selectedObjectBrowserVariable .
]

{ #category : #'as yet unclassified' }
OBLessonModel >> doDeleteVariable [
	self selectedObject removeAttribute: self selectedObjectAttribute.
	self deselectVariables 
	
]

{ #category : #accessing }
OBLessonModel >> errorHandler [
	^OBErrorHandler default
]

{ #category : #accessing }
OBLessonModel >> exportDiagram [
	self lesson exportDiagram
]

{ #category : #export }
OBLessonModel >> exportTest [
	self selectedTest fileOut.
]

{ #category : #accessing }
OBLessonModel >> exportWorkspace [
	selectedWorkspace export
]

{ #category : #accessing }
OBLessonModel >> fileInTests [
	| fileName inStream contents st |
	fileName := UIManager default chooseFileMatching: #('*.st') label: 'Selecciona el test a importar'.
	fileName ifNotNil:[
		[	inStream := StandardFileStream fileNamed: fileName.
			contents := inStream upToEnd.
		] 
		ensure: [inStream close.].
		st := self createTest: (fileName subStrings: '.') first contents: contents
	]
]

{ #category : #accessing }
OBLessonModel >> fileInWorkspace [
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
OBLessonModel >> garbageCollectorButtonLabel [
	^'Run Garbage Collector'
]

{ #category : #'initialize-release' }
OBLessonModel >> initialize [
	super initialize.
	self selectedTabIndex: 1.
	self selectedObjectBrowserVariable: OBNullLessonVariable new.
]

{ #category : #'as yet unclassified' }
OBLessonModel >> isDiagramSelected [ 
	"Está hardcodeado el índice 3 para el diagrama..."
	^self selectedTabIndex = 3
]

{ #category : #'as yet unclassified' }
OBLessonModel >> lesson [
	^lesson
]

{ #category : #accessing }
OBLessonModel >> lesson: aLOOPLesson [ 
	lesson := aLOOPLesson.
]

{ #category : #accessing }
OBLessonModel >> lessonOrganization [
	^organization ifNil: [ organization := OrderedCollection 
		with: (OBListItemWrapper with: (OBObjectsTreeMenuNode for: self))
		with: (OBListItemWrapper with: (OBWorkspacesTreeMenuNode for: self))
		with: (OBListItemWrapper with: (OBTestsTreeMenuNode for: self))
		with: (OBListItemWrapper with: (OBRecycleBinTreeMenuNode for: self))
		with: (OBListItemWrapper with: (OBDiagramTreeMenuNode for: self))
		]
]

{ #category : #menues }
OBLessonModel >> methodListMenu: aMenu shifted: shifted [
	aMenu addList: self selectedObjectMethod menuItems.
	^ aMenu
]

{ #category : #ObjectBrowser }
OBLessonModel >> objectBrowserVariables [
	^self lesson variables
]

{ #category : #'as yet unclassified' }
OBLessonModel >> objectNames [
	^self objects collect:[:each | each name]
]

{ #category : #'dependents access' }
OBLessonModel >> objectSelectionInterested [
	^objectSelectionInterested ifNil: [ objectSelectionInterested := Set new ]
]

{ #category : #ObjectBrowser }
OBLessonModel >> objects [
	^self lesson objects
]

{ #category : #accessing }
OBLessonModel >> objectsOrganizationSelected [
	"self selectedTabIndex:  1."
	selectedPage := #objects.
	self selectedObjectBrowserVariable: OBNullLessonVariable new.
	self changed.
]

{ #category : #accessing }
OBLessonModel >> obtainObjectName [
	| objectName |
	objectName := self request: 'Nombre de la referencia al objeto' default: 'nuevaReferencia'.
	objectName ifNil: [OBOperationCancelled new signal].
	self validateVariableName: objectName.
	^ objectName
]

{ #category : #showing }
OBLessonModel >> obtainWorkpaceLabel [
	^self request: 'Nombre del workspace' default: 'nuevoWorkspace'.
]

{ #category : #'initialize-release' }
OBLessonModel >> openInWorld [
	window := OBLessonWindow show: self.
	
]

{ #category : #showing }
OBLessonModel >> openWorkspace [
	self selectedItem openInWorld
]

{ #category : #menues }
OBLessonModel >> orphanObjects [
	^(self lesson dereferencedObjects) collect: [ :o | OBDereferencedObject newOn: o].
]

{ #category : #'as yet unclassified' }
OBLessonModel >> recoverObject [
	| variableName |
	(self errorHandler
		evaluate: [
			variableName := self request: 'Nombre de la referencia' default: 'recuperadoDeLaPapelera'.
			variableName ifNotNil: [ 
				self createVariable: variableName toRecover: self selectedDerreferencedObject baseObject.
				]
		]).
	self changed
]

{ #category : #model }
OBLessonModel >> removeObject: anObject [
	self objects remove: anObject.
]

{ #category : #showing }
OBLessonModel >> removeWorkspace [
	self confirmDeletion ifTrue: [self workspaces remove: self selectedItem].
	self changed.
]

{ #category : #accessing }
OBLessonModel >> request: aTitle default: aDefaultValue [
	^ UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #testing }
OBLessonModel >> runAllTests [
	| results |
	results := self lesson runAllTests.
	(self dependants detect: [ :d | d isKindOf: OBLessonWindow ]) setTestsResults: results.
	self changed.
]

{ #category : #accessing }
OBLessonModel >> runAllTestsLabel [
	^'Probar Todos'
]

{ #category : #'as yet unclassified' }
OBLessonModel >> runGarbageCollector [
	self lesson runGarbageCollector.
	self changed .
]

{ #category : #'as yet unclassified' }
OBLessonModel >> runTest [
	self selectedTest run.
	self changed.
]

{ #category : #'as yet unclassified' }
OBLessonModel >> selectDereferencedObject: aDerreferencedObject [
	selectedObjectAttribute := OBNullLessonVariable new.
	selectedObjectMethod := OBNullMethod new.
	selectedDerreferencedObject := aDerreferencedObject .
	self changed.
]

{ #category : #accessing }
OBLessonModel >> selectedDerreferencedObject [
	^selectedDerreferencedObject  .
]

{ #category : #accessing }
OBLessonModel >> selectedItem [
	^selectedItem
]

{ #category : #accessing }
OBLessonModel >> selectedItem: anItem [
	selectedItem := anItem.
	selectedItem ifNotNil: [ selectedItem makeSelectionOn: self. ].
]

{ #category : #menues }
OBLessonModel >> selectedItemMenu: aMenuMorph [ 
	^self selectedItem ifNotNil: [ :item | item menu: aMenuMorph]
]

{ #category : #accessing }
OBLessonModel >> selectedMethodCode [
	"el codigo del metodo que esta seleccionado, Text vacio si no hay metodo seleccionado"

	^self selectedObjectMethod code.
]

{ #category : #accessing }
OBLessonModel >> selectedObject [
	^self selectedObjectBrowserVariable pointsTo
]

{ #category : #accessing }
OBLessonModel >> selectedObjectAttribute [
	^selectedObjectAttribute
]

{ #category : #accessing }
OBLessonModel >> selectedObjectAttribute: anAttribute [
	selectedObjectAttribute := anAttribute.
	self changed.
]

{ #category : #accessing }
OBLessonModel >> selectedObjectAttributes [
	^self selectedObject attributes
]

{ #category : #accessing }
OBLessonModel >> selectedObjectBrowserVariable [
	^selectedObjectBrowserVariable
]

{ #category : #selection }
OBLessonModel >> selectedObjectBrowserVariable: anOBVariable [

	selectedObjectBrowserVariable  := anOBVariable.
	selectedObjectAttribute := OBNullLessonVariable new.
	selectedObjectMethod := OBNullMethod new.
	anOBVariable notifySelectionTo: self objectSelectionInterested.
	selectedPage := #objects.
	self changed.
]

{ #category : #accessing }
OBLessonModel >> selectedObjectMethod [
	^selectedObjectMethod
]

{ #category : #accessing }
OBLessonModel >> selectedObjectMethod: aMethod [
	selectedObjectMethod := aMethod.
	self changed.
]

{ #category : #accessing }
OBLessonModel >> selectedObjectMethods [
	^self selectedObject methods" collect: [ :m | ShowingMethod object: self selectedObject method: m ]".
]

{ #category : #accessing }
OBLessonModel >> selectedPage [
	^selectedPage ifNil: [ #objects ]
]

{ #category : #accessing }
OBLessonModel >> selectedPage: aPageKey [
	selectedPage := aPageKey
]

{ #category : #accessing }
OBLessonModel >> selectedTabIndex [
	^ selectedTabIndex ifNil: [1].
]

{ #category : #accessing }
OBLessonModel >> selectedTabIndex: anObject [
	selectedTabIndex := anObject
]

{ #category : #accessing }
OBLessonModel >> selectedTest [
	self lesson tests notEmpty & selectedTest ifNil: [ self selectedTest: self lesson tests asOrderedCollection first ].
	^selectedTest
]

{ #category : #accessing }
OBLessonModel >> selectedTest: aTest [
	selectedTest := aTest.
	self changed.
]

{ #category : #accessing }
OBLessonModel >> selectedWorkspace: aWorkspace [
	selectedWorkspace := aWorkspace
]

{ #category : #accessing }
OBLessonModel >> subMenuCollections [
	| menuCrearColeccion |
	self deprecated: 'esta en ObjectsOrganization'.
	menuCrearColeccion := MenuMorph new target: self; yourself .
	menuCrearColeccion add:'set' action: #createSet.
	menuCrearColeccion add:'bag' action: #createBag.
	menuCrearColeccion add:'ordered' action: #createOrdered.
	^menuCrearColeccion.
	
]

{ #category : #accessing }
OBLessonModel >> subMenuCollectionsName [
self deprecated: 'esta en ObjectsOrganization'.
	^'Crear nuevo conjunto'
]

{ #category : #accessing }
OBLessonModel >> testCaseSelected: aTestCase [
	self selectedObjectBrowserVariable: OBNullLessonVariable new.
	self selectedTest: aTestCase.
]

{ #category : #menues }
OBLessonModel >> testListMenu: aMenu shifted: aBoolean [ 
	aMenu addList: (OrderedCollection  with: (Array braceWith: 'borrar test' translated with: #deleteTest)
										 with: (Array braceWith: 'exportar' translated with: #exportTest)
										with: (Array braceWith: 'correr test' translated with: #runTest)) .

	^ aMenu
]

{ #category : #menues }
OBLessonModel >> tests [
	^self lesson tests
]

{ #category : #menues }
OBLessonModel >> testsOrganizationSelected [
	self selectedObjectBrowserVariable: OBNullLessonVariable new.
	selectedPage := #tests.
	self changed.
	
]

{ #category : #showing }
OBLessonModel >> title [
	 ^self lesson title
]

{ #category : #'as yet unclassified' }
OBLessonModel >> validateVariableName: aVariableNameString [
	self validateVariableName: aVariableNameString  usingExistingVariables: self variables .
]

{ #category : #'as yet unclassified' }
OBLessonModel >> validateVariableName: aVariableNameString usingExistingVariables: variables [
	(aVariableNameString isNil or: [aVariableNameString isEmpty])
		ifTrue:[ self error: 'El nombre de la variable no debe ser vacío'  translated ].
	(aVariableNameString matchesRegex: '[a-z]+([a-z]|[A-Z]|[0-9])*')
		ifFalse:[ self error: 'El nombre de la variable no puede contener espacios ni carácteres extraños, y debe empezar con minúscula' translated].
	(variables anySatisfy: [:v | v name = aVariableNameString ])
		ifTrue: [ self error: 'Ya se ha definido una variable de nombre ' translated, aVariableNameString  ]
]

{ #category : #'as yet unclassified' }
OBLessonModel >> variableNamed: aVariableNameString [
	^self lesson variableNamed: aVariableNameString.
]

{ #category : #ObjectBrowser }
OBLessonModel >> variables [
	^self lesson variables
]

{ #category : #accessing }
OBLessonModel >> workspaceSelected: aWorkspace [
	self selectedObjectBrowserVariable: OBNullLessonVariable new.
	self selectedWorkspace: aWorkspace.
]

{ #category : #menues }
OBLessonModel >> workspaces [
	^self lesson workspaces
]

{ #category : #selection }
OBLessonModel >> workspacesOrganizationSelected [
	self selectedObjectBrowserVariable: OBNullLessonVariable new.
]
