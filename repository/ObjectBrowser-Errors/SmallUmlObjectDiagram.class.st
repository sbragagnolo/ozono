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
	self diagram updateDiagramNodesFrom: graph referenceHolders. "Clears the unreferenced objects and adds the new ones"
	self diagram resetConnections.
	self diagram connectNodes: graph references.
	board update.
]
