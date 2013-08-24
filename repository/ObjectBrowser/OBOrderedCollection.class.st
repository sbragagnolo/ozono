Class {
	#name : #OBOrderedCollection,
	#superclass : #OrderedCollection,
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
