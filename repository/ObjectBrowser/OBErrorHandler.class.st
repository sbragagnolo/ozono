"
An object that evaluates a Block.
If an error occurrs during evaluation, the handler takes it and does something with the error.
"
Class {
	#name : #OBErrorHandler,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#classVars : [
		'DefaultErrorHandler'
	],
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
OBErrorHandler class >> default [
	^DefaultErrorHandler ifNil: [DefaultErrorHandler := OBSimpleErrorHandler]
]

{ #category : #'as yet unclassified' }
OBErrorHandler class >> default: aDefaultErrorHandler [
	^DefaultErrorHandler := aDefaultErrorHandler
]

{ #category : #'as yet unclassified' }
OBErrorHandler class >> evaluate: aBlock [ 
	^self default new block: aBlock;
		 value
]

{ #category : #installing }
OBErrorHandler class >> install [
	self default: self.
]

{ #category : #'as yet unclassified' }
OBErrorHandler >> block: aBlock [
	"me pasan el bloque que voy a intentar evaluar"

	block := aBlock
]

{ #category : #'as yet unclassified' }
OBErrorHandler >> value [
	"evaluo mi bloque o manejo el error"

	self subclassResponsibility
]
