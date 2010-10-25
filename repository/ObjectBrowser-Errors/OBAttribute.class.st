Class {
	#name : #OBAttribute,
	#superclass : #OBVariable,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBAttribute >> actionsForAttributeList [
	^#(('Eliminar variable'		deleteVariable))
]

{ #category : #'as yet unclassified' }
OBAttribute >> printString [
	^self name
]

{ #category : #'as yet unclassified' }
OBAttribute >> removeFrom: aRealClass [
	aRealClass removeInstVarName: name.
]
