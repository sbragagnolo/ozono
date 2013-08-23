Class {
	#name : #OBObjectsTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> asString [
	^'Referencias' translated 
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> createBag [
	objectBrowser createBag.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> createDictionary [
	objectBrowser createDictionary.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> createOrdered [
	objectBrowser createOrdered.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> createSet [
	objectBrowser createSet.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> createSorted [
	objectBrowser createSorted.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> icon [
	^OBIcons homeIcon
]

{ #category : #selection }
OBObjectsTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser objectsOrganizationSelected.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> menu: aMenu [
	aMenu addList: (OrderedCollection with: (Array braceWith: 'crear nuevo objeto' translated with: #createObject)).
	aMenu add: self subMenuCollectionsName subMenu: self subMenuCollections.
	^aMenu
	
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> subMenuCollections [
	| menuCrearColeccion |
	menuCrearColeccion := MenuMorph new target: self; yourself .
	menuCrearColeccion add:'set' action: #createSet.
	menuCrearColeccion add:'bag' action: #createBag.
	menuCrearColeccion add:'ordered' action: #createOrdered.
	menuCrearColeccion add:'sorted' action: #createSorted.
	menuCrearColeccion add:'dictionary' action: #createDictionary.
	^menuCrearColeccion.
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> subMenuCollectionsName [
	^'Crear nuevo conjunto' translated 
]

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode >> treeContents [
	^objectBrowser variables collect:[:v | OBListItemWrapper with: v model: v ]
]
