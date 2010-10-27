Extension { #name : #ObjectDiagram }

{ #category : #'*ObjectBrowser-Diagrams' }
ObjectDiagram >> updateFromGraph: aLessonGraph [
	self updateDiagramNodesFrom: aLessonGraph objects.
	self resetConnections.
	aLessonGraph references do:[:reference |
		(self diagramNodeFor: reference from) connectTo: (self diagramNodeFor: reference to) using: (AssociationRelationship new label: reference name) ]
]
