Class {
	#name : #LessonNodeMorph,
	#superclass : #DiagramNodeMorph,
	#instVars : [
		'boundingBox'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
LessonNodeMorph >> connectableBounds [
	^boundingBox 
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> diagramNode: aDiagramNode [
	diagramNode  := aDiagramNode.
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> initialize [ 
	super initialize.
	self color: Color transparent.
	self extent: 1000@10. 
	boundingBox := ConnectableBoundingBox new. self addMorph: boundingBox. boundingBox goBehind. 
	boundingBox borderStyle: BorderStyle thinGray.
	boundingBox fillStyle: Color white.
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> mouseDown: evt [
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> mouseMove: evt [

]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> mouseUp: evt [
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> noteNewOwner: aMorph [
	self position: aMorph position - (0 @ 10).
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> resetConnections [
	self relations: Set new.
]

{ #category : #accessing }
LessonNodeMorph >> subject [
	^ diagramNode
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> updateBounds [

	boundingBox bounds: self bounds.
	boundingBox updateView.
	boundingBox updateLayout.
]

{ #category : #'as yet unclassified' }
LessonNodeMorph >> updateView [
	boundingBox updateView
]
