Class {
	#name : #ObjectsOrganization,
	#superclass : #ListItemWrapper,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
ObjectsOrganization class >> for: anItem [
	^self with: anItem.
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> asString [
	^'Variables'
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> contents [
	^self item variables collect:[:v | ListItemWrapper with: v model: v ]
]

{ #category : #'as yet unclassified' }
ObjectsOrganization >> selectedItemMenu: aMenuMorph shifted: shifted [

]
