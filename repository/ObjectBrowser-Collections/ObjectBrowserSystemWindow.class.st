Class {
	#name : #ObjectBrowserSystemWindow,
	#superclass : #SystemWindow,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserSystemWindow >> delete [
	self model closeWorkspaces.
	super delete.
]
