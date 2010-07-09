Class {
	#name : #ObjectBrowserSimpleOrderedCollectionTestCase,
	#superclass : #ObjectBrowserSimpleCollectionTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> expectedOnAdd [
	^2.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> expectedOnCollect [ 
	|expected|
	expected := ordered clone.
	^expected add: 7; add: 8;add: 10;yourself. 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> setUp [ 
	super setUp .
	colection := ordered clone.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddAfter [
	self putSomeElements.
	self assert: 6 equals: (colection at: 2).
	colection add: 666 after: 5.
	self assert: 666 equals: (colection at: 2).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddAfterIndex [
	self putSomeElements.
	self assert: 8 equals: (colection at: 3).
	colection add: 666 afterIndex: 2.
	self assert: 666 equals: (colection at: 3).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddBefore [
	self putSomeElements.
	self assert: 6 equals: (colection at: 2).
	colection add: 666 before: 6.
	self assert: 666 equals: (colection at: 2).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddBeforeIndex [
	self putSomeElements.
	self assert: 6 equals: (colection at: 2).
	colection add: 666 beforeIndex: 2.
	self assert: 666 equals: (colection at: 2).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAt [
	self putSomeElements.
	self assert: 6 equals: (colection at: 2).

]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAtPut [
	self putSomeElements.
	self assert: 5 equals: (colection at: 1).
	colection at: 1 put: 666.
	self assert: 666 equals: (colection at: 1).

]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testFirst [
	self putSomeElements.
	self assert: 5 equals: colection first .
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testLast [
	self putSomeElements.
	self assert: 8 equals: colection last.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testRemoveAt [
	self putSomeElements.
	self assert: 5 equals: (colection at: 1).
	colection removeAt: 1.
	self assert: (colection includes: 5) not.

]
