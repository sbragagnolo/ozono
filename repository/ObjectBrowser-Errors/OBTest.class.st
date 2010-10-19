Class {
	#name : #OBTest,
	#superclass : #Object,
	#instVars : [
		'selector'
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
OBTest >> selector: aTestSelector [
	selector := aTestSelector
]
