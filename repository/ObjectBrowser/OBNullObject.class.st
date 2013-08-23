"
I am a null-object representing the absense of an OBMetaObject inside the object browser. I keep polymorphic with the OBMetaObject.
"
Class {
	#name : #OBNullObject,
	#superclass : #Object,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'ui-actions' }
OBNullObject >> actionsForAttributeListWith: selectedAttribute [
	^#()
]

{ #category : #'ui-actions' }
OBNullObject >> actionsForObjectBrowserReferencesList [
	^#(#('eliminar' #deleteLessonVariable))
]

{ #category : #attributes }
OBNullObject >> addAttributeNamed: anAttributeName [
	self error: 'Debes seleccionar un objeto para crearle un atributo'.
]

{ #category : #references }
OBNullObject >> addInversePrototypeRelationship: referencesCollection [
	"El NullObjectBrowserObject no debe agregarse a la coleccion de objetos"
	^self
]

{ #category : #graph }
OBNullObject >> addPrototypeRelationshipTo: anObjectBrowserObject in: aLessonGraph [ 
	"Nothing"
]

{ #category : #attributes }
OBNullObject >> allAttributeNames [
	^OrderedCollection new
]

{ #category : #attributes }
OBNullObject >> attributes [
	
	^ #()
]

{ #category : #methods }
OBNullObject >> compileMethod: aText notifying: someone [
	^self error: 'Debe seleccionar un objeto para este metodo'.
]

{ #category : #methods }
OBNullObject >> includesSelector: aSelector [
	^false
]

{ #category : #testing }
OBNullObject >> isNil [
	^true
]

{ #category : #'ui-actions' }
OBNullObject >> menu: aMenuMorph [ 
	^aMenuMorph
]

{ #category : #methods }
OBNullObject >> methods [
	^ OrderedCollection new
]

{ #category : #'pharo-interaction' }
OBNullObject >> removeFromSystem [
	"do nothing"
	^self
]

{ #category : #methods }
OBNullObject >> sourceCodeAt: aSelector [ 
	^''
]

{ #category : #exporting }
OBNullObject >> writeCloneScriptOn: aWriteStream for: anObjectBrowserObject lesson: aLOOPLesson [ 
	"Un null ob onject no tiene prototipo"
]
