Class {
	#name : #OBNullMethod,
	#superclass : #Object,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #testing }
OBNullMethod >> isNil [

	^true
]

{ #category : #ui }
OBNullMethod >> menuItems [

	^#()
]

{ #category : #accessing }
OBNullMethod >> method [

	^nil
]
