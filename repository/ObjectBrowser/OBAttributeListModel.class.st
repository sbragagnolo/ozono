Class {
	#name : #OBAttributeListModel,
	#superclass : #OBListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBAttributeListModel >> listModel [
	^self selectedObjectAttributes asOrderedCollection 
]

{ #category : #'as yet unclassified' }
OBAttributeListModel >> menuSelector [
	^#attributeListMenu:shifted:
]

{ #category : #'as yet unclassified' }
OBAttributeListModel >> selectedItem [
	^self model selectedObjectAttribute
]

{ #category : #'as yet unclassified' }
OBAttributeListModel >> selectedItem: aVariable [
	self model selectedObjectAttribute: aVariable.
]

{ #category : #'as yet unclassified' }
OBAttributeListModel >> selectedObjectAttributes [
	^self model selectedObjectAttributes
]
