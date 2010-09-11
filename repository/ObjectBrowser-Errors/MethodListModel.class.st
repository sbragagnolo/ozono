Class {
	#name : #MethodListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
MethodListModel >> listModel [
	^self selectors asOrderedCollection 
]

{ #category : #'as yet unclassified' }
MethodListModel >> menuSelector [
	^#methodListMenu:shifted:
]

{ #category : #'as yet unclassified' }
MethodListModel >> selectedItem [
	^self model selectedObjectSelector
]

{ #category : #'as yet unclassified' }
MethodListModel >> selectedItem: aMethod [
	self model selectedObjectSelector: aMethod.
	self changed.
]

{ #category : #'as yet unclassified' }
MethodListModel >> selectors [
	^self model selectedObjectMethods
]
