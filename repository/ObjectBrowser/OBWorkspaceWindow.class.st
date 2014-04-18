Class {
	#name : #OBWorkspaceWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'workspace'
	],
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
OBWorkspaceWindow >> acceptUnsavedChangesMessage [
	^'¿Desea guardar los cambios en el workspace antes de cerrar?'
]

{ #category : #'as yet unclassified' }
OBWorkspaceWindow >> close [
	(self hasUnacceptedEdits and: [ UIManager default confirm: (self acceptUnsavedChangesMessage) trueChoice: 'Si' falseChoice: 'No' ])
		ifTrue: [ workspace accept ].
	 ^super close.
	
]

{ #category : #'as yet unclassified' }
OBWorkspaceWindow >> workspace [
	^workspace
]

{ #category : #'as yet unclassified' }
OBWorkspaceWindow >> workspace: aWorkspace [
	workspace := aWorkspace.
]
