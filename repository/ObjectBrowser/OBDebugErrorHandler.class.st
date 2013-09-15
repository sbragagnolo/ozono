"
I let the error continue its course so It opens a debugger.

Mainly for Debug
"
Class {
	#name : #OBDebugErrorHandler,
	#superclass : #OBErrorHandler,
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
OBDebugErrorHandler >> value [
	^block value
]
