Class {
	#name : #ObjectBrowserSimpleCollectionTestCase,
	#superclass : #TestCase,
	#instVars : [
		'colection'
	],
	#classVars : [
		'collection'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> collection [ 
	^ collection .
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> collection: col [
	collection := col.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> setUp [
	Smalltalk at:#set put: (OBBaseSetCollection new). 
	Smalltalk at:#bag ifAbsentPut: (OBBaseBagCollection new).
	Smalltalk at:#ordered put: OBBaseOrderedCollection new. 
]
