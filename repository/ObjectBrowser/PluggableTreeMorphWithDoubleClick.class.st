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
	^ (self selectedItemFrom: event) perform: doubleClickSelector
]

{ #category : #'as yet unclassified' }
PluggableTreeMorphWithDoubleClick >> doubleClickSelector: aSelector [
	doubleClickSelector := aSelector
]

{ #category : #'as yet unclassified' }
PluggableTreeMorphWithDoubleClick >> mouseDown: event [
	event yellowButtonPressed
		ifTrue: [ self updateSelectionForEvent: event ].
	super mouseDown: event.
	event hand waitForClicksOrDrag: self event: event
]

{ #category : #'as yet unclassified' }
PluggableTreeMorphWithDoubleClick >> selectedItemFrom: event [
	^ (self itemFromPoint: event position) withoutListWrapper
]

{ #category : #'as yet unclassified' }
PluggableTreeMorphWithDoubleClick >> updateSelectionForEvent: event [
	self model perform: setSelectionSelector with: (self selectedItemFrom: event)
]
