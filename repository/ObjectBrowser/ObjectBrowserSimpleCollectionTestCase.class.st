Class {
	#name : #ObjectBrowserSimpleCollectionTestCase,
	#superclass : #LoopTestCase,
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
