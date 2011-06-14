Class {
	#name : #LessonNode,
	#superclass : #ObjectNode,
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
LessonNode >> view [
	"self halt."
	^(LessonNodeMorph new diagramNode: self) position: (100 atRandom)@(100 atRandom)
]
