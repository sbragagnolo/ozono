Class {
	#name : #ObjectBrowserWorkspaceStore,
	#superclass : #Workspace,
	#instVars : [
		'store'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserWorkspaceStore >> accept: aText [
	"do nothing"
	^self
]

{ #category : #'as yet unclassified' }
ObjectBrowserWorkspaceStore >> bindingOf: aString [ 
	"para que devuelva lo que diga el object store"

	^store bindingOf: aString
]

{ #category : #'as yet unclassified' }
ObjectBrowserWorkspaceStore >> on: anObjectStore [
	"me pasan el ObjectStore con el que voy a trabajar"

	store := anObjectStore
]
