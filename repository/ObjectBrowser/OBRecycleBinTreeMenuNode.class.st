Class {
	#name : #OBRecycleBinTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBRecycleBinTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
OBRecycleBinTreeMenuNode >> asString [
	^'Papelera' translated 
]

{ #category : #'as yet unclassified' }
OBRecycleBinTreeMenuNode >> icon [
	^OBIcons trashIcon
]

{ #category : #'as yet unclassified' }
OBRecycleBinTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 
	
]

{ #category : #'as yet unclassified' }
OBRecycleBinTreeMenuNode >> menu: aMenu [
	^aMenu addList: (OrderedCollection with: (Array braceWith: 'Recolectar basura' translated with: #runGarbageCollector))
]

{ #category : #'as yet unclassified' }
OBRecycleBinTreeMenuNode >> treeContents [
	^objectBrowser orphanObjects collect: [ :o | OBListItemWrapper with: o model: o ]
]
