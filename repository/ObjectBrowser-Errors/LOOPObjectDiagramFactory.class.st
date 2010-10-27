Class {
	#name : #LOOPObjectDiagramFactory,
	#superclass : #Object,
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
LOOPObjectDiagramFactory class >> buildDiagram [
	^SmallUmlObjectDiagram new.
]
