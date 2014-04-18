"
The Object Browser implementation of the Set collection.
It has the metaObject.
"
Class {
	#name : #OBSet,
	#superclass : #Set,
	#traits : 'TOBCollection',
	#classTraits : 'TOBCollection classTrait',
	#instVars : [
		'_metaObject'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #printing }
OBSet >> collect: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Collect the resulting values into a collection like the receiver. Answer  
	the new collection."

      "I rewrite the implementation cause, Set's uses a Set new, not creating OBSet"

	| newSet |
	newSet := self copyEmpty.
	array do: [:each | each ifNotNil: [newSet add: (aBlock value: each enclosedSetElement)]].
	^ newSet
]

{ #category : #accessing }
OBSet >> metaObject [

	^_metaObject
]

{ #category : #accessing }
OBSet >> metaObject: aMetaObject [

	_metaObject ifNotNil: [ self error: 'No se puede cambiar el metaObject de un objeto' ].
	_metaObject := aMetaObject.
]
