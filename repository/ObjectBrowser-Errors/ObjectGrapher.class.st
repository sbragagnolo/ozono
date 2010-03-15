Class {
	#name : #ObjectGrapher,
	#superclass : #Object,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectGrapher >> show: anObjectBrowser [
	| graph nodes |
	graph := MOViewRenderer  new.
	graph shape ellipse 
		text: #printString;
		textHorizontalPadding: 5;
		textVerticalPadding: 5.
"	graph shape arrowedLine."
	graph nodes: anObjectBrowser createGraphNodes.
	graph edgeShape: MOArrowedLineShape new.
	graph edges: graph domain from: #yourself toAll: #references.
	graph forceBasedLayout .
	graph layout repellingForce: 25.
	graph open.
]
