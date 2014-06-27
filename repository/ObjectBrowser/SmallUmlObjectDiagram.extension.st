Extension { #name : #SmallUmlObjectDiagram }

{ #category : #'*ObjectBrowser' }
SmallUmlObjectDiagram >> imageForm [
	^self diagramMorph imageFormForRectangle: (self diagramMorph bounds).
]
