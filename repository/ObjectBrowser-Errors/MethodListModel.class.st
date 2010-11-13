Class {
	#name : #MethodListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
MethodListModel >> colorAt: index [
	"delegar al metodo!"
	^Color black.
]

{ #category : #'as yet unclassified' }
MethodListModel >> iconAt: anIndex [
	^(self listModel at: anIndex) iconFor: (model selectedObject)
]

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
	^self model selectedObjectMethod
]

{ #category : #'as yet unclassified' }
MethodListModel >> selectedItem: aMethod [
	self model selectedObjectMethod: aMethod.
	self changed.
]

{ #category : #'as yet unclassified' }
MethodListModel >> selectors [
	^self model selectedObjectMethods
]
