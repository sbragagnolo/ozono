Class {
	#name : #NullOBMethod,
	#superclass : #Object,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #testing }
NullOBMethod >> isNil [

	^true
]

{ #category : #ui }
NullOBMethod >> menuItems [

	^#()
]

{ #category : #accessing }
NullOBMethod >> method [

	^nil
]
