Class {
	#name : #VariablesListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
VariablesListModel >> listModel [
	^self variables asOrderedCollection 
]

{ #category : #'as yet unclassified' }
VariablesListModel >> menuSelector [
	^#variablesListMenu:shifted:
]

{ #category : #'as yet unclassified' }
VariablesListModel >> selectedItem [
	^self model selectedObjectBrowserVariable
]

{ #category : #'as yet unclassified' }
VariablesListModel >> selectedItem: anObjectBrowserVariable [
	self model selectedObjectBrowserVariable: anObjectBrowserVariable
]

{ #category : #accessing }
VariablesListModel >> variables [
	^self model variables
]
