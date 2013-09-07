Class {
	#name : #ObjectBrowserDictionary,
	#superclass : #ObjectBrowserCollection,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
ObjectBrowserDictionary >> addToGraph: aGraph [
	aGraph addDictionary: self.
]

{ #category : #'as yet unclassified' }
ObjectBrowserDictionary >> hasReferencesTo: anOBObject [
	^(self valuesReferenceTo: anOBObject) or: [ self keysReferenceTo: anOBObject ]
]

{ #category : #'as yet unclassified' }
ObjectBrowserDictionary >> keysReferenceTo: anOBObject [
	^self realObject keys anySatisfy: [:elem | elem == anOBObject realObject ]
]

{ #category : #'as yet unclassified' }
ObjectBrowserDictionary >> valuesReferenceTo: anOBObject [
	^self realObject values anySatisfy: [:elem | elem == anOBObject realObject ]
]
