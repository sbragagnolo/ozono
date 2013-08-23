Class {
	#name : #GraphTestCase,
	#superclass : #LoopTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
GraphTestCase >> testComplicatedGraph [
	| obj graph obj2 noObo1 noObo2 |
	obj := currentLesson createObject.
	obj2 := currentLesson createObject.
	currentLesson addObject: (noObo1 := OBExternalObjectMetaObject for: 2).
	currentLesson addObject: (noObo2 := OBExternalObjectMetaObject for: nil).
	
	obj addAttributeNamed: 'var1'.
	obj attributeNamed: 'var1' pointTo: obj2.
	obj addAttributeNamed: 'var2'.
	obj attributeNamed: 'var2' pointTo: (OBExternalObjectMetaObject for: 2).
	
	obj2 addAttributeNamed: 'var1'.
	obj2 attributeNamed: 'var1' pointTo: obj.
	obj2 addAttributeNamed: 'var2'.

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
	obj := currentLesson createObject.
	obj2 := currentLesson createObject.
	
	obj addAttributeNamed: 'var1'.
	obj attributeNamed: 'var1' pointTo: obj2.
	
	obj2 addAttributeNamed: 'var1'.
	obj2 attributeNamed: 'var1' pointTo: obj.

	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj).
	self assert: (graph objects includes: obj2).
	
	self assert: (graph references anySatisfy: [ :r | r from = obj & r to = obj2 & r name = 'var1']).
	self assert: (graph references anySatisfy: [ :r | r from = obj2 & r to = obj & r name = 'var1']).
]

{ #category : #'as yet unclassified' }
GraphTestCase >> testObjectWithVariables [
	| obj graph |
	obj := currentLesson createObject.
	obj addAttributeNamed: 'var1'.
	obj attributeNamed: 'var1' pointTo: (OBExternalObjectMetaObject for: 2).
	
	obj addAttributeNamed: 'var2'.
	
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
	obj := currentLesson createObject.
	graph := currentLesson buildGraph.
	
	self assert: (graph objects includes: obj).
]
