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
GraphVizGraphMorph >> initialize: alesson [
	lesson := alesson.
	self update.
	^self
]

{ #category : #'as yet unclassified' }
GraphVizGraphMorph >> update [
	| graph |
	graph := GraphViz new.
	graph beDirected.
	lesson buildGraph references do:[ :r |
			graph add: r from -> r to.
		].
	self addMorph: graph asMorph.
]
