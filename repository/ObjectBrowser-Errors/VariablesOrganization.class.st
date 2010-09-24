Class {
	#name : #VariablesOrganization,
	#superclass : #ListItemWrapper,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
VariablesOrganization class >> for: aModel [
	^self with: aModel.
]

{ #category : #'as yet unclassified' }
VariablesOrganization >> asString [
	^'variables'
]

{ #category : #'as yet unclassified' }
VariablesOrganization >> selectedItemMenu: aMenuMorph shifted: shifted [

]
