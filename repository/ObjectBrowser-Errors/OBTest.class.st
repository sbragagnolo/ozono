Class {
	#name : #OBTest,
	#superclass : #Object,
	#instVars : [
		'selector',
		'lesson'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
OBTest class >> newText: aTestSelector onLesson: aLesson [
	^self new
		selector: aTestSelector;
		lesson: aLesson;
		yourself
]

{ #category : #'as yet unclassified' }
OBTest >> code [
	^lesson executionContext class sourceCodeAt: selector
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
OBTest >> selector [
	^selector
]

{ #category : #'as yet unclassified' }
OBTest >> selector: aTestSelector [
	selector := aTestSelector
]
