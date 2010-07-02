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
OBVariable >> desreference [
	self pointsTo: nil
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
OBVariable >> pointsTo [
	^reference
]

{ #category : #'as yet unclassified' }
OBVariable >> pointsTo: anObject [
	reference := anObject
]

{ #category : #'as yet unclassified' }
OBVariable >> printString [ 
	^self name
]
