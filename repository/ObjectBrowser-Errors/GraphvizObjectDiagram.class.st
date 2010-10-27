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
	^GraphVizGraphMorph new initialize: lesson; yourself.
]

{ #category : #'as yet unclassified' }
GraphvizObjectDiagram >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #'as yet unclassified' }
GraphvizObjectDiagram >> update [
	"Nada por ahora"
]
