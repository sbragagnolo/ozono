"
I am the meta-object that represents an (sub)instance of a collection.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBCollectionMetaObject,
	#superclass : #OBMetaObject,
	#instVars : [
		'posibleName'
	],
	#classVars : [
		'CreationObservers',
		'NextCollectionClassNumberAvailable'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBCollectionMetaObject class >> basicNew [	
	^super basicNew posibleName: self name asLowercase , self collectionClassNumber asString ; yourself 
]

{ #category : #'as yet unclassified' }
OBCollectionMetaObject class >> collectionClassNumber [
	"devuelve un numero valido de coleccion en el sistema, que no se repite con otra colleccion"
	NextCollectionClassNumberAvailable ifNil: [NextCollectionClassNumberAvailable := 0].
	NextCollectionClassNumberAvailable :=  NextCollectionClassNumberAvailable + 1.
	^ NextCollectionClassNumberAvailable - 1.

]

{ #category : #'as yet unclassified' }
OBCollectionMetaObject class >> new [
	^self error: 'Siempre hay que decir que sabor de coleccion queremos'
]

{ #category : #'as yet unclassified' }
OBCollectionMetaObject class >> new: setName [
	^self error: 'Siempre hay que decir que sabor de coleccion queremos'
]

{ #category : #'as yet unclassified' }
OBCollectionMetaObject class >> newWithRealObject: realObject inLesson: aLesson [
	^super new
		realObject: realObject;
		lesson: aLesson;
		yourself.
]

{ #category : #visiting }
OBCollectionMetaObject >> accept: aVisitor [

	aVisitor visitCollection: self.
]

{ #category : #adding }
OBCollectionMetaObject >> add: anObj [

	self realObject add: anObj realObject.
]

{ #category : #attributes }
OBCollectionMetaObject >> addAttributeNamed: anAttributeName [

	self signalNotModificableCollection
]

{ #category : #attributes }
OBCollectionMetaObject >> allRelationships [
	
	"Returns all normal attributes plus special ones such as the prototype if available"
	| prototypeRelationship |
	prototypeRelationship := self prototype relationWith: self.
	^prototypeRelationship withRelationships: self basicRelationships
]

{ #category : #attributes }
OBCollectionMetaObject >> basicRelationships [
	
	^self realObject collect: [ :elem | 
		OBSpecialAttribute 
			newNamed: 'elemento'
			owner: self
			pointingTo: (lesson objectBrowserObjectForRealObject: elem)
		]
]

{ #category : #methods }
OBCollectionMetaObject >> compileMethod: aMethod  notifying: someone [

	self signalNotModificableCollection
]

{ #category : #printing }
OBCollectionMetaObject >> displayString [

	| className prefix |
	className := self realObject class name.
	className first isVowel 
		ifTrue: [ prefix := 'an'. ]
		ifFalse: [ prefix:= 'a' ].
	^(prefix, self realObject class name) asLegalSelector
]

{ #category : #references }
OBCollectionMetaObject >> hasReferencesTo: anOBObject [

	^self realObject includes: anOBObject realObject
]

{ #category : #'ui-actions' }
OBCollectionMetaObject >> icon [
	^nil
]

{ #category : #'ui-actions' }
OBCollectionMetaObject >> makeSelectionOn: anObjectBrowser [

	anObjectBrowser selectedPage: #objects.
]

{ #category : #methods }
OBCollectionMetaObject >> methods [

	^ self realObject class methodDictionary keys collect: [:m | OBMethod new selector: m ; object: self; yourself ]
]

{ #category : #exporting }
OBCollectionMetaObject >> myNewScriptOn: aLesson [

	^ '(', aLesson lessonIdentification , ' literalNamed: ''', self realObject class name asLowercase , ''') basicClone'
	
]

{ #category : #accessing }
OBCollectionMetaObject >> posibleName [

	^ posibleName
]

{ #category : #accessing }
OBCollectionMetaObject >> posibleName: aPosibleName [

	posibleName := aPosibleName
]

{ #category : #printing }
OBCollectionMetaObject >> printString [

	^'aCollection'.
]

{ #category : #accessing }
OBCollectionMetaObject >> realObjectPosibleName [

	^ self posibleName , '_conj'

]

{ #category : #attributes }
OBCollectionMetaObject >> removeAttribute: variableName [

	self signalNotModificableCollection
]

{ #category : #'pharo-interaction' }
OBCollectionMetaObject >> removeClassFromSystem [

	"Does nothing. If not, it would remove the collection from the system"

]

{ #category : #methods }
OBCollectionMetaObject >> removeMethod: aSelector [

	self signalNotModificableCollection
]

{ #category : #accessing }
OBCollectionMetaObject >> signalNotModificableCollection [
	self error: 'las colecciones no son modificables'
]

{ #category : #methods }
OBCollectionMetaObject >> sourceCodeAt: aSelector [

	^'Código mágico :O'
]

{ #category : #'ui-actions' }
OBCollectionMetaObject >> treeContents [
	^OrderedCollection new.
]

{ #category : #attributes }
OBCollectionMetaObject >> variables [

	^ #()
]

{ #category : #exporting }
OBCollectionMetaObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self writeCreateObjectOn: stream lesson: aLesson.

]

{ #category : #exporting }
OBCollectionMetaObject >> writeStateScriptOn: stream lesson: aLesson [

	self realObject do:  [ :obj | 
			stream nextPutAll: self posibleName , ' add: ' , (aLesson objectBrowserObjectForRealObject: obj) posibleName, '.'. 
			stream cr].

]
