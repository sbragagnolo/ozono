"
I am the meta-object that represents an (sub)instance of dictionary.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBDictionaryMetaObject,
	#superclass : #OBCollectionMetaObject,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #visiting }
OBDictionaryMetaObject >> accept: aVisitor [

	aVisitor visitDictionary: self.
]

{ #category : #adding }
OBDictionaryMetaObject >> at: aKey put: aValue [
	self baseObject at: aKey baseObject put: aValue baseObject
]

{ #category : #attributes }
OBDictionaryMetaObject >> basicRelationships [
	
	^self baseObject associations collect: [ :elem | 
		OBAssociationAttribute 
			newNamed: 'associacion'
			owner: self
			pointingTo: elem metaObject
		]
]

{ #category : #references }
OBDictionaryMetaObject >> hasReferencesTo: anOBObject [

	^(self valuesReferenceTo: anOBObject) or: [ self keysReferenceTo: anOBObject ]
]

{ #category : #references }
OBDictionaryMetaObject >> keysReferenceTo: anOBObject [

	^self baseObject includesKey: anOBObject baseObject
]

{ #category : #printing }
OBDictionaryMetaObject >> printString [
	^'aDictionary'.
]

{ #category : #methods }
OBDictionaryMetaObject >> selectorsToDispay [
	^ super selectorsToDispay , #(#at: #at:put:)
]

{ #category : #references }
OBDictionaryMetaObject >> valuesReferenceTo: anOBObject [

	^self baseObject includes: anOBObject baseObject
]
