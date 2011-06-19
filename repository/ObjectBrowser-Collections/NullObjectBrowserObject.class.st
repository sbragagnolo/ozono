Class {
	#name : #NullObjectBrowserObject,
	#superclass : #Object,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> actionsForAttributeListWith: selectedAttribute [
	^#()
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> actionsForObjectVariableList [
	^#(#('eliminar' #deleteObject))
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> addInversePrototypeRelationship: referencesCollection [
	"El NullObjectBrowserObject no debe agregarse a la coleccion de objetos"
	^self
]

{ #category : #'graph model' }
NullObjectBrowserObject >> addPrototypeRelationshipTo: anObjectBrowserObject in: aLessonGraph [ 
	"Nothing"
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> addVariable: variableName [
	self error: 'Debe seleccionar un objeto para crear una variable'.
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> canDelete [
	^true
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> compileMethod: aText notifying: someone [
	^self error: 'Debe seleccionar un objeto para este metodo'.
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> hasMethod: aSelector [
	^false
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> isNil [
	^true
]

{ #category : #menu }
NullObjectBrowserObject >> menu: aMenuMorph [ 
	^aMenuMorph
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> methods [
	^ OrderedCollection new
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> removeFromSystem [
	"do nothing"
	^self
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> sourceCodeAt: aSelector [ 
	^''
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> variables [
	^OrderedCollection new
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> writeCloneScriptOn: aWriteStream for: anObjectBrowserObject lesson: aLOOPLesson [ 
	"Un null ob onject no tiene prototipo"
]
