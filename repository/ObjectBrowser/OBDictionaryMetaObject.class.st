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

{ #category : #attributes }
OBDictionaryMetaObject >> basicRelationships [
	
	^self realObject associations collect: [ :elem | 
		OBAssociationAttribute 
			newNamed: 'associacion'
			owner: self
			pointingTo: (lesson objectBrowserObjectForRealObject: elem)
		]
]

{ #category : #references }
OBDictionaryMetaObject >> hasReferencesTo: anOBObject [
	^(self valuesReferenceTo: anOBObject) or: [ self keysReferenceTo: anOBObject ]
]

{ #category : #testing }
OBDictionaryMetaObject >> keysReferenceTo: anOBObject [

	^self realObject includesKey: anOBObject realObject
]

{ #category : #printing }
OBDictionaryMetaObject >> printString [
	^'aDictionary'.
]

{ #category : #testing }
OBDictionaryMetaObject >> valuesReferenceTo: anOBObject [

	^self realObject includes: anOBObject realObject
]
