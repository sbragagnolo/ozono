Class {
	#name : #SimpleErrorHandler,
	#superclass : #ErrorHandler,
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
SimpleErrorHandler >> value [
	"evaluo mi bloque o manejo el error"

	[block
		on: MessageNotUnderstood
		do: [:dnu | | nombreObjeto |
			(dnu receiver isKindOf: ObjectBrowserClass) 
				ifTrue: [ nombreObjeto := dnu receiver displayString ] 
				ifFalse: [ nombreObjeto := dnu receiver printString ].
			UIManager default inform:
				 (nombreObjeto  ,' no entiende el mensaje ', dnu message printString) ].
		] on: Error
		do: [:error | UIManager default inform: error messageText ]
]
