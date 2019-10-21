Extension { #name : #ObjectDiagram }

{ #category : #'*ObjectBrowser-Diagrams' }
ObjectDiagram >> updateFromGraph: aLessonGraph [
	self updateDiagramNodesFrom: aLessonGraph namedObjects.
	self
		addDiagramNode: (LessonNode for: aLessonGraph lesson named: aLessonGraph lesson name).
	self resetConnections.
	aLessonGraph references
		do: [ :reference | 
			(self diagramNodeFor: reference from)
				connectTo: (self diagramNodeFor: reference to)
				using: (ReferenceRelationship new label: reference name) ]
]
