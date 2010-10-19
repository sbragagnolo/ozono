Class {
	#name : #ObjectTestsListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> listModel [
	^self model tests asOrderedCollection
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> menuSelector [
	^#testListMenu:shifted:
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> selectedItem [
	^nil
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> selectedItem: aVariable [
	"Nothing"
]
