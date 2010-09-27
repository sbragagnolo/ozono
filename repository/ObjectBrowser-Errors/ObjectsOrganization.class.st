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
ObjectsOrganization >> createBag [
	objectBrowser createBag.
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> createOrdered [
	objectBrowser createOrdered.
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> createSet [
	objectBrowser createSet.
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
	aMenu addList: (OrderedCollection with: #('crear nuevo objeto' #createObject)).
	aMenu add: self subMenuCollectionsName subMenu: self subMenuCollections.
	^aMenu
	
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> objectBrowser: anObjectBrowser [
	objectBrowser := anObjectBrowser
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> subMenuCollections [
	| menuCrearColeccion |
	menuCrearColeccion := MenuMorph new target: self; yourself .
	menuCrearColeccion add:'set' action: #createSet.
	menuCrearColeccion add:'bag' action: #createBag.
	menuCrearColeccion add:'ordered' action: #createOrdered.
	^menuCrearColeccion.
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> subMenuCollectionsName [
	^'Crear nuevo conjunto'
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> treeContents [
	^objectBrowser variables collect:[:v | OBListItemWrapper with: v model: v ]
]
