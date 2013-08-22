Class {
	#name : #ObjectBrowserSimpleSetCollectionTestCase,
	#superclass : #ObjectBrowserSimpleCollectionTestCase,
	#traits : 'OBSimpleCollectionTrait',
	#classTraits : 'OBSimpleCollectionTrait classTrait',
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleSetCollectionTestCase >> expectedOnAdd [
	^1.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleSetCollectionTestCase >> expectedOnCollect [ 
	|expected|
	expected := (Smalltalk at:#set) clone.
	^expected add: 7; add: 8;add: 10;yourself. 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleSetCollectionTestCase >> setUp [ 
	super setUp .
	self collection:  (Smalltalk at:#set) clone.
]
