"
I am a meta-object representing an object attribute . I implement mostly accessors for the attribute data such as the name of the attribute and the object referenced by it.

I also implement some UI related stuff such as the icon and menu items.
"
Class {
	#name : #OBAbstractAttribute,
	#superclass : #Object,
	#instVars : [
		'name',
		'owner'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBAbstractAttribute class >> newNamed: aNameString owner: obObjectOwnerWhereTheVariableBelongs [
	^self new 
		name: aNameString;
		owner: obObjectOwnerWhereTheVariableBelongs   ; 
		yourself
]

{ #category : #comparing }
OBAbstractAttribute >> = anOBAttribute [
	^(anOBAttribute isKindOf: self class)  
		and: [ self name = anOBAttribute name 
			and: [ self objectPointed = anOBAttribute objectPointed ] ]
]

{ #category : #visiting }
OBAbstractAttribute >> accept: aVisitor [

	aVisitor visitAttribute: self.
]

{ #category : #ui }
OBAbstractAttribute >> actionsForAttributeList [
	self subclassResponsibility
]

{ #category : #ui }
OBAbstractAttribute >> deleteConfirmationMessage [
	^ '¿Está seguro de eliminar la referencia ''', name, '''? 
	El objeto referenciado aparecerá en la papelera si no tiene otras referencias.' translated
]

{ #category : #comparing }
OBAbstractAttribute >> hash [
	^self name hash raisedTo: self objectPointed hash \\ 100
]

{ #category : #ui }
OBAbstractAttribute >> icon [
	self subclassResponsibility
]

{ #category : #accessing }
OBAbstractAttribute >> name [
	^name
]

{ #category : #accessing }
OBAbstractAttribute >> name: aName [
	name := aName
]

{ #category : #reference }
OBAbstractAttribute >> objectPointed [
	self subclassResponsibility
]

{ #category : #accessing }
OBAbstractAttribute >> owner [
	^owner
]

{ #category : #accessing }
OBAbstractAttribute >> owner: anOwnerObject [
	owner := anOwnerObject.
]

{ #category : #reference }
OBAbstractAttribute >> pointsTo [
	^self objectPointed
]

{ #category : #removing }
OBAbstractAttribute >> removeFrom: aRealClass [
	self subclassResponsibility
]
