"
I represent the recycle bin item in the left pane of the lesson browser
"
Class {
	#name : #OBRecycleBinTreeMenuNode,
	#superclass : #OBTreeMenuModel,
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
OBRecycleBinTreeMenuNode class >> for: anObjectBrowser [
	^self new objectBrowser: anObjectBrowser; yourself.
]

{ #category : #accessing }
OBRecycleBinTreeMenuNode >> icon [

	^self icons trashIcon
]

{ #category : #selection }
OBRecycleBinTreeMenuNode >> makeSelectionOn: anObjectBrowser [ 
	
]

{ #category : #'ui-actions' }
OBRecycleBinTreeMenuNode >> menu: aMenu [

	^aMenu addList: (OrderedCollection with: (Array braceWith: 'Recolectar basura' translated with: #runGarbageCollector))
]

{ #category : #accessing }
OBRecycleBinTreeMenuNode >> name [ 

	^'Papelera' translated 
]

{ #category : #accessing }
OBRecycleBinTreeMenuNode >> treeContents [

	^objectBrowser orphanObjects collect: [ :o | OBListItemWrapper with: o model: o ]
]
