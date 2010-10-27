Class {
	#name : #GraphvizObjectDiagram,
	#superclass : #Object,
	#instVars : [
		'lesson'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
GraphvizObjectDiagram >> diagramMorph [
	| graph nodes |
"	graph := MOViewRenderer  new.
	graph shape ellipse 
		text: #printString;
		textHorizontalPadding: 5;
		textVerticalPadding: 5.
	graph shape arrowedLine.
	graph nodes: anObjectBrowser createGraphNodes.
	graph edgeShape: MOArrowedLineShape new.
	graph edges: graph domain from: #yourself toAll: #references.
	graph forceBasedLayout .
	graph layout repellingForce: 25.
	graph open."
]

{ #category : #'as yet unclassified' }
GraphvizObjectDiagram >> lesson: aLesson [
	lesson := aLesson
]
