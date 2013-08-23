Class {
	#name : #OBTraceGraphMode,
	#superclass : #OBGraphMode,
	#category : #'ObjectBrowser-Graph'
}

{ #category : #visiting }
OBTraceGraphMode >> passOnObject: anObject [

	graph traceObject: anObject.
]
