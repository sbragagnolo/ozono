Class {
	#name : #OBNullLessonVariable,
	#superclass : #Object,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #ui }
OBNullLessonVariable >> actionsForAttributeList [
	^#()
]

{ #category : #notifying }
OBNullLessonVariable >> notifySelectionTo: anObjectBrowser [ 
	"Nothing"
]

{ #category : #references }
OBNullLessonVariable >> pointsTo [
	^OBNullObject new.
]
