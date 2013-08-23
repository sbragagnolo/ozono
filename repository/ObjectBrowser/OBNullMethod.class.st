"
I am a null object implying that no method is selected.
"
Class {
	#name : #OBNullMethod,
	#superclass : #Object,
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #testing }
OBNullMethod >> isNil [

	^true
]

{ #category : #ui }
OBNullMethod >> menuItems [

	^#()
]

{ #category : #accessing }
OBNullMethod >> method [

	^nil
]
