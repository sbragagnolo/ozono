Class {
	#name : #GraphVizGraphMorph,
	#superclass : #Morph,
	#instVars : [
		'diagram',
		'lesson'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
GraphVizGraphMorph >> initialize [
	super initialize.
	self color: Color white.
]

{ #category : #'as yet unclassified' }
GraphVizGraphMorph >> initialize: alesson [
	lesson := alesson.
	self update.
	^self
]

{ #category : #'as yet unclassified' }
GraphVizGraphMorph >> update [
	| graph morphGraph |
	graph := GraphViz new.
	graph beDirected.
	graph add: #node with: { #id->#asString }.
	lesson buildGraph references do:[ :r |
			graph add: r from with: #label->r from displayString.
			graph add: r to with: #label->r to displayString.			
			graph add: r from -> r to with: {#label->r name}.
		].
	self removeAllMorphs.
	morphGraph := graph asMorph.
	morphGraph center: self center.
	self addMorph: morphGraph.
]
