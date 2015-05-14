"
I represent the references item in the left pane of the lesson browser
"
Class {
	#name : #OBObjectsTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
OBObjectsTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #showing }
OBObjectsTreeMenuNode >> createBag [

	objectBrowser createBag.
]

{ #category : #showing }
OBObjectsTreeMenuNode >> createDictionary [

	objectBrowser createDictionary.
]

{ #category : #showing }
OBObjectsTreeMenuNode >> createOrdered [

	objectBrowser createOrdered.
]

{ #category : #showing }
OBObjectsTreeMenuNode >> createSet [

	objectBrowser createSet.
]

{ #category : #showing }
OBObjectsTreeMenuNode >> createSorted [

	objectBrowser createSorted.
]

{ #category : #accessing }
OBObjectsTreeMenuNode >> icon [

	^self icons homeIcon
]

{ #category : #selection }
OBObjectsTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 

	anObjectBrowser objectsOrganizationSelected.
]

{ #category : #'ui-actions' }
OBObjectsTreeMenuNode >> menu: aMenu [

	aMenu addList: (OrderedCollection with: (Array braceWith: 'crear nuevo objeto' translated with: #createObject)).
	aMenu add: self subMenuCollectionsName subMenu: self subMenuCollections.
	^aMenu
	
]

{ #category : #accessing }
OBObjectsTreeMenuNode >> name [

	^'Referencias' translated 
]

{ #category : #accessing }
OBObjectsTreeMenuNode >> subMenuCollections [

	| menuCrearColeccion |
	menuCrearColeccion := MenuMorph new target: self; yourself .
	menuCrearColeccion add:'set' selector: #createSet.
	menuCrearColeccion add:'bag' selector: #createBag.
	menuCrearColeccion add:'ordered' selector: #createOrdered.
	menuCrearColeccion add:'sorted' selector: #createSorted.
	menuCrearColeccion add:'dictionary' selector: #createDictionary.
	^menuCrearColeccion.
]

{ #category : #accessing }
OBObjectsTreeMenuNode >> subMenuCollectionsName [

	^'Crear nuevo conjunto' translated 
]

{ #category : #accessing }
OBObjectsTreeMenuNode >> treeContents [

	^objectBrowser variables collect:[:v | OBListItemWrapper with: v model: v ]
]
