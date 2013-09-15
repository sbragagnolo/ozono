"
I am a reference in the graph of the lesson
"
Class {
	#name : #OBLessonGraphReference,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'name'
	],
	#category : #'ObjectBrowser-Graph'
}

{ #category : #'initialize-release' }
OBLessonGraphReference class >> from: aRealObject to: objectReferenced named: referenceName [
	^self new
		from: aRealObject to: objectReferenced named: referenceName
]

{ #category : #accessing }
OBLessonGraphReference >> from [
	^from
]

{ #category : #'initialize-release' }
OBLessonGraphReference >> from: aRealObject to: objectReferenced named: referenceName [
	from := aRealObject.
	to := objectReferenced.
	name := referenceName.
]

{ #category : #accessing }
OBLessonGraphReference >> name [
	^name
]

{ #category : #accessing }
OBLessonGraphReference >> to [
	^to
]
