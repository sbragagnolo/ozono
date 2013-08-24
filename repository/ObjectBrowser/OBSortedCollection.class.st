Class {
	#name : #OBSortedCollection,
	#superclass : #SortedCollection,
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
