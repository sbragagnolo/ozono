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
ObjectBrowserSimpleCollectionTestCase class >> isAbstract [

	^ true
]

{ #category : #requirements }
ObjectBrowserSimpleCollectionTestCase >> collection [ 
	^ collection .
]

{ #category : #accessing }
ObjectBrowserSimpleCollectionTestCase >> collection: col [
	collection := col.
]
