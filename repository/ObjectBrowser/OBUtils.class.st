Class {
	#name : #OBUtils,
	#superclass : #Object,
	#category : #'ObjectBrowser-Fileout'
}

{ #category : #'as yet unclassified' }
OBUtils class >> legalSelectorFor: aString [
	"'234znak 43 ) 2' asLegalSelector2"

	| toUse |
	toUse := aString select: [ :char | char isAlphaNumeric ].
	(toUse size = 0 or: [ toUse first isLetter not ])
		ifTrue: [ toUse := 'v' , toUse ].
	aString ifEmpty: [ self error: 'a selector cannot be empty' ].
	toUse at: 1 put: toUse first asLowercase.
	^ toUse
]
