Class {
	#name : #NullObjectBrowserObject,
	#superclass : #Object,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> addInversePrototypeRelationship: referencesCollection [
	"El NullObjectBrowserObject no debe agregarse a la coleccion de objetos"
	^self
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> addVariable: variableName [
	self error: 'Debe seleccionar un objeto para crear una variable'.
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> compileMethod: aText [ 
	^self error: 'Debe seleccionar un objeto para este metodo'.
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> isNil [
	^true
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
	^self error: 'Esto no deberia pasar - El metodo no esta definido en la jerarquia de prototipo: ', aSelector asString
]

{ #category : #'as yet unclassified' }
NullObjectBrowserObject >> variables [
	^OrderedCollection new
]
