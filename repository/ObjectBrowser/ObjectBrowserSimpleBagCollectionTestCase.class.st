Class {
	#name : #ObjectBrowserSimpleBagCollectionTestCase,
	#superclass : #ObjectBrowserSimpleCollectionTestCase,
	#traits : 'OBSimpleCollectionTrait - {#testPrintString}',
	#classTraits : 'OBSimpleCollectionTrait classTrait',
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleBagCollectionTestCase >> expectedOnAdd [
	^2.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleBagCollectionTestCase >> expectedOnCollect [ 
	|expected|
	expected := (currentLesson literalNamed: #bag) clone.
	^expected add: 7; add: 8;add: 10;yourself. 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleBagCollectionTestCase >> expectedPrintString [
	^'aBag'. 
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleBagCollectionTestCase >> setUp [ 
	super setUp.
	self collection: (currentLesson literalNamed: #bag) clone.
]
