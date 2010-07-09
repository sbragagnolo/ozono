Class {
	#name : #OBVariable,
	#superclass : #Object,
	#instVars : [
		'name',
		'reference'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBVariable >> <- anObject [
	(LOOPLesson currentLesson hasVariable: anObject) 
		ifTrue:[self pointTo: anObject pointsTo]
		ifFalse:[self pointTo: (ObjectBrowserObject new realObject: anObject)]
	
	
]

{ #category : #'as yet unclassified' }
OBVariable >> desreference [
	self pointTo: nil
]

{ #category : #messages }
OBVariable >> doesNotUnderstand: aMessage [
	^self pointsTo perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #messages }
OBVariable >> errorNotIndexable [
	"Create an error notification that the receiver is not indexable."

	self error: ('Instances of {1} are not indexable' translated format: {self pointsTo printString})
]

{ #category : #'as yet unclassified' }
OBVariable >> isPointingTo: anObject [
	^reference = anObject
]

{ #category : #'as yet unclassified' }
OBVariable >> name [
	^name
]

{ #category : #'as yet unclassified' }
OBVariable >> name: aNameString [
	name := aNameString
]

{ #category : #'as yet unclassified' }
OBVariable >> pointTo: anObject [
	reference := anObject
]

{ #category : #'as yet unclassified' }
OBVariable >> pointsTo [
	^reference
]

{ #category : #'as yet unclassified' }
OBVariable >> printString [ 
	^self name
]
