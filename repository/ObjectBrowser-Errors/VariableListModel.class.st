Class {
	#name : #VariableListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
VariableListModel >> listMenu: aMenu shifted: shifted [
	aMenu addList: #(
		('crear nueva variable'		createVariable)
				-
		('eliminar variable'		deleteVariable)).
	^ aMenu
]

{ #category : #'as yet unclassified' }
VariableListModel >> listModel [
	^self variables
]

{ #category : #'as yet unclassified' }
VariableListModel >> selectedItem [
	^self model selectedVariable
]

{ #category : #'as yet unclassified' }
VariableListModel >> selectedItem: aVariable [
	self model selectedVariable: aVariable.
]

{ #category : #'as yet unclassified' }
VariableListModel >> variables [
	^self model variables
]
