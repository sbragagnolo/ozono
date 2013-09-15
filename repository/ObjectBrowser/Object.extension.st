Extension { #name : #Object }

{ #category : #'*ObjectBrowser-Objects' }
Object >> clone [
	^ self metaObject clone concreteObject
]

{ #category : #'*ObjectBrowser-Objects' }
Object >> metaObject [
	^OBExternalObjectMetaObject for: self
]
