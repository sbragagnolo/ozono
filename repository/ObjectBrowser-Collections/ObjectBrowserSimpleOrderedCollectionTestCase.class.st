Class {
	#name : #ObjectBrowserSimpleOrderedCollectionTestCase,
	#superclass : #ObjectBrowserSimpleCollectionTestCase,
	#traits : 'OBSimpleCollectionTrait',
	#classTraits : 'OBSimpleCollectionTrait classTrait',
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> expectedOnAdd [
	^2.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> expectedOnCollect [ 
	|expected|
	expected := (Smalltalk at:#ordered) clone.
	^expected add: 7; add: 8;add: 10;yourself. 
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> setUp [ 
	super setUp .
	self collection: (Smalltalk at:#ordered) clone.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddAfter [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).
	self collection add: 666 after: 5.
	self assert: 666 equals: (self collection at: 2).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddAfterIndex [
	self putSomeElements.
	self assert: 8 equals: (self collection at: 3).
	self collection add: 666 afterIndex: 2.
	self assert: 666 equals: (self collection at: 3).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddBefore [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).
	self collection add: 666 before: 6.
	self assert: 666 equals: (self collection at: 2).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddBeforeIndex [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).
	self collection add: 666 beforeIndex: 2.
	self assert: 666 equals: (self collection at: 2).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAt [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).

]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAtPut [
	self putSomeElements.
	self assert: 5 equals: (self collection at: 1).
	self collection at: 1 put: 666.
	self assert: 666 equals: (self collection at: 1).

]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testFirst [
	self putSomeElements.
	self assert: 5 equals: self collection first .
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testLast [
	self putSomeElements.
	self assert: 8 equals: self collection last.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> testRemoveAt [
	self putSomeElements.
	self assert: 5 equals: (self collection at: 1).
	self collection removeAt: 1.
	self assert: (self collection includes: 5) not.

]
