Class {
	#name : #LessonListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
LessonListModel >> listModel [
	^self model lessons asOrderedCollection.
]

{ #category : #'as yet unclassified' }
LessonListModel >> menuSelector [
	^#lessonListMenu:shifted:
]

{ #category : #'as yet unclassified' }
LessonListModel >> selectedItem [
	^self model selectedLesson
]

{ #category : #'as yet unclassified' }
LessonListModel >> selectedItem: aLesson [
	self model selectedLesson: aLesson.
	self model changed.
]
