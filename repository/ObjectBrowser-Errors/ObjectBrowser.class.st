Class {
	#name : #ObjectBrowser,
	#superclass : #Object,
	#instVars : [
		'workspaceText',
		'selectedObject',
		'selectedSelector',
		'selectedVariable'
	],
	#classVars : [
		'Objects'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowser class >> clean [
	Objects do: [:obj | obj removeClassFromSystem].
	Objects := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
ObjectBrowser class >> objects [
	^Objects
]

{ #category : #'as yet unclassified' }
ObjectBrowser class >> open [
	^self new openInWorld; yourself
]

{ #category : #model }
ObjectBrowser >> addObject: anObject [
	self objects add: anObject.
	self changed.
]

{ #category : #ObjectBrowser }
ObjectBrowser >> canDelete: anObjectBrowserObject [

	^self objects allSatisfy: [ :anOBObject | (anOBObject hasReferencesTo: anObjectBrowserObject) not ]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createGraphNodes [
	| objectSet |
	objectSet := OrderedCollection new.
	self objects do:[:obj | obj addToGraphNodeCollection: objectSet ].
	^objectSet.
]

{ #category : #model }
ObjectBrowser >> createObject: objectName [ 
	| object |
	objectName
		ifEmpty: [self error: 'el nombre del objeto no debe ser vacio'].
	object := ObjectBrowserObject createObjectBrowserObjectWithName: objectName
		andSuperclass: ObjectBrowserClass
		inObjectBrowser: self.
	self changed.
	^object
]

{ #category : #model }
ObjectBrowser >> createSet: objectName [ 
	| object |
	objectName
		ifEmpty: [self error: 'el nombre del objeto no debe ser vacio'].
	object := ObjectBrowserCollection createObjectBrowserObjectWithName: objectName
		andClass: SimpleSet
		inObjectBrowser: self.
	self changed.
	^object
]

{ #category : #view }
ObjectBrowser >> initialExtent [
	"eso"
	^ 700@400
]

{ #category : #'initialize-release' }
ObjectBrowser >> initialize [
	super initialize.
	self initializeObjectBrowser.
	
]

{ #category : #'initialize-release' }
ObjectBrowser >> initializeObjectBrowser [
	Objects := Objects ifNil: [OrderedCollection new].
]

{ #category : #ObjectBrowser }
ObjectBrowser >> objects [
	^Objects
]

{ #category : #ObjectBrowser }
ObjectBrowser >> objects: aCollection [
	Objects := aCollection
]

{ #category : #'initialize-release' }
ObjectBrowser >> openInWorld [
	ObjectBrowserWindow show: self

	
]

{ #category : #model }
ObjectBrowser >> removeObject: anObject [
	self objects remove: anObject.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> showObjectGraph [
	ObjectGrapher new show: self.
]
