Class {
	#name : #ObjectAttributeListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> listMenu: aMenu shifted: shifted [
	| list |
	"Los actions que se pueden hacer dependen del model"
	list := 
		model actionsForAttributeListWith: self selectedItem.
	aMenu addList: list.
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
