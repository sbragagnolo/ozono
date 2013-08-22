Class {
	#name : #ObjectBrowserCollection,
	#superclass : #OBNormalMetaObject,
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
ObjectBrowserCollection class >> addCreationObserver: observer [
	self creationObservers add: observer 
]

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
ObjectBrowserCollection class >> creationObservers [
	^CreationObservers ifNil: [ CreationObservers := Set new ].
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
ObjectBrowserCollection class >> newWithRealObject: realObject [
	^super new
		realObject: realObject;
		yourself.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> notifyCollectionCreated: collection from: aFactory [
	self creationObservers do: [ :o | o addObject: 
		(aFactory newObjectBrowserObjectWithRealObject: collection) ].
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> removeCreationObserver: observer [
	self creationObservers remove: observer 
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> add: anObj [
	self realObject add: anObj realObject .
]

{ #category : #'attribute-handling' }
ObjectBrowserCollection >> addAttributeNamed: anAttributeName [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> addToGraph: aGraph [
	aGraph addCollection: self.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> compileMethod: aMethod  notifying: someone [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> displayString [
	| className prefix |
	className := self realObject class name.
	className first isVowel 
		ifTrue: [ prefix := 'an'. ]
		ifFalse: [ prefix:= 'a' ].
	^(prefix, self realObject class name) asLegalSelector
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> hasReferencesTo: anOBObject [
	^self realObject anySatisfy: [:elem | elem == anOBObject realObject ].
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> icon [
	^nil
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> isNull [
	^false
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> makeSelectionOn: anObjectBrowser [
	anObjectBrowser selectedPage: #objects.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> posibleName: aPosibleName [
	posibleName := aPosibleName .
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> printString [
	^'aCollection'.
]

{ #category : #exportation }
ObjectBrowserCollection >> realObjectPosibleName [ 
	^ self posibleName , '_conj'

]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> removeAttribute: variableName [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> removeClassFromSystem [
	"No hace nada, Sino eliminaria nuestra coleccion"
	^ self
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> removeMethod: aSelector [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> signalNotModificableCollection [
	self error: 'las colecciones no son modificables'
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> sourceCodeAt: aSelector [
	^'Código mágico :O'
]

{ #category : #'as yet unclassified' }
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
