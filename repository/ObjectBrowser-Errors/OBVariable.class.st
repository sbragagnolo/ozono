Class {
	#name : #OBVariable,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBVariable class >> newNamed: variableName [

	^self new
		name: variableName;
		yourself 
]

{ #category : #messages }
OBVariable >> errorNotIndexable [
	"Create an error notification that the receiver is not indexable."

	self error: ('Instances of {1} are not indexable' translated format: {self pointsTo printString})
]

{ #category : #'as yet unclassified' }
OBVariable >> name [
	^name
]

{ #category : #'as yet unclassified' }
OBVariable >> name: aNameString [
	name := aNameString
]
