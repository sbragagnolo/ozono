Class {
	#name : #ObjectBrowserCollection,
	#superclass : #ObjectBrowserObject,
	#instVars : [
		'posibleName'
	],
	#classVars : [
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
ObjectBrowserCollection class >> newBag [
	^self basicNew	realObject: SimpleCollection newBag; yourself .
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> newOrdered [
	^self basicNew	realObject: SimpleOrderedCollection newOrdered; yourself .
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> newSet [
	^self basicNew	realObject: SimpleCollection newSet; yourself .
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> add: anObj [
	self realObject add: anObj .
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> addReferencesToGraphNodeCollection: aColl [
	self realObject do:[:obj | obj addToGraphNodeCollection: aColl].
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> addRelationsToGraph: aGraph [
	"self addSelfToGraph: aGraph.
	self realObject do:[:o | aGraph add: self ->o]"
	self realObject do: [ :anElement |
		self addRelationToGraph: aGraph between: self and: anElement label: 'each'
	].
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> addToGraph: aGraph [
	aGraph addCollection: self.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> addVariable: variableName [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> cloneWithName: aName [ 
	self error:'una coleccion no puede clonarse'
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> compileMethod: aMethod  notifying: someone [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> hasClones [
	^false
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> hasReferencesTo: anOBObject [
	^self realObject includes: anOBObject realObject
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
	^ methods.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> methodsFor: aCategory [
	^ self realObject class methodDictionary keys select:[:selector | (self realObject class organization categoryOfElement: selector) == aCategory ]
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> myNewScriptOn: aLesson [
	^ObjectBrowserCollection name, ' new', self realObject prototype collectionTypeName.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> posibleName [ 
	^ posibleName 
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> posibleName: aPosibleName [
	posibleName := aPosibleName .
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> printString [
	^'a Collection'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> realObject: obj [
	super realObject: obj .
	methods := ((self methodsFor: #collection) collect:[:m | OBMethod new selector: m ; yourself ]) asOrderedCollection .
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> references [
	| col |
	col := OrderedCollection new.
	self realObject do: [ :anElement |
		col add: anElement .
	].
	^col.
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
ObjectBrowserCollection >> removeVariable: variableName [
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

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> variables [
	^ OrderedCollection new
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self writeCreateObjectOn: stream lesson: aLesson.

]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> writeStateScriptOn: stream [
		"saves the state, all the variables values and relationships"
	self deprecated:'use writeStateScriptOn: lesson:'.
	self realObject do:  [ :obj | 
			stream nextPutAll: self posibleName , ' add: ' , (lesson objectBrowserObjectForRealObject: obj) posibleName, '.'. 
			stream cr].

]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> writeStateScriptOn: stream lesson: aLesson [
		"saves the state, all the variables values and relationships"
	self realObject do:  [ :obj | 
			stream nextPutAll: self posibleName , ' add: ' , (aLesson objectBrowserObjectForRealObject: obj) posibleName, '.'. 
			stream cr].

]
