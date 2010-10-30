Class {
	#name : #LOOPObjectDiagramFactory,
	#superclass : #Object,
	#classVars : [
		'DiagramClass'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
LOOPObjectDiagramFactory class >> buildDiagram [
	^self diagramClass new.
]

{ #category : #'as yet unclassified' }
LOOPObjectDiagramFactory class >> diagramClass [
	DiagramClass ifNil: [ DiagramClass := SmallUmlObjectDiagram ].
	^ DiagramClass.
]

{ #category : #'as yet unclassified' }
LOOPObjectDiagramFactory class >> diagramClass: theClass [
"GraphvizObjectDiagram - SmallUmlObjectDiagram ."
	DiagramClass := theClass .
]
