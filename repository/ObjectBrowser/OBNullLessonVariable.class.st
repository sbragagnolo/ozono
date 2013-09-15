"
I am a null object implying that no reference is selected in the lesson.
"
Class {
	#name : #OBNullLessonVariable,
	#superclass : #Object,
	#category : #'ObjectBrowser-UILesson'
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
