"
I am a mode to traverse the graph. I tell the graph to mark an object. That is, mark it as used.
"
Class {
	#name : #OBMarkGraphMode,
	#superclass : #OBGraphMode,
	#category : #'ObjectBrowser-Graph'
}

{ #category : #visiting }
OBMarkGraphMode >> passOnObject: anObject [

	graph markObject: anObject.
]
