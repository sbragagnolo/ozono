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

{ #category : #'as yet unclassified' }
OBLessonGraphReference class >> from: aRealObject to: objectReferenced named: referenceName [
	^self new
		from: aRealObject to: objectReferenced named: referenceName
]

{ #category : #'as yet unclassified' }
OBLessonGraphReference >> from [
	^from
]

{ #category : #'as yet unclassified' }
OBLessonGraphReference >> from: aRealObject to: objectReferenced named: referenceName [
	from := aRealObject.
	to := objectReferenced.
	name := referenceName.
]

{ #category : #'as yet unclassified' }
OBLessonGraphReference >> name [
	^name
]

{ #category : #'as yet unclassified' }
OBLessonGraphReference >> to [
	^to
]
