"
ESTA CLASE ESTA DEPRECADAAAAAAAAAAAAAAAAAAAAAAAA


ObjectBrowserModel has not been documented yet. The class comment should describe the purpose of the class, its collaborations and its variables.

Instance Variables:
	workspaceText	<ProtoObject | PseudoContext>
	selectedObject	<ProtoObject | PseudoContext>
	selectedSelector	<NullOBMethod>
	selectedVariable	<OBVariable>
	objectBrowser	<Object>
	selectedObjectBrowserVariable	<NullOBVariable | OBVariable>
	variableBindings	<Dictionary>
"
Class {
	#name : #ObjectBrowserModel,
	#superclass : #Object,
	#instVars : [
		'workspaceText',
		'selectedObject',
		'selectedSelector',
		'selectedVariable',
		'objectBrowser',
		'selectedObjectBrowserVariable',
		'variableBindings'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowserModel class >> newWithOB: anOB [
	^self new objectBrowser: anOB;
		yourself
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> actionsForAttributeListWith: selectedAttribute [
self deprecated: 'Use ObjectBrowser instead'
"	^self selectedObject actionsForAttributeListWith: selectedAttribute"
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> actionsForObjectVariableList [
self deprecated: 'Use ObjectBrowser instead'
"	^(OrderedCollection with: #('crear nuevo objeto' #createObject) with: #('crear nueva coleccion' #createCollection))
		addAll: self selectedObject actionsForObjectVariableList;
		asArray."
]

{ #category : #model }
ObjectBrowserModel >> assertDeletionConfirmed [
self deprecated: 'Use ObjectBrowser instead'
"	^UIManager default confirm: '¿Seguro que quiere eliminar el método?'"
]

{ #category : #model }
ObjectBrowserModel >> assertMethodSelected [
self deprecated: 'Use ObjectBrowser instead'
"	self selectedMethod ifNil: [self error: 'Hay que elegir el método a borrar']."
]

{ #category : #model }
ObjectBrowserModel >> assertObjectSelected [
self deprecated: 'Use ObjectBrowser instead'
"	self selectedObjectAttribute isNil ifTrue:[self error: 'debe seleccionar un objeto a eliminar']"
]

{ #category : #model }
ObjectBrowserModel >> bindingOf: aString [ 
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> cloneObject [
self deprecated: 'Use ObjectBrowser instead'
"	| objectName |
	(self errorHandler
		evaluate: [
			self assertObjectSelected.
			objectName := self obtainObjectName.
			objectBrowser createVariable: objectName referencingTo: self selectedObjectBrowserVariable pointsTo clone.
			self updateVariableBindings.]).
	self changed"
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> compileMethod: aText [ 
self deprecated: 'Use ObjectBrowser instead'
"	self errorHandler
		evaluate: [	self selectedObject compileMethod: aText.
					self changed]"
]

{ #category : #model }
ObjectBrowserModel >> createAttribute [
self deprecated: 'Use ObjectBrowser instead'
"	| variableName |
	(self errorHandler
		evaluate: [variableName := self request: 'Nombre de la variable' default: ''.
			self selectedObject addVariable: variableName]).
	self changed"
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> createCollection [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> createObject [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> createSet [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> deleteMethod [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> deleteVariable [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> deletionConfirmed [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> deselectObject [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> deselectSelector [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> deselectVariables [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> doDeleteMethod [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> doDeleteObject [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> doDeleteVariable [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> errorHandler [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> garbageCollectorButtonLabel [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> initialize [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> methods [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> nullObjectBrowserObject [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #binding }
ObjectBrowserModel >> objectBindings [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #accessing }
ObjectBrowserModel >> objectBrowser [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #accessing }
ObjectBrowserModel >> objectBrowser: anObject [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> objectBrowserVariables [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> objects [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> obtainCollectionType [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> obtenerNombreDeObjeto [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> removeFromSystem: anObjectBrowserObject [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> renameAttribute [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #view }
ObjectBrowserModel >> request: aTitle default: aDefaultValue [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #model }
ObjectBrowserModel >> runGarbageCollector [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #accessing }
ObjectBrowserModel >> selectedClass [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #accessing }
ObjectBrowserModel >> selectedMethod [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedMethod: aMethod [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #accessing }
ObjectBrowserModel >> selectedMethodCode [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #accessing }
ObjectBrowserModel >> selectedObject [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectAttribute [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectAttribute: anOBVariable [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectAttributes [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectBrowserVariable [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> selectedObjectBrowserVariable: anOBVariable [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #view }
ObjectBrowserModel >> selectorListEmpyText [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #'as yet unclassified' }
ObjectBrowserModel >> showObjectGraph [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #binding }
ObjectBrowserModel >> updateVariableBindings [ 
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #binding }
ObjectBrowserModel >> variableBindings [
self deprecated: 'Use ObjectBrowser instead'
]

{ #category : #accessing }
ObjectBrowserModel >> variables [
self deprecated: 'Use ObjectBrowser instead'
]
