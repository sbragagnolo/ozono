Class {
	#name : #ObjectBrowser,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'selectedObjectBrowserVariable',
		'selectedObjectBrowserSelector',
		'selectedObjectAttribute',
		'selectedObjectSelector'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #creation }
ObjectBrowser class >> onLesson: aLOOPLesson [ 
	^self new lesson: aLOOPLesson;
		yourself.
]

{ #category : #'as yet unclassified' }
ObjectBrowser class >> open [
	^self new openInWorld; yourself
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

{ #category : #ObjectBrowser }
ObjectBrowser >> canDelete: anObjectBrowserObject [

	^self objects allSatisfy: [ :anOBObject | (anOBObject hasReferencesTo: anObjectBrowserObject) not ]
]

{ #category : #accessing }
ObjectBrowser >> compileMethod: aText [ 
	self errorHandler
		evaluate: [	self selectedObject compileMethod: aText.
					self changed]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createAttribute [
	| variableName |
	(self errorHandler
		evaluate: [variableName := self request: 'Nombre de la variable' default: ''.
			self selectedObject addVariable: variableName]).
	self changed
]

{ #category : #showing }
ObjectBrowser >> createObject [
	| objectName |
	(self errorHandler
		evaluate: [objectName := self obtenerNombreDeObjeto.
			self createVariable: objectName]).
	self changed
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createVariable: aVariableNameString [
	self createVariable: aVariableNameString  referencingTo: ObjectBrowserObject new
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createVariable: aVariableNameString referencingTo: anObjectBrowserObject [
	| newVariable |
	self validateVariableName: aVariableNameString.
	
	newVariable := (OBVariable new)
		name: aVariableNameString;
		originalName: aVariableNameString;
		pointTo: anObjectBrowserObject;
		yourself.
	self lesson addVariable: newVariable.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> deleteVariable [
	self errorHandler
		evaluate: [
			self selectedObjectAttribute
				ifNil: [self error: 'No hay ninguna variable elegida'].
			self doDeleteVariable.
			].
	self changed
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> deselectVariables [
	self selectedObjectAttribute: NullOBVariable new.
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
	self selectedObjectBrowserVariable: NullOBVariable new.
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

{ #category : #ObjectBrowser }
ObjectBrowser >> objectBrowserVariables [
	^self lesson variables
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> objectNames [
	^self objects collect:[:each | each name]
]

{ #category : #ObjectBrowser }
ObjectBrowser >> objects [
	^self lesson objects
]

{ #category : #accessing }
ObjectBrowser >> obtenerNombreDeObjeto [
	| objectName |
	objectName := self request: 'Nombre del objeto' default: 'nuevo objeto'.
	^ objectName
]

{ #category : #'initialize-release' }
ObjectBrowser >> openInWorld [
	ObjectBrowserWindow show: self.

	
]

{ #category : #model }
ObjectBrowser >> removeObject: anObject [
	self objects remove: anObject.
]

{ #category : #accessing }
ObjectBrowser >> renameAttribute [
	| attributeName |
	(self errorHandler
		evaluate: [attributeName := self request: 'Nombre de la variable' default: self selectedObjectAttribute  name.
			self selectedObjectAttribute renameAs: attributeName]).
	self changed
]

{ #category : #accessing }
ObjectBrowser >> request: aTitle default: aDefaultValue [
	^ UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> runGarbageCollector [
	self lesson runGarbageCollector.
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
	selectedObjectAttribute := NullOBVariable new.
	selectedObjectSelector := NullOBMethod new.
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
