Class {
	#name : #SimpleSet,
	#superclass : #ObjectBrowserClass,
	#instVars : [
		'set'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
SimpleSet class >> new [
	"A diferencia de los demás objetos, las colecciones deben inicializarse"
	^super new initialize
]

{ #category : #'as yet unclassified' }
SimpleSet class >> new: aSet [ 
	"A diferencia de los demás objetos, las colecciones deben
	inicializarse "
	^ self new set: aSet;
		 yourself
]

{ #category : #'object browser' }
SimpleSet >> a [
	^2
]

{ #category : #collection }
SimpleSet >> add: anObject [
	set add: anObject
]

{ #category : #collection }
SimpleSet >> allSatisfy: aBlock [
	^set allSatisfy: aBlock
]

{ #category : #collection }
SimpleSet >> anySatisfy: aBlock [
	^set anySatisfy: aBlock
]

{ #category : #collection }
SimpleSet >> collect: aBlock [
	^self class new: (set collect: aBlock)
]

{ #category : #collection }
SimpleSet >> do: aBlock [
	^set do: aBlock
]

{ #category : #collection }
SimpleSet >> includes: anObject [
	^set includes: anObject
]

{ #category : #initialization }
SimpleSet >> initialize [
	set := Set new
]

{ #category : #collection }
SimpleSet >> inject: aValue into: aBlock [
	^set inject: aValue into: aBlock
]

{ #category : #collection }
SimpleSet >> isEmpty [
	^set isEmpty
]

{ #category : #collection }
SimpleSet >> printString [
	| elementsStrings theCollection |
	set
		ifEmpty: [^ 'Empty collection'].
	theCollection := set asOrderedCollection.
	elementsStrings := theCollection allButFirst
				inject: theCollection first printString
				into: [:acum :each | acum , ' ' , each printString].
	^ '(' , elementsStrings , ')'
]

{ #category : #collection }
SimpleSet >> remove: anObject [ 
	set
		remove: anObject
		ifAbsent: [self error: 'el objeto ' , anObject printString , ' no se encuentra en la coleccion ']
]

{ #category : #collection }
SimpleSet >> select: aBlock [
	^self class new: (set select: aBlock)
]

{ #category : #collection }
SimpleSet >> set: aSet [
	set := aSet.
]

{ #category : #collection }
SimpleSet >> size [
	^set size
]
