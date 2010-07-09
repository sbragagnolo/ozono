"
Un objeto que sabe evaluar un bloque, y si ocurre un error tomar el mensaje y mostrarlo en un popup de informacion.
"
Class {
	#name : #ErrorHandler,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
ErrorHandler class >> default [
	^DebugErrorHandler 
]

{ #category : #'as yet unclassified' }
ErrorHandler class >> evaluate: aBlock [ 
	self new block: aBlock;
		 value
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
