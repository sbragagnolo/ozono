Class {
	#name : #LOOPTestNotRan,
	#superclass : #Object,
	#instVars : [
		'signal'
	],
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'as yet unclassified' }
LOOPTestNotRan >> icon [
	^OBIcons notRanIcon
]

{ #category : #'as yet unclassified' }
LOOPTestNotRan >> isError [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestNotRan >> isFailure [
	^false
]

{ #category : #'as yet unclassified' }
LOOPTestNotRan >> isNotRan [
	^true.
]

{ #category : #'as yet unclassified' }
LOOPTestNotRan >> isSuccess [
	^true
]
