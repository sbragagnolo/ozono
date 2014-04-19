"
I am a trait implementing the common collection base behavior in the Object Browser
"
Trait {
	#name : #TOBCollection,
	#traits : 'TOBObject',
	#classTraits : 'TOBObject classTrait',
	#category : #'ObjectBrowser-Collections'
}

{ #category : #methods }
TOBCollection classSide >> sourceCodeAt: aSelector [
	^ 'Código mágico :O'
]

{ #category : #cloning }
TOBCollection >> clone [
	^ self metaObject clone realObject
]

{ #category : #cloning }
TOBCollection >> copyEmpty [

	^ super copyEmpty metaObject: (self metaObject).
]

{ #category : #printing }
TOBCollection >> displayString [

	^ self metaObject baseDisplayString
]

{ #category : #printing }
TOBCollection >> printOn: aStream [
	aStream << self displayString.
	self printElementsOn:aStream.
]

{ #category : #printing }
TOBCollection >> printString [

	^self printStringLimitedTo: 3000.
]
