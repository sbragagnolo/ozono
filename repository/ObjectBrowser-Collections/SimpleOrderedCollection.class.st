Class {
	#name : #SimpleOrderedCollection,
	#superclass : #SimpleCollection,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #collection }
SimpleOrderedCollection >> add: newObject after: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just succeeding oldObject. Answer newObject."
	^colection add: newObject after: oldObject .
]

{ #category : #collection }
SimpleOrderedCollection >> add: newObject afterIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	^colection add: newObject afterIndex: index 
]

{ #category : #collection }
SimpleOrderedCollection >> add: newObject before: oldObject [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just preceding oldObject. Answer newObject."
	^colection add: newObject before: oldObject 
]

{ #category : #collection }
SimpleOrderedCollection >> add: newObject beforeIndex: index [ 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	^colection add: newObject beforeIndex: index 
]

{ #category : #collection }
SimpleOrderedCollection >> at: anInteger [ 
	"Answer my element at index anInteger. at: is used by a knowledgeable
	client to access an existing element"
	^colection at: anInteger .
]

{ #category : #collection }
SimpleOrderedCollection >> at: anInteger put: anObject [ 
	^colection at: anInteger put: anObject 
]

{ #category : #collection }
SimpleOrderedCollection >> first [ 
	^colection first 
]

{ #category : #collection }
SimpleOrderedCollection >> last [ 
	^colection last
]

{ #category : #collection }
SimpleOrderedCollection >> removeAt: index [
	^colection removeAt: index
]
