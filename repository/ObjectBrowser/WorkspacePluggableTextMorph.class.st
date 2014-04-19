"
Sobrescribe unos métodos de PluggableTextMorph para triggerear un evento de que cambió la lección.
Así se refresca la ventana principal que muestra el estado interno.

"
Class {
	#name : #WorkspacePluggableTextMorph,
	#superclass : #PluggableTextMorph,
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
WorkspacePluggableTextMorph >> handleEdit: editBlock [
	| result |
	result := super handleEdit: editBlock.
	"triggers a model changed to refresh"
	self model changed.
	^result
]

{ #category : #'as yet unclassified' }
WorkspacePluggableTextMorph >> printIt [
	super printIt.
	model changed.
]
