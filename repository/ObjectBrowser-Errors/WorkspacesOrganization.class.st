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
	^'Workspaces'
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> contents [
	^objectBrowser workspaces collect:[ :w | ListItemWrapper with: w model: w ]
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> menu: aMenu [
	^aMenu addList: (OrderedCollection with: #('crear nuevo workspace' #createWorkspace))
]

{ #category : #'as yet unclassified' }
WorkspacesOrganization >> objectBrowser: anObjectBrowser [
	objectBrowser := anObjectBrowser.
]
