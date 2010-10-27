Class {
	#name : #NullLessonVariable,
	#superclass : #Object,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
NullLessonVariable >> actionsForAttributeList [
	^#()
]

{ #category : #notifying }
NullLessonVariable >> notifySelectionTo: anObjectBrowser [ 
	"Nothing"
]

{ #category : #'as yet unclassified' }
NullLessonVariable >> pointsTo [
	^NullObjectBrowserObject new.
]
