Class {
	#name : #OBAbstractMetaObject,
	#superclass : #Object,
	#instVars : [
		'methods',
		'concreteObject',
		'prototype'
	],
	#classVars : [
		'NextObjectBrowserClassNumber'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'class initialization' }
OBAbstractMetaObject class >> initialize [
	NextObjectBrowserClassNumber := 1
]

{ #category : #'ui-actions' }
OBAbstractMetaObject >> actionsForAttributeListWith: selectedAttribute [

	| actions |
	actions := OrderedCollection with: #('Crear nueva referencia' createAttribute).
	actions addAll: (selectedAttribute actionsForAttributeList).
	^actions asArray
]

{ #category : #'ui-actions' }
OBAbstractMetaObject >> actionsForObjectBrowserReferencesList [

	^#(#('Clonar objeto referenciado' #cloneObject)).
]

{ #category : #accessing }
OBAbstractMetaObject >> baseObject [

	^ concreteObject
]

{ #category : #accessing }
OBAbstractMetaObject >> concreteObject: anObject [

	concreteObject := anObject
]

{ #category : #ui }
OBAbstractMetaObject >> deleteConfirmationMessage [
	^ '¿Está seguro de eliminar la referencia a este objeto? El objeto referenciado aparecerá en la papelera si no tiene otras referencias.' translated
]

{ #category : #methods }
OBAbstractMetaObject >> isRedefined: aSelector [

	^OBPharoReflection uniqueInstance
		inSubclassesOfClass: (OBPharoReflection uniqueInstance classOf: self baseObject)
		isRedefined: aSelector
]

{ #category : #'ui-actions' }
OBAbstractMetaObject >> menu: aMenuMorph [

	aMenuMorph addLine.
	^aMenuMorph addList: (self actionsForObjectBrowserReferencesList).
]

{ #category : #accessing }
OBAbstractMetaObject >> posibleName [

	^ ((OBPharoReflection uniqueInstance classNameOfObject: self baseObject), self baseObject hash asString) asLowercase.
]

{ #category : #cloning }
OBAbstractMetaObject >> prototype [

	^prototype
]

{ #category : #cloning }
OBAbstractMetaObject >> prototype: anObject [

	prototype := anObject
]

{ #category : #methods }
OBAbstractMetaObject >> redefines: aSelector [

	^OBPharoReflection uniqueInstance
		inClass: (OBPharoReflection uniqueInstance classOf: self baseObject)
		isRedefined: aSelector
]

{ #category : #accessing }
OBAbstractMetaObject >> size [

	^self baseObject size
]
