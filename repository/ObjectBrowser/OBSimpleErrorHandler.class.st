"
I trap the error and show it as a pop up.

Mainly for Release
"
Class {
	#name : #OBSimpleErrorHandler,
	#superclass : #OBErrorHandler,
	#category : #'ObjectBrowser-Errors'
}

{ #category : #'as yet unclassified' }
OBSimpleErrorHandler >> blockForError [
	^ [ :error | 
	UIManager default inform: error messageText.
	nil ]
]

{ #category : #'as yet unclassified' }
OBSimpleErrorHandler >> blockForMessageNotUnderstood [
	^ [ :dnu | 
	| nombreObjeto |
	nombreObjeto := dnu receiver printString.
	UIManager default inform: nombreObjeto , ' no entiende el mensaje ' , dnu message printString.
	nil ]
]

{ #category : #'as yet unclassified' }
OBSimpleErrorHandler >> blockForOperationCancelled [
	^ [ 
	"nothing: an Operation Cancelled should not be warned nor explained, just must keep doing what the user was doing"
	 ]
]

{ #category : #'as yet unclassified' }
OBSimpleErrorHandler >> blockForSyntaxErrorNotification [
	^ [ :error | 
	UIManager default inform: 'Ha ocurrido un error de sintaxis:  ' , error errorCode.
	nil ]
]

{ #category : #'as yet unclassified' }
OBSimpleErrorHandler >> value [
	"evaluo mi bloque o manejo el error"

	^ [ 
	[ 
	[ 
	block
		on: OBOperationCancelled
		do: self blockForOperationCancelled ]
		on: MessageNotUnderstood
		do: self blockForMessageNotUnderstood ]
		on: SyntaxErrorNotification
		do: self blockForSyntaxErrorNotification ]
		on: Error
		do: self blockForError
]
