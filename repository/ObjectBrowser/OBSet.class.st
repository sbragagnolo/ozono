Class {
	#name : #OBSet,
	#superclass : #Set,
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
