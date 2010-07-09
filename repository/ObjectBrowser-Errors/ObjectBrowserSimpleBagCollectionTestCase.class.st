Class {
	#name : #ObjectBrowserSimpleBagCollectionTestCase,
	#superclass : #ObjectBrowserSimpleCollectionTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleBagCollectionTestCase >> expectedOnAdd [
	^2.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleBagCollectionTestCase >> expectedOnCollect [ 
	|expected|
	expected := bag clone.
	^expected add: 7; add: 8;add: 10;yourself. 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleBagCollectionTestCase >> setUp [ 
	super setUp .
	colection := bag clone.
]
