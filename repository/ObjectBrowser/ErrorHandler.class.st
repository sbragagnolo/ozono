"
An object that evaluates a Block.
If an error occurrs during evaluation, the handler takes it and does something with the error.
"
Class {
	#name : #ErrorHandler,
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
ErrorHandler class >> default [
	^DefaultErrorHandler ifNil: [DefaultErrorHandler := SimpleErrorHandler]
]

{ #category : #'as yet unclassified' }
ErrorHandler class >> default: aDefaultErrorHandler [
	^DefaultErrorHandler := aDefaultErrorHandler
]

{ #category : #'as yet unclassified' }
ErrorHandler class >> evaluate: aBlock [ 
	^self default new block: aBlock;
		 value
]

{ #category : #installing }
ErrorHandler class >> install [
	self default: self.
]

{ #category : #'as yet unclassified' }
ErrorHandler >> block: aBlock [
	"me pasan el bloque que voy a intentar evaluar"

	block := aBlock
]

{ #category : #'as yet unclassified' }
ErrorHandler >> value [
	"evaluo mi bloque o manejo el error"

	self subclassResponsibility
]
