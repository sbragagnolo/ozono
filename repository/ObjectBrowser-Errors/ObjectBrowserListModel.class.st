Class {
	#name : #ObjectBrowserListModel,
	#superclass : #ObjectModel,
	#instVars : [
		'selectedObject',
		'menuSelector'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> iconAt: anIndex [
	^(self selectedItem respondsTo: #icon) ifTrue: [ self selectedItem icon] ifFalse: [nil]
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> listIndex [
	^self listModel indexOf: self selectedItem
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> listIndex: anIndex [

	anIndex > 0 ifTrue:[
	self selectedItem: (self listModel at: anIndex).
	self changed: #listIndex:
	].
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> listKey: aChar from: view [
	"Responde cuando se presiona un bot󮠥n la lista de objetos."

"	aChar == $f ifTrue: [^ self findMethod].
	aChar == $r ifTrue: [^ self recent].
	aChar == $h ifTrue: [^ self spawnHierarchy].
	aChar == $x ifTrue: [^ self removeClass].
	^ self messageListKey: aChar from: view"
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> listMenu: aMenu shifted: shifted [
	^self model perform: self menuSelector with: aMenu with: shifted 
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> menuSelector [
	^#listMenu:shifted:
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> update: anObject [ 
	super update: anObject.
	self changed: #listModel
]
