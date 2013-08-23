Class {
	#name : #OBMethodListModel,
	#superclass : #OBListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
OBMethodListModel >> colorAt: index [
	"delegar al metodo!"
	^Color black.
]

{ #category : #'as yet unclassified' }
OBMethodListModel >> iconAt: aMethod [
	^aMethod iconFor: (model selectedObject)
]

{ #category : #'as yet unclassified' }
OBMethodListModel >> listModel [
	^self selectors asOrderedCollection 
]

{ #category : #'as yet unclassified' }
OBMethodListModel >> menuSelector [
	^#methodListMenu:shifted:
]

{ #category : #'as yet unclassified' }
OBMethodListModel >> selectedItem [
	^self model selectedObjectMethod
]

{ #category : #'as yet unclassified' }
OBMethodListModel >> selectedItem: aMethod [
	self model selectedObjectMethod: aMethod.
	self changed.
]

{ #category : #'as yet unclassified' }
OBMethodListModel >> selectors [
	^self model selectedObjectMethods
]
