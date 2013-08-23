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
