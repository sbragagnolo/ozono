Class {
	#name : #OBMarkGraphMode,
	#superclass : #OBGraphMode,
	#category : #'ObjectBrowser-Graph'
}

{ #category : #visiting }
OBMarkGraphMode >> passOnObject: anObject [

	graph markObject: anObject.
]
