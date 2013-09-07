Class {
	#name : #NullObjectBrowserObject,
	#superclass : #Object,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'ui-actions' }
NullObjectBrowserObject >> actionsForAttributeListWith: selectedAttribute [
	^#()
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> actionsForObjectVariableList [
	^#(#('eliminar' #deleteLessonVariable))
]

{ #category : #references }
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

{ #category : #methods }
NullObjectBrowserObject >> compileMethod: aText notifying: someone [
	^self error: 'Debe seleccionar un objeto para este metodo'.
]

{ #category : #methods }
NullObjectBrowserObject >> hasMethod: aSelector [
	^false
]

{ #category : #testing }
NullObjectBrowserObject >> isNil [
	^true
]

{ #category : #menu }
NullObjectBrowserObject >> menu: aMenuMorph [ 
	^aMenuMorph
]

{ #category : #methods }
NullObjectBrowserObject >> methods [
	^ OrderedCollection new
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> realObjectVariables [
	^OrderedCollection new
]

{ #category : #'pharo-interaction' }
NullObjectBrowserObject >> removeFromSystem [
	"do nothing"
	^self
]

{ #category : #methods }
NullObjectBrowserObject >> sourceCodeAt: aSelector [ 
	^''
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> variables [
	^OrderedCollection new
]

{ #category : #exporting }
NullObjectBrowserObject >> writeCloneScriptOn: aWriteStream for: anObjectBrowserObject lesson: aLOOPLesson [ 
	"Un null ob onject no tiene prototipo"
]
