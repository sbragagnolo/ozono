Class {
	#name : #ObjectBrowserObjectNode,
	#superclass : #ObjectNode,
	#category : #'ObjectBrowser-Diagrams'
}

{ #category : #'as yet unclassified' }
ObjectBrowserObjectNode >> variableNamed: aVariableName [
	^(self object objectPointedByVariableNamed: aVariableName )
]

{ #category : #'as yet unclassified' }
ObjectBrowserObjectNode >> variableNames [
	^self object variableNames asOrderedCollection 
]
