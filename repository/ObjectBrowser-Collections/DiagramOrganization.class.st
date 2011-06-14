Class {
	#name : #DiagramOrganization,
	#superclass : #Object,
	#instVars : [
		'objectBrowser'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
DiagramOrganization class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
DiagramOrganization >> asString [
	^'Diagrama'
]

{ #category : #'as yet unclassified' }
DiagramOrganization >> icon [
	^ObjectBrowserIcons diagramsIcon
]

{ #category : #'as yet unclassified' }
DiagramOrganization >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser selectedPage: #diagram.
	anObjectBrowser changed.
]

{ #category : #'as yet unclassified' }
DiagramOrganization >> menu: aMenu [
	aMenu add: 'exportar' action: #exportDiagram.
	aMenu add: 'borrar posiciones' action: #borrarPosicionesDeLosNodos.
	
^aMenu.
]

{ #category : #'as yet unclassified' }
DiagramOrganization >> objectBrowser: anObjectBrowser [
	objectBrowser := anObjectBrowser
]

{ #category : #'as yet unclassified' }
DiagramOrganization >> treeContents [
	^#()
]
