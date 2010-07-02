Class {
	#name : #SimpleOrderedCollection,
	#superclass : #SimpleCollection,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> add: newObject after: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject."
	colection add: newObject after: oldObject .
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> add: newObject afterIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	colection add: newObject afterIndex: index 
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."
	colection add: newObject before: oldObject 
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	colection add: newObject beforeIndex: index 
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> at: anInteger [ 
	"Answer my element at index anInteger. at: is used by a knowledgeable
	client to access an existing element"
	colection at: anInteger .
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> at: anInteger put: anObject [ 
	colection at: anInteger put: anObject 
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> first [ 
	colection first 
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> last [ 
	colection last
]

{ #category : #'as yet unclassified' }
SimpleOrderedCollection >> removeAt: index [
	colection removeAt: index
]
