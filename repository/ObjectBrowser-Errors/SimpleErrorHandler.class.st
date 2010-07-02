Class {
	#name : #SimpleErrorHandler,
	#superclass : #ErrorHandler,
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
SimpleErrorHandler >> value [
	"evaluo mi bloque o manejo el error"

	block
		on: Error
		do: [:error | UIManager default inform: error messageText ]
]
