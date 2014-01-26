"
An OBNotifierMock is mock implementation of the notifier for the compiler.

Instance Variables
	code:		The code to be ""compiled"" in the test.
	test:		The Test  using the mockObject.

"
Class {
	#name : #OBNotifierMock,
	#superclass : #Object,
	#instVars : [
		'test',
		'code'
	],
	#category : #'ObjectBrowser-Tests-Mocks'
}

{ #category : #mock }
OBNotifierMock >> code: aString [ 
	code := aString
]

{ #category : #mock }
OBNotifierMock >> correctFrom: from to: to  with: newString. [ 

	test assert:to = 17.
	test assert:from = 18.
	test assert:newString = '| anUnknownVariable |
	'.
]

{ #category : #mock }
OBNotifierMock >> editor [
	^self.
]

{ #category : #mock }
OBNotifierMock >> paragraph [
	^self.
]

{ #category : #mock }
OBNotifierMock >> test: aTest [ 
	test := aTest
]

{ #category : #mock }
OBNotifierMock >> text [
	^code.
]

{ #category : #mock }
OBNotifierMock >> textMorph [
	^self.
]
