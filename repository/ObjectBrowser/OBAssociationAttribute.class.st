"
I am an attribute representing an association. I am used to traverse the dictionary instances.
"
Class {
	#name : #OBAssociationAttribute,
	#superclass : #OBSpecialAttribute,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #visiting }
OBAssociationAttribute >> accept: aVisitor [

	aVisitor visitAssociationAttribute: self.
]

{ #category : #references }
OBAssociationAttribute >> keyAttribute [
	^OBSpecialAttribute 
			newNamed: 'clave'
			owner: self objectPointed
			pointingTo: (self objectPointed baseObject key metaObject)
]

{ #category : #references }
OBAssociationAttribute >> valueAttribute [
	^OBSpecialAttribute 
			newNamed: 'valor'
			owner: self objectPointed
			pointingTo: (self objectPointed baseObject value metaObject)
]
