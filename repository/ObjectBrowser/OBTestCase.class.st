Class {
	#name : #OBTestCase,
	#superclass : #TestCase,
	#instVars : [
		'currentLesson'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
OBTestCase >> executeOnWorkspace: aWorkspace code: aString [
	| textMorphs textMorph |
	aWorkspace setContent: aString.	"ws acceptContents: codigoParaWS."
	textMorphs := aWorkspace dependents select: [ :c | c isKindOf: PluggableTextMorph ].
	textMorph := textMorphs first.
	textMorph doIt
]

{ #category : #running }
OBTestCase >> setUp [
	"LOOPLesson currentLesson: LOOPLesson freeLesson."
	currentLesson := OBLesson new.
]

{ #category : #running }
OBTestCase >> tearDown [ 
	currentLesson clean.
	OBLesson lessons removeAll.
]
