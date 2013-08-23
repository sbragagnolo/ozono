"
I represent the tests item in the left pane of the lesson browser
"
Class {
	#name : #OBTestsTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
OBTestsTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself
]

{ #category : #accessing }
OBTestsTreeMenuNode >> icon [

	^self icons testsIcon
]

{ #category : #selection }
OBTestsTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 

	anObjectBrowser testsOrganizationSelected.
]

{ #category : #'ui-actions' }
OBTestsTreeMenuNode >> menu: aMenu [

	^aMenu addList: (OrderedCollection with: (Array braceWith: 'importar' translated with: #fileInTests)).
]

{ #category : #accessing }
OBTestsTreeMenuNode >> name [

	^'Tests' translated 
]

{ #category : #accessing }
OBTestsTreeMenuNode >> treeContents [ 

	^#()
]
