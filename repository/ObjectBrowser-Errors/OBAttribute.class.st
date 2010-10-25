Class {
	#name : #OBAttribute,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ObjectBrowser-Model'
}

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
	aRealClass removeInstVarName: name.
]
