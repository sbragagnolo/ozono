Class {
	#name : #ObjectAttributeListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> listMenu: aMenu shifted: shifted [
	aMenu addList: #(
		('crear nueva variable'		createAttribute)
				-
		('eliminar variable'		deleteAttribute)).
	^ aMenu
]

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> listModel [
	^self selectedObjectAttributes asOrderedCollection 
]

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> selectedItem [
	^self model selectedObjectAttribute
]

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> selectedItem: aVariable [
	self model selectedObjectAttribute: aVariable.
]

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> selectedObjectAttributes [
	^self model selectedObjectAttributes
]
