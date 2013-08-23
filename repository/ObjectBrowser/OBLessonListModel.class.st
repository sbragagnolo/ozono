Class {
	#name : #OBLessonListModel,
	#superclass : #OBListModel,
	#category : #'ObjectBrowser-UILessonBrowser'
}

{ #category : #'as yet unclassified' }
OBLessonListModel >> listModel [
	^self model lessons asOrderedCollection.
]

{ #category : #'as yet unclassified' }
OBLessonListModel >> menuSelector [
	^#lessonListMenu:shifted:
]

{ #category : #'as yet unclassified' }
OBLessonListModel >> selectedItem [
	^self model selectedLesson
]

{ #category : #'as yet unclassified' }
OBLessonListModel >> selectedItem: aLesson [
	self model selectedLesson: aLesson.
	self model changed.
]
