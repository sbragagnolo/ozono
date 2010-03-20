Class {
	#name : #ObjectBrowserCollection,
	#superclass : #ObjectBrowserObject,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowserCollection class >> new: setName [
	^self new objectName: setName;
		realObject: SimpleSet new
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
	self addSelfToGraph: aGraph.
"	self realObject do:[:o | o addToGraph:aGraph]"
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
	^self realObject includes: anOBObject
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> isNull [
	^false
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> methods [
	^ (self methodsFor: #collection ) asOrderedCollection
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> methodsFor: aCategory [
	^ self realObject class methodDictionary keys select:[:selector | (self realObject class organization categoryOfElement: selector) == aCategory ]
]

{ #category : #'as yet unclassified' }
ObjectBrowserCollection >> printString [
	^super printString
"	^self realObject printString"
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
ObjectBrowserCollection >> variables [
	^ OrderedCollection new
]