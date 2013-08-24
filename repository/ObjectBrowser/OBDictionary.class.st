Class {
	#name : #OBDictionary,
	#superclass : #Dictionary,
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
