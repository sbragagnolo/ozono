Class {
	#name : #GraphTestCase,
	#superclass : #LoopTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
GraphTestCase >> testComplicatedGraph [
	| obj graph obj2 noObo1 noObo2 |
	obj := currentLesson addNewObject.
	obj2 := currentLesson addNewObject.
	currentLesson addObject: (noObo1 := NoObjectBrowserObject for: 2).
	currentLesson addObject: (noObo2 := NoObjectBrowserObject for: nil).
	
	obj addVariable: 'var1'.
	obj variable: 'var1' pointTo: obj2 realObject.
	obj addVariable: 'var2'.
	obj variable: 'var2' pointTo: 2.
	
	obj2 addVariable: 'var1'.
	obj2 variable: 'var1' pointTo: obj realObject.
	obj2 addVariable: 'var2'.

	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj).
	self assert: (graph objects includes: obj2).
	self assert: (graph objects includes: noObo1).
	self assert: (graph objects includes: noObo2).
	
	self assert: (graph references size = 4).
	
	self assert: (graph references anySatisfy: [ :r | r from = obj & r to = obj2 & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj2 & r to = obj & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj & r to realObject = 2 & r name = 'var2']).
	self assert: (graph references anySatisfy: [ :r | r from = obj2 & r to realObject = nil & r name = 'var2']).
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
	
	self assert: (graph objects includes: obj).
	self assert: (graph objects includes: obj2).
	
	self assert: (graph references anySatisfy: [ :r | r from = obj & r to = obj2 & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj2 & r to = obj & r name = 'var1']).
]

{ #category : #'as yet unclassified' }
GraphTestCase >> testObjectWithVariables [
	| obj graph |
	obj := currentLesson addNewObject.
	obj addVariable: 'var1'.
	obj variable: 'var1' pointTo: 2.
	
	obj addVariable: 'var2'.
	
	graph := currentLesson buildGraph.
	
	self assert: (graph references size = 2).
	
	self assert: (graph objects includes: obj).
	self assert: (graph objects anySatisfy: [ :o | o realObject = 2 ]).
	self assert: (graph objects anySatisfy: [ :o | o realObject = nil ]).
	
	self assert: (graph references anySatisfy: [ :r | r from = obj & r to realObject = 2 & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj & r to realObject = nil & r name = 'var2']).
]

{ #category : #'as yet unclassified' }
GraphTestCase >> testSimpleObjectGraph [
	| obj graph |
	obj := currentLesson addNewObject.
	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj).
]
