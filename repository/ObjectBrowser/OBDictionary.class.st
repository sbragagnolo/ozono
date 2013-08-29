"
The Object Browser implementation of the Dictionary collection.
It has the metaObject.
"
Class {
	#name : #OBDictionary,
	#superclass : #Dictionary,
	#traits : 'TOBCollection',
	#classTraits : 'TOBCollection classTrait',
	#instVars : [
		'_metaObject'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #accessing }
OBDictionary >> metaObject [

	^_metaObject
]

{ #category : #accessing }
OBDictionary >> metaObject: aMetaObject [

	_metaObject ifNotNil: [ self error: 'No se puede cambiar el metaObject de un objeto' ].
	_metaObject := aMetaObject.
]
