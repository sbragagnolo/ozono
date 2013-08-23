Class {
	#name : #OBWorkspacesTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBWorkspacesTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
OBWorkspacesTreeMenuNode >> asString [
	^'Workspaces' translated 
]

{ #category : #'as yet unclassified' }
OBWorkspacesTreeMenuNode >> icon [
	^OBIcons folderIcon
]

{ #category : #selection }
OBWorkspacesTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser workspacesOrganizationSelected
]

{ #category : #'as yet unclassified' }
OBWorkspacesTreeMenuNode >> menu: aMenu [
	^aMenu addList: (OrderedCollection 
		with: (Array braceWith: 'crear nuevo workspace' translated with: #createWorkspace )
		with: (Array braceWith: 'importar workspace' translated with: #fileInWorkspace))
]

{ #category : #'as yet unclassified' }
OBWorkspacesTreeMenuNode >> treeContents [
	^objectBrowser workspaces collect:[ :w | OBListItemWrapper with: w model: w ]
]
