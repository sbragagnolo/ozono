"
I represent the diagram item in the left pane of the lesson browser
"
Class {
	#name : #OBDiagramTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
OBDiagramTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #accessing }
OBDiagramTreeMenuNode >> icon [

	^self icons diagramsIcon
]

{ #category : #selection }
OBDiagramTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 

	anObjectBrowser selectedPage: #diagram.
	anObjectBrowser changed.
]

{ #category : #'ui-actions' }
OBDiagramTreeMenuNode >> menu: aMenu [

	aMenu add: 'exportar' translated action: #exportDiagram.
	^ aMenu
]

{ #category : #accessing }
OBDiagramTreeMenuNode >> name [

	^'Diagrama' translated 
]

{ #category : #accessing }
OBDiagramTreeMenuNode >> treeContents [

	^#()
]
