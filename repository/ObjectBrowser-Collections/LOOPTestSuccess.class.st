Class {
	#name : #LOOPTestSuccess,
	#superclass : #Object,
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> icon [
	^ObjectBrowserIcons okIcon
]

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> isError [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> isFailure [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> isNotRan [
	^false.
]

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> isSuccess [
	^true
]
