Class {
	#name : #GraphTestCase,
	#superclass : #LoopTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
GraphTestCase >> testComplicatedGraph [
	| obj graph obj2|
	obj := currentLesson addNewObject.
	obj2 := currentLesson addNewObject.
	currentLesson addObject: (NoObjectBrowserObject new: 2).
	currentLesson addObject: (NoObjectBrowserObject new: nil).
	
	obj addVariable: 'var1'.
	obj variable: 'var1' pointTo: obj2 realObject.
	obj addVariable: 'var2'.
	obj variable: 'var2' pointTo: 2.
	
	obj2 addVariable: 'var1'.
	obj2 variable: 'var1' pointTo: obj realObject.
	obj2 addVariable: 'var2'.

	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj realObject).
	self assert: (graph objects includes: obj2 realObject ).
	self assert: (graph objects includes: nil).
	self assert: (graph objects includes: 2).
	
	self assert: (graph references size = 4).
	
	self assert: (graph references anySatisfy: [ :r | r from = obj realObject & r to = obj2 realObject & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj2 realObject & r to = obj realObject & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj realObject & r to = 2 & r name = 'var2']).
	self assert: (graph references anySatisfy: [ :r | r from = obj2 realObject & r to = nil & r name = 'var2']).
]

{ #category : #'as yet unclassified' }
GraphTestCase >> testLoopGraph [
	| obj graph obj2 |
	obj := currentLesson addNewObject.
	obj2 := currentLesson addNewObject.
	
	obj addVariable: 'var1'.
	obj variable: 'var1' pointTo: obj2 realObject.
	
	obj2 addVariable: 'var1'.
	obj2 variable: 'var1' pointTo: obj realObject.

	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj realObject).
	self assert: (graph objects includes: obj2 realObject ).
	
	self assert: (graph references anySatisfy: [ :r | r from = obj realObject & r to = obj2 realObject & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj2 realObject & r to = obj realObject & r name = 'var1']).
]

{ #category : #'as yet unclassified' }
GraphTestCase >> testObjectWithVariables [
	| obj graph |
	obj := currentLesson addNewObject.
	obj addVariable: 'var1'.
	obj variable: 'var1' pointTo: 2.
	
	obj addVariable: 'var2'.
	
	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj realObject).
	self assert: (graph objects includes: nil).
	self assert: (graph objects includes: 2).
	
	self assert: (graph references anySatisfy: [ :r | r from = obj realObject & r to = 2 & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj realObject & r to = nil & r name = 'var2']).
]

{ #category : #'as yet unclassified' }
GraphTestCase >> testSimpleObjectGraph [
	| obj graph |
	obj := currentLesson addNewObject.
	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj realObject).
]
