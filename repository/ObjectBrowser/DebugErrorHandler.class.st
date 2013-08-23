"
I let the error continue its course so It opens a debugger.

Mainly for Debug
"
Class {
	#name : #DebugErrorHandler,
	#superclass : #ErrorHandler,
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
DebugErrorHandler >> value [
	^block value
]
