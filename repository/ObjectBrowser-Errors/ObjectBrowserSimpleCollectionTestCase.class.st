Class {
	#name : #ObjectBrowserSimpleCollectionTestCase,
	#superclass : #TestCase,
	#instVars : [
		'colection'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> expectedOnAdd [
	^self subclassResponsibility .
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> expectedOnCollect [ 
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> putSomeElements [
	colection add: 5.
	colection add: 6.
	colection add: 8.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> setUp [
	Smalltalk at:#set put: (OBBaseSetCollection new). 
	Smalltalk at:#bag ifAbsentPut: (OBBaseBagCollection new).
	Smalltalk at:#ordered put: OBBaseOrderedCollection new. 
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testAdd [
	self assert: 0 equals: colection size.
	colection add: 1.
	colection add: 1.
	self assert: self expectedOnAdd equals: colection size.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testAllSatisfy [
	self putSomeElements.
	self assert:  (colection allSatisfy: [:num|num>3]).
	self assert:  (colection allSatisfy: [:num|num>100]) not.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testAnySatisfy [
	self putSomeElements.
	self assert:  (colection anySatisfy: [:num|num>7]).
	self assert:  (colection anySatisfy: [:num|num>100]) not.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testCollect [
	|expected collectionCollected|
	
	self putSomeElements.
	collectionCollected :=colection collect: [:num|num+2].
	expected := self expectedOnCollect .
	self assert: expected size equals: collectionCollected size.
	self assert: (collectionCollected allSatisfy: [:e| expected includes: e] ).
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testDo [
	|total|
	self putSomeElements.
	total := 0.
	colection do: [:e | total := total +e].
	self assert: 19 equals: total.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testIncludes [
	self putSomeElements.
	self assert: (colection includes: 5).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testInjectInto [
	self putSomeElements.
	self assert: 19 equals: (colection inject: 0 into:[:tot :e | tot+e] ).
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testIsEmpty [
	self assert: colection isEmpty.
	self putSomeElements .
	self assert: colection isEmpty not.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testRemove [
	self putSomeElements .
	self assert: (colection includes: 5).
	colection remove: 5.
	self assert: (colection includes: 5) not.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testSelect [
	self putSomeElements .
	self assert: (colection includes: 5).
	self assert: ((colection select: [:e| e >5]) includes: 5) not.
]

{ #category : #'as yet unclassified' }
ObjectBrowserSimpleCollectionTestCase >> testSize [
	self assert: 0 equals: colection size.
	self putSomeElements .
	self assert: 3 equals: colection size.
]
