Class {
	#name : #WorkspacesOrganization,
	#superclass : #Object,
	#instVars : [
		'objectBrowser'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
WorkspacesOrganization class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> asString [
	^'Workspaces' translated 
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> icon [
	^ObjectBrowserIcons folderIcon
]

{ #category : #selection }
WorkspacesOrganization >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser workspacesOrganizationSelected
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> menu: aMenu [
	^aMenu addList: (OrderedCollection 
		with: (Array braceWith: 'crear nuevo workspace' translated with: #createWorkspace )
		with: (Array braceWith: 'importar workspace' translated with: #fileInWorkspace))
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> objectBrowser: anObjectBrowser [
	objectBrowser := anObjectBrowser.
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> treeContents [
	^objectBrowser workspaces collect:[ :w | OBListItemWrapper with: w model: w ]
]
