"
I am a meta-object representing an object attribute inside the object browser. I implement mostly accessors for the attribute data such as the name of the attribute and the object referenced by it.

I also implement some UI related stuff such as the icon and menu items.
"
Class {
	#name : #OBAttribute,
	#superclass : #Object,
	#instVars : [
		'name',
		'obObject'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBAttribute class >> newNamed: aNameString owner: obObjectOwnerWhereTheVariableBelongs [
	^self new 
		name: aNameString;
		obObject: obObjectOwnerWhereTheVariableBelongs   ; 
		yourself
]

{ #category : #comparing }
OBAttribute >> = anOBAttribute [
	^(anOBAttribute isKindOf: self class)  
		and: [ self name = anOBAttribute name 
			and: [ self objectPointed = anOBAttribute objectPointed ] ]
]

{ #category : #ui }
OBAttribute >> actionsForAttributeList [
	^#(('Eliminar referencia'		deleteVariable))
]

{ #category : #comparing }
OBAttribute >> hash [
	^self name hash raisedTo: self objectPointed hash \\ 100
]

{ #category : #ui }
OBAttribute >> icon [
	^OBIcons referenceIcon
]

{ #category : #accessing }
OBAttribute >> name [
	^name
]

{ #category : #accessing }
OBAttribute >> name: aName [
	name := aName
]

{ #category : #accessing }
OBAttribute >> obObject [
	^obObject 
]

{ #category : #accessing }
OBAttribute >> obObject: owner [
	obObject := owner.
]

{ #category : #reference }
OBAttribute >> objectPointed [
	^self obObject basicObjectAtAttributeNamed: self name.
]

{ #category : #reference }
OBAttribute >> pointsTo [
	^self objectPointed
]

{ #category : #printing }
OBAttribute >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPutAll: '(';
		nextPutAll: self objectPointed printString;
		nextPutAll: ')'
]

{ #category : #removing }
OBAttribute >> removeFrom: aRealClass [
	aRealClass removeInstVarNamed: name.
]
