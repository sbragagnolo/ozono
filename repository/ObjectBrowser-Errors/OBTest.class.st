Class {
	#name : #OBTest,
	#superclass : #Object,
	#instVars : [
		'selector',
		'lesson'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBTest class >> new: aTestSelector [
	^self new
		selector: aTestSelector;
		yourself
]

{ #category : #'as yet unclassified' }
OBTest class >> newText: aTestSelector onLesson: aLesson [
	^self new
		selector: aTestSelector;
		lesson: aLesson;
		yourself
]

{ #category : #'as yet unclassified' }
OBTest >> code [
	^lesson executionContext methodDict at: selector
]

{ #category : #'as yet unclassified' }
OBTest >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #'as yet unclassified' }
OBTest >> printString [
	^selector 
]

{ #category : #'as yet unclassified' }
OBTest >> selector: aTestSelector [
	selector := aTestSelector
]
