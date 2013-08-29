"
I am a trait implementing the common collection base behavior in the Object Browser
"
Trait {
	#name : #TOBCollection,
	#traits : 'TOBObject',
	#classTraits : 'TOBObject classTrait',
	#category : #'ObjectBrowser-Collections'
}

{ #category : #cloning }
TOBCollection >> clone [

	^ self metaObject clone realObject
]

{ #category : #printing }
TOBCollection >> displayString [

	^ self metaObject baseDisplayString
]

{ #category : #printing }
TOBCollection >> printOn: aStream [

	aStream nextPutAll: self displayString
]

{ #category : #printing }
TOBCollection >> printString [

	^self displayString
]
