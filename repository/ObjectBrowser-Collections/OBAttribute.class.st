Class {
	#name : #OBAttribute,
	#superclass : #Object,
	#instVars : [
		'name',
		'obObject'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
OBAttribute class >> newNamed: aNameString owner: obObjectOwnerWhereTheVariableBelongs [
	^self new 
		name: aNameString;
		obObject: obObjectOwnerWhereTheVariableBelongs   ; 
		yourself
]

{ #category : #'as yet unclassified' }
OBAttribute >> = anOBAttribute [
	^(anOBAttribute isKindOf: self class)  
		and: [ self name = anOBAttribute name 
			and: [ self objectPointed = anOBAttribute objectPointed ] ]
]

{ #category : #'as yet unclassified' }
OBAttribute >> actionsForAttributeList [
	^#(('Eliminar referencia'		deleteVariable))
]

{ #category : #'as yet unclassified' }
OBAttribute >> hash [
	^self name hash raisedTo: self objectPointed hash \\ 100
]

{ #category : #'as yet unclassified' }
OBAttribute >> icon [
	^ObjectBrowserIcons referenceIcon
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
OBAttribute >> obObject [
	^obObject 
]

{ #category : #'as yet unclassified' }
OBAttribute >> obObject: owner [
	obObject := owner.
]

{ #category : #'as yet unclassified' }
OBAttribute >> objectPointed [
	^self obObject objectPointedByVariableNamed: self name.
]

{ #category : #'as yet unclassified' }
OBAttribute >> printString [
	^self name , ' - (' , self objectPointed printString , ')'
]

{ #category : #'as yet unclassified' }
OBAttribute >> removeFrom: aRealClass [
	aRealClass removeInstVarNamed: name.
]
