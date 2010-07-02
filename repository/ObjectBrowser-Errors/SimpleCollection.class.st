Class {
	#name : #SimpleCollection,
	#superclass : #ObjectBrowserClass,
	#instVars : [
		'colection'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
SimpleCollection class >> new [
	^self error: 'Se debe especificar el sabor de coleccion a instanciar'
]

{ #category : #'as yet unclassified' }
SimpleCollection class >> newBag [
	"A diferencia de los demás objetos, las colecciones deben inicializarse"
	^super new initializeBag.
]

{ #category : #'as yet unclassified' }
SimpleCollection class >> newOrdered [
	"A diferencia de los demás objetos, las colecciones deben inicializarse"
	^super new initializeOrdered.
]

{ #category : #'as yet unclassified' }
SimpleCollection class >> newSet [
	"A diferencia de los demás objetos, las colecciones deben inicializarse"
	^super new initializeSet.
]

{ #category : #'object browser' }
SimpleCollection >> a [
	^2
]

{ #category : #collection }
SimpleCollection >> add: anObject [
	colection add: anObject
]

{ #category : #collection }
SimpleCollection >> allSatisfy: aBlock [
	^colection allSatisfy: aBlock
]

{ #category : #collection }
SimpleCollection >> anySatisfy: aBlock [
	^colection anySatisfy: aBlock
]

{ #category : #collection }
SimpleCollection >> collect: aBlock [
	^self class new: (colection collect: aBlock)
]

{ #category : #collection }
SimpleCollection >> do: aBlock [
	^colection do: aBlock
]

{ #category : #collection }
SimpleCollection >> includes: anObject [
	^colection includes: anObject
]

{ #category : #initialization }
SimpleCollection >> initializeBag [
	colection := Bag  new
]

{ #category : #initialization }
SimpleCollection >> initializeOrdered [ 
	colection := OrderedCollection  new
]

{ #category : #initialization }
SimpleCollection >> initializeSet [
	colection := Set new
]

{ #category : #collection }
SimpleCollection >> inject: aValue into: aBlock [
	^colection inject: aValue into: aBlock
]

{ #category : #collection }
SimpleCollection >> isEmpty [
	^colection isEmpty
]

{ #category : #collection }
SimpleCollection >> printString [
	| elementsStrings theCollection |
	colection
		ifEmpty: [^ 'Empty collection'].
	theCollection := colection asOrderedCollection.
	elementsStrings := theCollection allButFirst
				inject: theCollection first printString
				into: [:acum :each | acum , ' ' , each printString].
	^ '(' , elementsStrings , ')'
]

{ #category : #collection }
SimpleCollection >> remove: anObject [ 
	colection
		remove: anObject
		ifAbsent: [self error: 'el objeto ' , anObject printString , ' no se encuentra en la coleccion ']
]

{ #category : #collection }
SimpleCollection >> select: aBlock [
	^self class new: (colection select: aBlock)
]

{ #category : #collection }
SimpleCollection >> set: aSet [
	colection := aSet.
]

{ #category : #collection }
SimpleCollection >> size [
	^colection size
]
