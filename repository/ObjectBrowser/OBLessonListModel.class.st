"
I am the model of the lesson list in the lesson browser window.
"
Class {
	#name : #OBLessonListModel,
	#superclass : #OBListModel,
	#category : #'ObjectBrowser-UILessonBrowser'
}

{ #category : #showing }
OBLessonListModel >> listMenu: aMenu shifted: shifted [

	^aMenu addList: self model selectedLesson menuActions.
]

{ #category : #'as yet unclassified' }
OBLessonListModel >> listModel [

	^self model lessons asOrderedCollection.
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
