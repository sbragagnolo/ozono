Class {
	#name : #LessonGraphReference,
	#superclass : #Object,
	#instVars : [
		'from',
		'to',
		'name'
	],
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
LessonGraphReference class >> from: aRealObject to: objectReferenced named: referenceName [
	^self new
		from: aRealObject to: objectReferenced named: referenceName
]

{ #category : #'as yet unclassified' }
LessonGraphReference >> from [
	^from
]

{ #category : #'as yet unclassified' }
LessonGraphReference >> from: aRealObject to: objectReferenced named: referenceName [
	from := aRealObject.
	to := objectReferenced.
	name := referenceName.
]

{ #category : #'as yet unclassified' }
LessonGraphReference >> name [
	^name
]

{ #category : #'as yet unclassified' }
LessonGraphReference >> to [
	^to
]
