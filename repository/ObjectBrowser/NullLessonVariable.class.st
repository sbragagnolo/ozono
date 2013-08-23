Class {
	#name : #NullLessonVariable,
	#superclass : #Object,
	#category : #'ObjectBrowser-UI-Model'
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
	^OBNullObject new.
]
