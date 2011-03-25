Class {
	#name : #OBAttribute,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
OBAttribute class >> newNamed: aNameString [
	^self new name: aNameString; yourself
]

{ #category : #'as yet unclassified' }
OBAttribute >> actionsForAttributeList [
	^#(('Eliminar variable'		deleteVariable))
]

{ #category : #'as yet unclassified' }
OBAttribute >> name [
	^name
]

{ #category : #'as yet unclassified' }
OBAttribute >> name: aName [
	name := aName
]

{ #category : #'as yet unclassified' }
OBAttribute >> printString [
	^self name
]

{ #category : #'as yet unclassified' }
OBAttribute >> removeFrom: aRealClass [
	aRealClass removeInstVarNamed: name.
]
