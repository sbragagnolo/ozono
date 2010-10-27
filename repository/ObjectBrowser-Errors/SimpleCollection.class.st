Class {
	#name : #SimpleCollection,
	#superclass : #ObjectBrowserClass,
	#instVars : [
		'colection',
		'prototype'
	],
	#category : #'ObjectBrowser-Collections'
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

{ #category : #initialization }
SimpleCollection >> addAll: aCollection [
	colection addAll: aCollection.
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
	^self prototype clone addAll: (colection collect: aBlock)
]

{ #category : #collection }
SimpleCollection >> displayString [
	^prototype printString
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
	colection := Bag  new.
	prototype:= bag.
]

{ #category : #initialization }
SimpleCollection >> initializeOrdered [ 
	colection := OrderedCollection  new.
	prototype := ordered.
]

{ #category : #initialization }
SimpleCollection >> initializeSet [
	colection := Set new.
	prototype := set.
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
	theCollection := colection asOrderedCollection.
	elementsStrings := theCollection
				inject: ''
				into: [:acum :each | acum , ' ' , each printString].
	^ self displayString , '(' , elementsStrings , ')'
]

{ #category : #collection }
SimpleCollection >> prototype [ 
	^prototype .
]

{ #category : #collection }
SimpleCollection >> remove: anObject [ 
	colection
		remove: anObject
		ifAbsent: [self error: 'el objeto ' , anObject printString , ' no se encuentra en la coleccion ']
]

{ #category : #collection }
SimpleCollection >> select: aBlock [
	^self prototype clone addAll:  (colection select: aBlock)
]

{ #category : #collection }
SimpleCollection >> size [
	^colection size
]
