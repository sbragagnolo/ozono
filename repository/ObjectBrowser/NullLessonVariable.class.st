Class {
	#name : #NullLessonVariable,
	#superclass : #Object,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #ui }
NullLessonVariable >> actionsForAttributeList [
	^#()
]

{ #category : #notifying }
NullLessonVariable >> notifySelectionTo: anObjectBrowser [ 
	"Nothing"
]

{ #category : #references }
NullLessonVariable >> pointsTo [
	^NullObjectBrowserObject new.
]
