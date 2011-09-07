Class {
	#name : #SimpleErrorHandler,
	#superclass : #ErrorHandler,
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
SimpleErrorHandler >> blockForError [
	^ [:error | UIManager default inform: error messageText. nil ]
]

{ #category : #'as yet unclassified' }
SimpleErrorHandler >> blockForMessageNotUnderstood [
^ [:dnu | | nombreObjeto |
			(dnu receiver isKindOf: ObjectBrowserClass) 
				ifTrue: [ nombreObjeto := dnu receiver displayString ] 
				ifFalse: [ nombreObjeto := dnu receiver printString ].
			UIManager default inform:
				 (nombreObjeto  ,' no entiende el mensaje ', dnu message printString).
				nil ]
]

{ #category : #'as yet unclassified' }
SimpleErrorHandler >> blockForOperationCancelled [
	
	^ ["nothing: an Operation Cancelled should not be warned nor explained, just must keep doing what the user was doing"]
]

{ #category : #'as yet unclassified' }
SimpleErrorHandler >> blockForSyntaxErrorNotification [ 
	^ [ :error | UIManager default inform: 'Ha ocurrido un error de sintaxis:  ', error errorCode. nil ]
]

{ #category : #'as yet unclassified' }
SimpleErrorHandler >> value [
	"evaluo mi bloque o manejo el error"

	^[[[block 
	  on: OperationCancelled do: 
		self blockForOperationCancelled
	] on: MessageNotUnderstood do: 
		self blockForMessageNotUnderstood.
	] on: SyntaxErrorNotification do:
		self blockForSyntaxErrorNotification 
	] on: Error do: 
		self blockForError
]
