Class {
	#name : #ObjectListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectListModel >> listMenu: aMenu shifted: shifted [ 
	aMenu addList: #(#('crear nuevo objeto' #createObject) #('crear nueva coleccion' #createSet) #('clonar' #createClone) #- #('eliminar objeto' #deleteObject) "#- #('file out' #fileOutSelectedClass) #('file in' #fileIn) ").
	^ aMenu
]

{ #category : #'as yet unclassified' }
ObjectListModel >> listModel [
	^self objects
]

{ #category : #'as yet unclassified' }
ObjectListModel >> objects [
	^self model objects
]

{ #category : #'as yet unclassified' }
ObjectListModel >> selectedItem [
	^self model selectedObject
]

{ #category : #'as yet unclassified' }
ObjectListModel >> selectedItem: anObject [
	self model selectedObject: anObject
]
