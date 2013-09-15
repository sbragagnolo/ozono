"
The Object Browser implementation of the Bag collection.
It has the metaObject.
"
Class {
	#name : #OBBag,
	#superclass : #Bag,
	#traits : 'TOBCollection',
	#classTraits : 'TOBCollection classTrait',
	#instVars : [
		'_metaObject'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #accessing }
OBBag >> metaObject [

	^_metaObject
]

{ #category : #accessing }
OBBag >> metaObject: aMetaObject [

	_metaObject ifNotNil: [ self error: 'No se puede cambiar el metaObject de un objeto' ].
	_metaObject := aMetaObject.
]
