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
	self realObject add: anObj realObject .
]

{ #category : #'attribute-handling' }
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
	^self realObject anySatisfy: [:elem | elem == anOBObject realObject ].
]

{ #category : #accessing }
OBCollectionMetaObject >> icon [
	^nil
]

{ #category : #testing }
OBCollectionMetaObject >> isNull [
	^false
]

{ #category : #selection }
OBCollectionMetaObject >> makeSelectionOn: anObjectBrowser [
	anObjectBrowser selectedPage: #objects.
]

{ #category : #accessing }
OBCollectionMetaObject >> methods [
	^ (self realObject class methodDictionary keys collect: [:m | OBMethod new selector: m ; object: self; yourself ]) asSortedCollection: [:obMethod1 :obMethod2 | obMethod1 selector < obMethod2 selector ].
]

{ #category : #exportation }
OBCollectionMetaObject >> myNewScriptOn: aLesson [
^ OBCollectionMetaObject name, ' newOn: ', aLesson lessonIdentification, ' withRealObject: ' , self realObject class name asLowercase, ' clone'.
]

{ #category : #exportation }
OBCollectionMetaObject >> posibleName [ 
	^ posibleName 
]

{ #category : #accessing }
OBCollectionMetaObject >> posibleName: aPosibleName [
	posibleName := aPosibleName .
]

{ #category : #printing }
OBCollectionMetaObject >> printString [
	^'aCollection'.
]

{ #category : #exportation }
OBCollectionMetaObject >> realObjectPosibleName [ 
	^ self posibleName , '_conj'

]

{ #category : #attributes }
OBCollectionMetaObject >> removeAttribute: variableName [
	self signalNotModificableCollection
]

{ #category : #'pharo-interaction' }
OBCollectionMetaObject >> removeClassFromSystem [
	"No hace nada, Sino eliminaria nuestra coleccion"
	^ self
]

{ #category : #methods }
OBCollectionMetaObject >> removeMethod: aSelector [
	self signalNotModificableCollection
]

{ #category : #signalling }
OBCollectionMetaObject >> signalNotModificableCollection [
	self error: 'las colecciones no son modificables'
]

{ #category : #methods }
OBCollectionMetaObject >> sourceCodeAt: aSelector [
	^'Código mágico :O'
]

{ #category : #accessing }
OBCollectionMetaObject >> treeContents [
	^OrderedCollection new.
]

{ #category : #exportation }
OBCollectionMetaObject >> variables [
	^ OrderedCollection new
]

{ #category : #exportation }
OBCollectionMetaObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self writeCreateObjectOn: stream lesson: aLesson.

]

{ #category : #exportation }
OBCollectionMetaObject >> writeStateScriptOn: stream lesson: aLesson [
		"saves the state, all the variables values and relationships"
	self realObject do:  [ :obj | 
			stream nextPutAll: self posibleName , ' add: ' , (aLesson objectBrowserObjectForRealObject: obj) posibleName, '.'. 
			stream cr].

]
