Class {
	#name : #OBBag,
	#superclass : #Bag,
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
