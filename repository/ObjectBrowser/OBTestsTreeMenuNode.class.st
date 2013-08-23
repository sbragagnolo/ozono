Class {
	#name : #OBTestsTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBTestsTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself
]

{ #category : #'as yet unclassified' }
OBTestsTreeMenuNode >> asString [
	^'Tests' translated 
]

{ #category : #'as yet unclassified' }
OBTestsTreeMenuNode >> icon [
	^OBIcons testsIcon
]

{ #category : #'as yet unclassified' }
OBTestsTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser testsOrganizationSelected.
]

{ #category : #'as yet unclassified' }
OBTestsTreeMenuNode >> menu: aMenu [
	^aMenu addList: (OrderedCollection with: (Array braceWith: 'importar' translated with: #fileInTests)).
]

{ #category : #'as yet unclassified' }
OBTestsTreeMenuNode >> treeContents [ 
	^OrderedCollection new
]
