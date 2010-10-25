Class {
	#name : #NullOBVariable,
	#superclass : #Object,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
NullOBVariable >> actionsForAttributeList [
	^#()
]

{ #category : #notifying }
NullOBVariable >> notifySelectionTo: anObjectBrowser [ 
	"Nothing"
]

{ #category : #'as yet unclassified' }
NullOBVariable >> pointsTo [
	^NullObjectBrowserObject new.
]
