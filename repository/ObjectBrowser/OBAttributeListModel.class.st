"
I am the model of the attribute list in the lesson window.
"
Class {
	#name : #OBAttributeListModel,
	#superclass : #OBListModel,
	#category : #'ObjectBrowser-UILesson'
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
