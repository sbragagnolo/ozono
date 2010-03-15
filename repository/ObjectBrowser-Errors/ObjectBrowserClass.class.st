Class {
	#name : #ObjectBrowserClass,
	#superclass : #Object,
	#classVars : [
		'ObjectBrowserObjects'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowserClass class >> new [
	^self basicNew
]

{ #category : #'as yet unclassified' }
ObjectBrowserClass >> objectBrowserObjectForMe [
	"el OBO que me representa"

	^self objectBrowserObjects detect: [:obo | obo realObject = self]
]

{ #category : #'as yet unclassified' }
ObjectBrowserClass >> objectBrowserObjects [
	"la bolsa de OBO donde me tengo que buscar"

	^ObjectBrowser objects
]

{ #category : #'as yet unclassified' }
ObjectBrowserClass >> objectName [
	"el nombre mio que despliego"

	^self objectBrowserObjectForMe objectName
]

{ #category : #'as yet unclassified' }
ObjectBrowserClass >> printOn: aStream [
	"eso"

	aStream nextPutAll: self objectName
]
