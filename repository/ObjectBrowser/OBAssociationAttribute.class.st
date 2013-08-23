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
			pointingTo: (self owner lesson objectBrowserObjectForRealObject: self objectPointed realObject key)
]

{ #category : #references }
OBAssociationAttribute >> valueAttribute [
	^OBSpecialAttribute 
			newNamed: 'valor'
			owner: self objectPointed
			pointingTo: (self owner lesson objectBrowserObjectForRealObject: self objectPointed realObject value)
]
