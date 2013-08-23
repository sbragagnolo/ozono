"
I am a meta-object representing an object attribute directly related to an instance variable. I implement mostly accessors for the attribute data such as the name of the attribute and the object referenced by it.

I also implement some UI related stuff such as the icon and menu items.
"
Class {
	#name : #OBDirectAttribute,
	#superclass : #OBAbstractAttribute,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #visiting }
OBDirectAttribute >> accept: aVisitor [

	aVisitor visitDirectAttribute: self.
]

{ #category : #ui }
OBDirectAttribute >> actionsForAttributeList [
	^#(('Eliminar referencia'		deleteVariable))
]

{ #category : #ui }
OBDirectAttribute >> icon [
	^OBIcons referenceIcon
]

{ #category : #reference }
OBDirectAttribute >> objectPointed [
	^self owner basicObjectAtAttributeNamed: self name.
]

{ #category : #printing }
OBDirectAttribute >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPutAll: '(';
		nextPutAll: self objectPointed printString;
		nextPutAll: ')'
]

{ #category : #removing }
OBDirectAttribute >> removeFrom: aRealClass [
	aRealClass removeInstVarNamed: name.
]
