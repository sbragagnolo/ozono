Class {
	#name : #ObjectBrowserCollection,
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
ObjectBrowserCollection class >> basicNew [	
	^super basicNew posibleName: self name asLowercase , self collectionClassNumber asString ; yourself 
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> collectionClassNumber [
	"devuelve un numero valido de coleccion en el sistema, que no se repite con otra colleccion"
	NextCollectionClassNumberAvailable ifNil: [NextCollectionClassNumberAvailable := 0].
	NextCollectionClassNumberAvailable :=  NextCollectionClassNumberAvailable + 1.
	^ NextCollectionClassNumberAvailable - 1.

]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> new [
	^self error: 'Siempre hay que decir que sabor de coleccion queremos'
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> new: setName [
	^self error: 'Siempre hay que decir que sabor de coleccion queremos'
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> newWithRealObject: realObject inLesson: aLesson [
	^super new
		realObject: realObject;
		lesson: aLesson;
		yourself.
]

{ #category : #visiting }
ObjectBrowserCollection >> accept: aVisitor [

	aVisitor visitCollection: self.
]

{ #category : #adding }
ObjectBrowserCollection >> add: anObj [
	self realObject add: anObj realObject .
]

{ #category : #'attribute-handling' }
ObjectBrowserCollection >> addAttributeNamed: anAttributeName [
	self signalNotModificableCollection
]

{ #category : #attributes }
ObjectBrowserCollection >> allRelationships [
	
	"Returns all normal attributes plus special ones such as the prototype if available"
	| prototypeRelationship |
	prototypeRelationship := self prototype relationWith: self.
	^prototypeRelationship withRelationships: self basicRelationships
]

{ #category : #attributes }
ObjectBrowserCollection >> basicRelationships [
	
	^self realObject collect: [ :elem | 
		OBSpecialAttribute 
			newNamed: 'elemento'
			owner: self
			pointingTo: (lesson objectBrowserObjectForRealObject: elem)
		]
]

{ #category : #methods }
ObjectBrowserCollection >> compileMethod: aMethod  notifying: someone [
	self signalNotModificableCollection
]

{ #category : #printing }
ObjectBrowserCollection >> displayString [
	| className prefix |
	className := self realObject class name.
	className first isVowel 
		ifTrue: [ prefix := 'an'. ]
		ifFalse: [ prefix:= 'a' ].
	^(prefix, self realObject class name) asLegalSelector
]

{ #category : #references }
ObjectBrowserCollection >> hasReferencesTo: anOBObject [
	^self realObject anySatisfy: [:elem | elem == anOBObject realObject ].
]

{ #category : #accessing }
ObjectBrowserCollection >> icon [
	^nil
]

{ #category : #testing }
ObjectBrowserCollection >> isNull [
	^false
]

{ #category : #selection }
ObjectBrowserCollection >> makeSelectionOn: anObjectBrowser [
	anObjectBrowser selectedPage: #objects.
]

{ #category : #accessing }
ObjectBrowserCollection >> methods [
	^ (self realObject class methodDictionary keys collect: [:m | OBMethod new selector: m ; object: self; yourself ]) asSortedCollection: [:obMethod1 :obMethod2 | obMethod1 selector < obMethod2 selector ].
]

{ #category : #exportation }
ObjectBrowserCollection >> myNewScriptOn: aLesson [
^ ObjectBrowserCollection name, ' newOn: ', aLesson lessonIdentification, ' withRealObject: ' , self realObject class name asLowercase, ' clone'.
]

{ #category : #exportation }
ObjectBrowserCollection >> posibleName [ 
	^ posibleName 
]

{ #category : #accessing }
ObjectBrowserCollection >> posibleName: aPosibleName [
	posibleName := aPosibleName .
]

{ #category : #printing }
ObjectBrowserCollection >> printString [
	^'aCollection'.
]

{ #category : #exportation }
ObjectBrowserCollection >> realObjectPosibleName [ 
	^ self posibleName , '_conj'

]

{ #category : #attributes }
ObjectBrowserCollection >> removeAttribute: variableName [
	self signalNotModificableCollection
]

{ #category : #'pharo-interaction' }
ObjectBrowserCollection >> removeClassFromSystem [
	"No hace nada, Sino eliminaria nuestra coleccion"
	^ self
]

{ #category : #methods }
ObjectBrowserCollection >> removeMethod: aSelector [
	self signalNotModificableCollection
]

{ #category : #signalling }
ObjectBrowserCollection >> signalNotModificableCollection [
	self error: 'las colecciones no son modificables'
]

{ #category : #methods }
ObjectBrowserCollection >> sourceCodeAt: aSelector [
	^'Código mágico :O'
]

{ #category : #accessing }
ObjectBrowserCollection >> treeContents [
	^OrderedCollection new.
]

{ #category : #exportation }
ObjectBrowserCollection >> variables [
	^ OrderedCollection new
]

{ #category : #exportation }
ObjectBrowserCollection >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self writeCreateObjectOn: stream lesson: aLesson.

]

{ #category : #exportation }
ObjectBrowserCollection >> writeStateScriptOn: stream lesson: aLesson [
		"saves the state, all the variables values and relationships"
	self realObject do:  [ :obj | 
			stream nextPutAll: self posibleName , ' add: ' , (aLesson objectBrowserObjectForRealObject: obj) posibleName, '.'. 
			stream cr].

]
