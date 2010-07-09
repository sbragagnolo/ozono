Class {
	#name : #ObjectAttributeListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> listMenu: aMenu shifted: shifted [
	"Los actions que se pueden hacer dependen del model"
	^aMenu addList: (model actionsForAttributeListWith: self selectedItem)
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
