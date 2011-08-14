Class {
	#name : #SmallUmlObjectDiagram,
	#superclass : #Object,
	#instVars : [
		'diagram',
		'lesson',
		'board'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
SmallUmlObjectDiagram >> borrarPosicionesDeLosNodos [
	board diagramNodes do: [ :node | node position: board randomPosition]. 
]

{ #category : #'as yet unclassified' }
SmallUmlObjectDiagram >> diagram [
	^diagram
]

{ #category : #'as yet unclassified' }
SmallUmlObjectDiagram >> diagramMorph [
	board := DiagramWhiteboard new model: self. 

	board update.
	^board.
]

{ #category : #'as yet unclassified' }
SmallUmlObjectDiagram >> diagramNodes [
	^diagram diagramNodes
]

{ #category : #'as yet unclassified' }
SmallUmlObjectDiagram >> initialize [
	diagram := ObjectDiagram new.
]

{ #category : #'as yet unclassified' }
SmallUmlObjectDiagram >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #'as yet unclassified' }
SmallUmlObjectDiagram >> update [
	| graph |
	graph := lesson buildGraph.
	self diagram updateFromGraph: graph.
	board update.
]
