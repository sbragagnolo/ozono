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
	expected := (currentLesson literalNamed: #ordered) clone.
	^expected add: 7; add: 8;add: 10;yourself. 
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleOrderedCollectionTestCase >> setUp [ 
	super setUp .
	self collection: (currentLesson literalNamed: #ordered) clone.
]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddAfter [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).
	self collection add: 666 after: 5.
	self assert: 666 equals: (self collection at: 2).
]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddAfterIndex [
	self putSomeElements.
	self assert: 8 equals: (self collection at: 3).
	self collection add: 666 afterIndex: 2.
	self assert: 666 equals: (self collection at: 3).
]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddBefore [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).
	self collection add: 666 before: 6.
	self assert: 666 equals: (self collection at: 2).
]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAddBeforeIndex [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).
	self collection add: 666 beforeIndex: 2.
	self assert: 666 equals: (self collection at: 2).
]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAt [
	self putSomeElements.
	self assert: 6 equals: (self collection at: 2).

]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testAtPut [
	self putSomeElements.
	self assert: 5 equals: (self collection at: 1).
	self collection at: 1 put: 666.
	self assert: 666 equals: (self collection at: 1).

]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testFirst [
	self putSomeElements.
	self assert: 5 equals: self collection first .
]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testLast [
	self putSomeElements.
	self assert: 8 equals: self collection last.
]

{ #category : #tests }
ObjectBrowserSimpleOrderedCollectionTestCase >> testRemoveAt [
	self putSomeElements.
	self assert: 5 equals: (self collection at: 1).
	self collection removeAt: 1.
	self assert: (self collection includes: 5) not.

]
