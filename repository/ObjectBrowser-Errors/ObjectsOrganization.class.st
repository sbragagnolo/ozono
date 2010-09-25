Class {
	#name : #ObjectsOrganization,
	#superclass : #Object,
	#instVars : [
		'objectBrowser'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
ObjectsOrganization class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> asString [
	^'Variables'
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> contents [
	^objectBrowser variables collect:[:v | OBListItemWrapper with: v model: v ]
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> icon [
	^ObjectBrowserIcons homeIcon
]

{ #category : #selection }
ObjectsOrganization >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser objectsOrganizationSelected.
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> menu: aMenu [
	^aMenu addList: (OrderedCollection with: #('crear nuevo objeto' #createObject))
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> objectBrowser: anObjectBrowser [
	objectBrowser := anObjectBrowser
]
