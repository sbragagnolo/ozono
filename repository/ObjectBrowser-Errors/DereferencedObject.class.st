Class {
	#name : #DereferencedObject,
	#superclass : #Object,
	#instVars : [
		'dereferencedObject'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
DereferencedObject class >> newOn: anObject [
	^self new
		dereferencedObject: anObject;
		yourself
]

{ #category : #'as yet unclassified' }
DereferencedObject >> asString [
	^dereferencedObject displayString
]

{ #category : #'as yet unclassified' }
DereferencedObject >> dereferencedObject: anObject [
	dereferencedObject := anObject
]

{ #category : #'as yet unclassified' }
DereferencedObject >> icon [
	^nil
]

{ #category : #'as yet unclassified' }
DereferencedObject >> makeSelectionOn: aBrowser [
	"Nothing"
]

{ #category : #'as yet unclassified' }
DereferencedObject >> menu: aMenuBuilder [
	^aMenuBuilder
]

{ #category : #'as yet unclassified' }
DereferencedObject >> treeContents [
	^OrderedCollection new
]
