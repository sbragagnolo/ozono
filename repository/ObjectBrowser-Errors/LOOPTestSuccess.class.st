Class {
	#name : #LOOPTestSuccess,
	#superclass : #Object,
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> isError [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> isFailure [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestSuccess >> isSuccess [
	^true
]
