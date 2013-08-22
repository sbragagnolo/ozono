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
GraphVizGraphMorph >> doUpdate [
	| graph morphGraph loopgraph |
	loopgraph := lesson buildGraph.
	graph := GraphViz new.
	graph beDirected.
	graph add: #node with: { #id->#asString }.
	loopgraph objectBrowserObjects do:[ :h |
			graph add: h with: #label->(h displayString copyReplaceAll: ' ' with: '').
		].
	loopgraph references do:[ :r |
			graph add: r from with: #label->(r from displayString copyReplaceAll: ' ' with: '').
			graph add: r to with: #label->(r to displayString copyReplaceAll: ' ' with: '').
			graph add: r from -> r to with: {#label->(r name copyReplaceAll: ' ' with: '')}.
		].
	self removeAllMorphs.
	morphGraph := graph asMorph.
	self addMorph: morphGraph.
]

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
	Cursor wait showWhile:[ self doUpdate ]
]
