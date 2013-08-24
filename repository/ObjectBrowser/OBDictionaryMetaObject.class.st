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
	self concreteObject at: aKey concreteObject put: aValue concreteObject
]

{ #category : #attributes }
OBDictionaryMetaObject >> basicRelationships [
	
	^self concreteObject associations collect: [ :elem | 
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

	^self concreteObject includesKey: anOBObject concreteObject
]

{ #category : #printing }
OBDictionaryMetaObject >> printString [
	^'aDictionary'.
]

{ #category : #references }
OBDictionaryMetaObject >> valuesReferenceTo: anOBObject [

	^self concreteObject includes: anOBObject concreteObject
]

{ #category : #exporting }
OBDictionaryMetaObject >> writeStateScriptOn: stream lesson: aLesson [
	"saves the state, all the variables values and relationships"
	self concreteObject keysAndValuesDo:  [ :key :value | 
			stream nextPutAll: self posibleName.
			stream nextPutAll: ' at: '.
			stream nextPutAll:  key metaObject posibleName.
			stream nextPutAll: ' put: '.
			stream nextPutAll:  value metaObject posibleName.
			stream nextPutAll: '.'.
			stream cr].

]
