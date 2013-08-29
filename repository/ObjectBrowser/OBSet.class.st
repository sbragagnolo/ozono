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

{ #category : #accessing }
OBSet >> metaObject [

	^_metaObject
]

{ #category : #accessing }
OBSet >> metaObject: aMetaObject [

	_metaObject ifNotNil: [ self error: 'No se puede cambiar el metaObject de un objeto' ].
	_metaObject := aMetaObject.
]
