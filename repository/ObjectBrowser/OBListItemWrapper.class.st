Class {
	#name : #OBListItemWrapper,
	#superclass : #ListItemWrapper,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
OBListItemWrapper class >> with: anObject [
	^self new setItem: anObject model: anObject; yourself
]

{ #category : #'as yet unclassified' }
OBListItemWrapper >> asString [
	^self model asString
]

{ #category : #'as yet unclassified' }
OBListItemWrapper >> contents [
	^self model treeContents
]

{ #category : #'as yet unclassified' }
OBListItemWrapper >> icon [
	^self model icon
]

{ #category : #'as yet unclassified' }
OBListItemWrapper >> menu: aMenu [
	^self model menu: aMenu
]
