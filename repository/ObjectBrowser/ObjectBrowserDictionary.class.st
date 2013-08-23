Class {
	#name : #ObjectBrowserDictionary,
	#superclass : #ObjectBrowserCollection,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #visiting }
ObjectBrowserDictionary >> accept: aVisitor [

	aVisitor visitDictionary: self.
]

{ #category : #references }
ObjectBrowserDictionary >> hasReferencesTo: anOBObject [
	^(self valuesReferenceTo: anOBObject) or: [ self keysReferenceTo: anOBObject ]
]

{ #category : #'as yet unclassified' }
ObjectBrowserDictionary >> keysReferenceTo: anOBObject [
	^self realObject keys anySatisfy: [:elem | elem == anOBObject realObject ]
]

{ #category : #printing }
ObjectBrowserDictionary >> printString [
	^'aDictionary'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserDictionary >> valuesReferenceTo: anOBObject [
	^self realObject values anySatisfy: [:elem | elem == anOBObject realObject ]
]
