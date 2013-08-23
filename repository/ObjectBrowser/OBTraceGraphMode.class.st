"
I am a mode to traverse the graph. I tell the graph to trace an object. That is, mark it as part of the graph.
"
Class {
	#name : #OBTraceGraphMode,
	#superclass : #OBGraphMode,
	#category : #'ObjectBrowser-Graph'
}

{ #category : #visiting }
OBTraceGraphMode >> passOnObject: anObject [

	graph traceObject: anObject.
]
