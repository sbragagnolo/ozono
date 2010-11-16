Class {
	#name : #GraphvizObjectDiagram,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'morph'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
GraphvizObjectDiagram >> diagramMorph [
	^morph ifNil:[morph := GraphVizGraphMorph new initialize: lesson; yourself.]
]

{ #category : #exporting }
GraphvizObjectDiagram >> exportDiagram [
	self diagramMorph exportAsJPEG
]

{ #category : #'as yet unclassified' }
GraphvizObjectDiagram >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #'as yet unclassified' }
GraphvizObjectDiagram >> update [
	morph update
]
