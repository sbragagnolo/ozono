Class {
	#name : #VariablesListModel2,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
VariablesListModel2 >> listModel [
	^self variables asOrderedCollection 
]

{ #category : #'as yet unclassified' }
VariablesListModel2 >> menuSelector [
	^#variablesListMenu:shifted:
]

{ #category : #'as yet unclassified' }
VariablesListModel2 >> selectedItem [
	^self model selectedObjectBrowserVariable
]

{ #category : #'as yet unclassified' }
VariablesListModel2 >> selectedItem: anObjectBrowserVariable [
	self model selectedObjectBrowserVariable: anObjectBrowserVariable
]

{ #category : #accessing }
VariablesListModel2 >> variables [
	^self model variables
]
