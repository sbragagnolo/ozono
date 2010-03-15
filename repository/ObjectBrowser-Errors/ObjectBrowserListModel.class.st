Class {
	#name : #ObjectBrowserListModel,
	#superclass : #ObjectModel,
	#instVars : [
		'selectedObject'
	],
	#category : #'ObjectBrowser-UI'
}

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
	"Responde cuando se presiona un boton la lista de objetos."

"	aChar == $f ifTrue: [^ self findMethod].
	aChar == $r ifTrue: [^ self recent].
	aChar == $h ifTrue: [^ self spawnHierarchy].
	aChar == $x ifTrue: [^ self removeClass].
	^ self messageListKey: aChar from: view"
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> listMenu: aMenu shifted: shifted [
	"Default dows nothing"
]

{ #category : #'as yet unclassified' }
ObjectBrowserListModel >> update: anObject [ 
	super update: anObject.
	self changed: #listModel
]
