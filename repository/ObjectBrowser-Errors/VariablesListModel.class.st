Class {
	#name : #VariablesListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
VariablesListModel >> listMenu: aMenu shifted: shifted [ 
	aMenu addList: #(
			#('crear nuevo objeto' #createObject) 
"			#('crear nueva coleccion' #createSet) 
			#('clonar' #createClone) 
			#- 
			#('renombrar objeto' #renameObject)
			#('eliminar objeto' #deleteObject)").
	^ aMenu
]

{ #category : #'as yet unclassified' }
VariablesListModel >> listModel [
	^self variables asOrderedCollection 
]

{ #category : #'as yet unclassified' }
VariablesListModel >> selectedItem [
	^self model selectedObjectBrowserVariable
]

{ #category : #'as yet unclassified' }
VariablesListModel >> selectedItem: anObjectBrowserVariable [
	self model selectedObjectBrowserVariable: anObjectBrowserVariable
]

{ #category : #'as yet unclassified' }
VariablesListModel >> variables [
	^self model objectBrowserVariables
]
