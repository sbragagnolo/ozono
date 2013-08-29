"
The Object Browser implementation of the Ordered collection.
It has the metaObject.
"
Class {
	#name : #OBOrderedCollection,
	#superclass : #OrderedCollection,
	#traits : 'TOBCollection',
	#classTraits : 'TOBCollection classTrait',
	#instVars : [
		'_metaObject'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #accessing }
OBOrderedCollection >> metaObject [

	^_metaObject
]

{ #category : #accessing }
OBOrderedCollection >> metaObject: aMetaObject [

	_metaObject ifNotNil: [ self error: 'No se puede cambiar el metaObject de un objeto' ].
	_metaObject := aMetaObject.
]
