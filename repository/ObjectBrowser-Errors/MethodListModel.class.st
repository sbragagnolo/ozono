Class {
	#name : #MethodListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
MethodListModel >> listMenu: aMenu shifted: shifted [
	aMenu addList: #(
		('borrar metodo'			deleteMethod)).
	^ aMenu
]

{ #category : #'as yet unclassified' }
MethodListModel >> listModel [
	^self methods
]

{ #category : #'as yet unclassified' }
MethodListModel >> methods [
	^self model methods
]

{ #category : #'as yet unclassified' }
MethodListModel >> selectedItem [
	^self model selectedSelector
]

{ #category : #'as yet unclassified' }
MethodListModel >> selectedItem: aSelector [
	self model selectedSelector: aSelector
]
