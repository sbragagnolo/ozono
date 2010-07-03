Class {
	#name : #ObjectBrowserModel,
	#superclass : #Object,
	#instVars : [
		'workspaceText',
		'selectedObject',
		'selectedSelector',
		'selectedVariable',
		'objectBrowser'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserModel class >> newWithOB: anOB [
	^self new objectBrowser: anOB;
		yourself
]

{ #category : #model }
ObjectBrowserModel >> assertDeletionConfirmed [
	^UIManager default confirm: '¿Seguro que quiere eliminar el método?'
]

{ #category : #model }
ObjectBrowserModel >> assertMethodSelected [
	self selectedSelector ifNil: [self error: 'Hay que elegir el método a borrar'].
]

{ #category : #model }
ObjectBrowserModel >> assertObjectSelected [
	self selectedObjectAttribute isNil ifTrue:[self error: 'debe seleccionar un objeto a eliminar']
]

{ #category : #model }
ObjectBrowserModel >> bindingOf: aString [ 
	self error: 'deprecado'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> compileMethod: aText [ 
	self errorHandler
		evaluate: [	self selectedObject compileMethod: aText.
					self changed]
]

{ #category : #model }
ObjectBrowserModel >> createAttribute [
	| variableName |
	(self errorHandler
		evaluate: [variableName := self request: 'Nombre de la variable' default: ''.
			self selectedObject addVariable: variableName]).
	self changed
]

{ #category : #model }
ObjectBrowserModel >> createObject [
	| objectName |
	(self errorHandler
		evaluate: [objectName := self obtenerNombreDeObjeto.
			objectBrowser createVariable: objectName]).
	self changed
]

{ #category : #model }
ObjectBrowserModel >> createSet [
	| objectName |
	(self errorHandler
		evaluate: [objectName := self obtenerNombreDeObjeto.
			objectBrowser createSet: objectName]).
	self changed
]

{ #category : #model }
ObjectBrowserModel >> deleteMethod [
	self errorHandler
		evaluate: [self assertMethodSelected.
			self deletionConfirmed
				ifTrue: [self doDeleteMethod]].
	self changed.
]

{ #category : #model }
ObjectBrowserModel >> deleteVariable [
	self errorHandler
		evaluate: [
			self selectedObjectAttribute
				ifNil: [self error: 'No hay ninguna variable elegida'].
			self doDeleteVariable.
			].
	self changed
]

{ #category : #model }
ObjectBrowserModel >> deletionConfirmed [
	^UIManager default confirm: '¿Seguro que quiere eliminar?'
]

{ #category : #model }
ObjectBrowserModel >> deselectObject [
	self selectedObject: self nullObjectBrowserObject.
]

{ #category : #model }
ObjectBrowserModel >> deselectSelector [
	self selectedSelector: nil.
]

{ #category : #model }
ObjectBrowserModel >> deselectVariables [
	self selectedVariable: nil.
]

{ #category : #model }
ObjectBrowserModel >> doDeleteMethod [
	self selectedObject removeMethod: self selectedSelector.
	self deselectSelector
]

{ #category : #model }
ObjectBrowserModel >> doDeleteObject [
	self selectedObject removeFromSystem.
	self deselectObject.
	self deselectVariables.
	self deselectSelector.
]

{ #category : #model }
ObjectBrowserModel >> doDeleteVariable. [
	self selectedObject removeVariable: self selectedObjectAttribute.
	self deselectVariables 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> errorHandler [
	^ErrorHandler default
]

{ #category : #model }
ObjectBrowserModel >> garbageCollectorButtonLabel [
	^'Run Garbage Collector'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> initialize [
	super initialize.
	self selectedObjectBrowserVariable: NullOBVariable new.
]

{ #category : #model }
ObjectBrowserModel >> methods [
	 ^self selectedObject methods
]

{ #category : #model }
ObjectBrowserModel >> nullObjectBrowserObject [
	^NullObjectBrowserObject new
]

{ #category : #binding }
ObjectBrowserModel >> objectBindings [
	|bindings|
	bindings := Dictionary new.
	objectBrowser variables do:[:var |
		bindings at: var name put: var pointsTo ].
	^bindings 
]

{ #category : #accessing }
ObjectBrowserModel >> objectBrowser [
	^ objectBrowser
]

{ #category : #accessing }
ObjectBrowserModel >> objectBrowser: anObject [
	objectBrowser := anObject
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> objectBrowserVariables [
	^self objectBrowser variables.
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> objects [
	^self objectBrowser objects.
]

{ #category : #model }
ObjectBrowserModel >> obtenerNombreDeObjeto [
	| objectName |
	objectName := self request: 'Nombre del objeto' default: 'nuevo objeto'.
	^ objectName
]

{ #category : #model }
ObjectBrowserModel >> removeFromSystem: anObjectBrowserObject [
	anObjectBrowserObject removeFromSystem
]

{ #category : #view }
ObjectBrowserModel >> request: aTitle default: aDefaultValue [
	^ UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #model }
ObjectBrowserModel >> runGarbageCollector [
	self objectBrowser runGarbageCollector.
]

{ #category : #accessing }
ObjectBrowserModel >> selectedClass [
	^ self selectedObject realClass
]

{ #category : #accessing }
ObjectBrowserModel >> selectedObject [
	^self selectedObjectBrowserVariable pointsTo
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectAttribute [
	^selectedVariable 
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectAttribute: anOBVariable [
	selectedVariable  := anOBVariable.
	self changed.
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectAttributes [
	^self selectedObject variables
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectBrowserVariable [
	^selectedObjectBrowserVariable
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectBrowserVariable: anOBVariable [
	selectedObjectBrowserVariable  := anOBVariable.
	selectedVariable := NullOBVariable new.
	selectedSelector := NullOBMethod new.
	self changed.
]

{ #category : #accessing }
ObjectBrowserModel >> selectedSelector [
	^ selectedSelector
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedSelector: aSelector [
	selectedSelector := aSelector.
	self changed.
]

{ #category : #accessing }
ObjectBrowserModel >> selectedSelectorCode [
	"el codigo del metodo que esta seleccionado, Text vacio si no hay metodo seleccionado"

	^(self selectedSelector isNil)
			ifTrue: [self selectorListEmpyText]
			ifFalse: [
				(self selectedObject sourceCodeAt: self selectedSelector) ]
]

{ #category : #view }
ObjectBrowserModel >> selectorListEmpyText [
| string|

	string := 'messageSelectorAndArgumentNames
	"comment stating purpose of message"

	| temporary variable names |
	statements'.

	^ (Text fromString: string) makeSelectorBold 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> showObjectGraph [
	self objectBrowser showObjectGraph
]

{ #category : #accessing }
ObjectBrowserModel >> variables [
	 ^self selectedObjectBrowserVariable pointsTo variables.
]
