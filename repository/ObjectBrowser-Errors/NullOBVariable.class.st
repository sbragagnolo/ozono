Class {
	#name : #NullOBVariable,
	#superclass : #Object,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
NullOBVariable >> actionsForAttributeList [
	^#()
]

{ #category : #'as yet unclassified' }
NullOBVariable >> pointsTo [
	^NullObjectBrowserObject new.
]
