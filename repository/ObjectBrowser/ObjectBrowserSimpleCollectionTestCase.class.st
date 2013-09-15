Class {
	#name : #ObjectBrowserSimpleCollectionTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'colection'
	],
	#classVars : [
		'collection'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #requirements }
ObjectBrowserSimpleCollectionTestCase >> collection [ 
	^ collection .
]

{ #category : #accessing }
ObjectBrowserSimpleCollectionTestCase >> collection: col [
	collection := col.
]
