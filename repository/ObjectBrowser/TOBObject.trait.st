Trait {
	#name : #TOBObject,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #cloning }
TOBObject >> clone [

	^ self metaObject clone realObject
]

{ #category : #printing }
TOBObject >> displayString [
	^self requirement
]

{ #category : #printing }
TOBObject >> printOn: aStream [

	aStream nextPutAll: self displayString
]

{ #category : #printing }
TOBObject >> printString [

	^self displayString
]
