Extension { #name : #Object }

{ #category : #'*ObjectBrowser-Objects' }
Object >> clone [
	^ self metaObject clone baseObject
]

{ #category : #'*ObjectBrowser-Objects' }
Object >> metaObject [
	^OBExternalObjectMetaObject for: self
]
