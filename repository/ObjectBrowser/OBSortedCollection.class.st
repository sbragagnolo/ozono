"
The Object Browser implementation of the SortedCollection collection.
It has the metaObject.
"
Class {
	#name : #OBSortedCollection,
	#superclass : #SortedCollection,
	#traits : 'TOBCollection',
	#classTraits : 'TOBCollection classTrait',
	#instVars : [
		'_metaObject'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #accessing }
OBSortedCollection >> metaObject [

	^_metaObject
]

{ #category : #accessing }
OBSortedCollection >> metaObject: aMetaObject [

	_metaObject ifNotNil: [ self error: 'No se puede cambiar el metaObject de un objeto' ].
	_metaObject := aMetaObject.
]
