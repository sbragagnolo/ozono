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
	#classVars : [
		'Objects'
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
	self selectedObject isNil ifTrue:[self error: 'debe seleccionar un objeto a eliminar']
]

{ #category : #model }
ObjectBrowserModel >> bindingOf: aString [ 
	| obo |
	obo := self objects
				detect: [:anOBO | anOBO objectName = aString]
				ifNone: [self error: 'No existe el objeto ', aString].
	^ aString -> obo
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> compileMethod: aText notifying: someone [
	self errorHandler
		evaluate: [self selectedObject compileMethod: aText notifying: someone.
			self changed]
]

{ #category : #model }
ObjectBrowserModel >> createClone [
	| objectName |
	(self errorHandler
		evaluate: [objectName := self obtenerNombreDeObjeto.
			self selectedObject cloneWithName: objectName]).
	self changed
]

{ #category : #model }
ObjectBrowserModel >> createObject [
	| objectName |
	(self errorHandler
		evaluate: [objectName := self obtenerNombreDeObjeto.
			objectBrowser createObject: objectName]).
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
ObjectBrowserModel >> createVariable [
	| variableName |
	(self errorHandler
		evaluate: [variableName := self request: 'Nombre de la variable' default: ''.
			self selectedObject addVariable: variableName]).
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
ObjectBrowserModel >> deleteObject [
	self errorHandler evaluate: [
			self assertObjectSelected.
			self deletionConfirmed
				ifTrue: [self doDeleteObject].
		]
]

{ #category : #model }
ObjectBrowserModel >> deleteVariable [
	self errorHandler
		evaluate: [
			self selectedVariable
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
	self selectedObject removeVariable: self selectedVariable.
	self deselectVariables 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> errorHandler [
	^ErrorHandler default
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> initialize [
	super initialize.
	self selectedObject: self nullObjectBrowserObject 
]

{ #category : #model }
ObjectBrowserModel >> methods [
 ^self selectedObject methods
]

{ #category : #model }
ObjectBrowserModel >> nullObjectBrowserObject [
	^NullObjectBrowserObject new
]

{ #category : #accessing }
ObjectBrowserModel >> objectBrowser [
	^ objectBrowser
]

{ #category : #accessing }
ObjectBrowserModel >> objectBrowser: anObject [
	objectBrowser := anObject
]

{ #category : #accessing }
ObjectBrowserModel >> objectNames [
	^self objects collect: [:obj | obj objectName]
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> objects [
	^self objectBrowser objects.
]

{ #category : #model }
ObjectBrowserModel >> obtenerNombreDeArchivo [
	^UIManager default chooseFileMatching: #(st)
]

{ #category : #model }
ObjectBrowserModel >> obtenerNombreDeObjeto [
	| objectName |
	objectName := self request: 'Nombre del objeto' default: 'nuevo objeto'.
	objectName notEmpty ifTrue: 
		[ objectName first isUppercase
			ifTrue: [^ self error: 'Los nombres de los objetos deben ir en minúsculas.'].
		 (objectName indexOf: $ ) > 0
			ifTrue: [^ self error: 'Los nombres de los objetos no pueden tener espacios.'].
		 (self objectNames includes: objectName)
			ifTrue: [^ self error: 'Ya hay un objeto con ese nombre.'].
		].
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

{ #category : #accessing }
ObjectBrowserModel >> selectedClass [
	^ self selectedObject realClass
]

{ #category : #accessing }
ObjectBrowserModel >> selectedObject [
	^ selectedObject
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObject: anObjectBrowserObject [ 
	selectedObject := anObjectBrowserObject.
	selectedVariable := nil.
	selectedSelector := nil.
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

{ #category : #accessing }
ObjectBrowserModel >> selectedVariable [
	^ selectedVariable 
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedVariable: aVariableName [
	selectedVariable := aVariableName.
	self changed.
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
 ^self selectedObject variables
]
