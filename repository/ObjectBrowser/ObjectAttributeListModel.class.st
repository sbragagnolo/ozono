Class {
	#name : #ObjectAttributeListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #actions }
ObjectAttributeListModel >> clickIconAt: anIndex [
	"Do nothing if they click in the icon"
]

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> listModel [
	^self selectedObjectAttributes asOrderedCollection 
]

{ #category : #'as yet unclassified' }
ObjectAttributeListModel >> menuSelector [
	^#attributeListMenu:shifted:
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
