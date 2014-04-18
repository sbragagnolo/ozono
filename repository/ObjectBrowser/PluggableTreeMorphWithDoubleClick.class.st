"
A PluggableTreeMorphWithDoubleClick that adds double click selector

"
Class {
	#name : #PluggableTreeMorphWithDoubleClick,
	#superclass : #PluggableTreeMorph,
	#instVars : [
		'doubleClickSelector'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
PluggableTreeMorphWithDoubleClick >> doubleClick: event [
	doubleClickSelector ifNil: [^super doubleClick: event].
	^ ((self itemFromPoint: (event position)) withoutListWrapper) perform: doubleClickSelector
]

{ #category : #'as yet unclassified' }
PluggableTreeMorphWithDoubleClick >> doubleClickSelector: aSelector [
	doubleClickSelector := aSelector
]

{ #category : #'as yet unclassified' }
PluggableTreeMorphWithDoubleClick >> mouseDown: event [
	 super mouseDown: event.
	event hand waitForClicksOrDrag: self event: event.
]
