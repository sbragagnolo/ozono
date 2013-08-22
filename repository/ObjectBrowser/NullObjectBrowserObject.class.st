Class {
	#name : #NullObjectBrowserObject,
	#superclass : #Object,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'ui-actions' }
NullObjectBrowserObject >> actionsForAttributeListWith: selectedAttribute [
	^#()
]

{ #category : #'ui-actions' }
NullObjectBrowserObject >> actionsForObjectBrowserReferencesList [
	^#(#('eliminar' #deleteLessonVariable))
]

{ #category : #attributes }
NullObjectBrowserObject >> addAttributeNamed: anAttributeName [
	self error: 'Debes seleccionar un objeto para crearle un atributo'.
]

{ #category : #references }
NullObjectBrowserObject >> addInversePrototypeRelationship: referencesCollection [
	"El NullObjectBrowserObject no debe agregarse a la coleccion de objetos"
	^self
]

{ #category : #graph }
NullObjectBrowserObject >> addPrototypeRelationshipTo: anObjectBrowserObject in: aLessonGraph [ 
	"Nothing"
]

{ #category : #attributes }
NullObjectBrowserObject >> allAttributeNames [
	^OrderedCollection new
]

{ #category : #attributes }
NullObjectBrowserObject >> attributes [
	
	^ #()
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

{ #category : #'ui-actions' }
NullObjectBrowserObject >> menu: aMenuMorph [ 
	^aMenuMorph
]

{ #category : #methods }
NullObjectBrowserObject >> methods [
	^ OrderedCollection new
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

{ #category : #exporting }
NullObjectBrowserObject >> writeCloneScriptOn: aWriteStream for: anObjectBrowserObject lesson: aLOOPLesson [ 
	"Un null ob onject no tiene prototipo"
]
