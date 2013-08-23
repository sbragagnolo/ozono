Class {
	#name : #OBDiagramTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBDiagramTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
OBDiagramTreeMenuNode >> asString [
	^'Diagrama' translated 
]

{ #category : #'as yet unclassified' }
OBDiagramTreeMenuNode >> icon [
	^OBIcons diagramsIcon
]

{ #category : #'as yet unclassified' }
OBDiagramTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser selectedPage: #diagram.
	anObjectBrowser changed.
]

{ #category : #'as yet unclassified' }
OBDiagramTreeMenuNode >> menu: aMenu [
	aMenu add: 'exportar' translated action: #exportDiagram.	
^aMenu.
]

{ #category : #'as yet unclassified' }
OBDiagramTreeMenuNode >> treeContents [
	^#()
]
