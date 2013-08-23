Class {
	#name : #OBListModel,
	#superclass : #OBAbstractModel,
	#instVars : [
		'selectedObject',
		'menuSelector'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBListModel >> colorAt: index [
	^Color black
]

{ #category : #'as yet unclassified' }
OBListModel >> fontAt: index withBasicFont: font [
	^font
]

{ #category : #'as yet unclassified' }
OBListModel >> iconAt: anAttribute [
	^anAttribute icon
]

{ #category : #'as yet unclassified' }
OBListModel >> listIndex [
	^self listModel indexOf: self selectedItem
]

{ #category : #'as yet unclassified' }
OBListModel >> listIndex: anIndex [

	anIndex > 0 ifTrue:[
	self selectedItem: (self listModel asOrderedCollection at: anIndex).
	self changed: #listIndex:
	].
]

{ #category : #'as yet unclassified' }
OBListModel >> listKey: aChar from: view [
	"Responde cuando se presiona un bot󮠥n la lista de objetos."

"	aChar == $f ifTrue: [^ self findMethod].
	aChar == $r ifTrue: [^ self recent].
	aChar == $h ifTrue: [^ self spawnHierarchy].
	aChar == $x ifTrue: [^ self removeClass].
	^ self messageListKey: aChar from: view"
]

{ #category : #'as yet unclassified' }
OBListModel >> listMenu: aMenu shifted: shifted [
	^self model perform: self menuSelector with: aMenu with: shifted 
]

{ #category : #'as yet unclassified' }
OBListModel >> menuSelector [
	^#listMenu:shifted:
]

{ #category : #'as yet unclassified' }
OBListModel >> update: anObject [ 
	super update: anObject.
	self changed: #listModel
]
