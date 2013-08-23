"
I am a mode to traverse the graph.
"
Class {
	#name : #OBGraphMode,
	#superclass : #Object,
	#instVars : [
		'graph',
		'visitedObjects'
	],
	#category : #'ObjectBrowser-Graph'
}

{ #category : #accessing }
OBGraphMode >> graph: aGraph [

	graph := aGraph
]

{ #category : #'initialize-release' }
OBGraphMode >> initialize [

	super initialize.
	visitedObjects := Set new.
]

{ #category : #visiting }
OBGraphMode >> passOnObject: anObject [

	self subclassResponsibility
]

{ #category : #visiting }
OBGraphMode >> visitObject: anObject [

	(visitedObjects includes: anObject)
		ifTrue: [ ^self ].
	visitedObjects add: anObject.
	self passOnObject: anObject.
]
