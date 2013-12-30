"
I am a null object implying that no method is selected.
"
Class {
	#name : #OBNullMethod,
	#superclass : #Object,
	#instVars : [
		'code'
	],
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #accessing }
OBNullMethod >> code [
	code ifNil: [ ^ self emptyCode ] ifNotNil: [ ^code ]
]

{ #category : #accessing }
OBNullMethod >> code: aText [
	code:=aText.
]

{ #category : #testing }
OBNullMethod >> emptyCode [
	
	^ 'messageSelectorAndArgumentNames
	"comment stating purpose of message"

	| temporary variable names |
	statements'
]

{ #category : #testing }
OBNullMethod >> isNil [

	^true
]

{ #category : #ui }
OBNullMethod >> menuItems [

	^#()
]

{ #category : #accessing }
OBNullMethod >> method [

	^nil
]
