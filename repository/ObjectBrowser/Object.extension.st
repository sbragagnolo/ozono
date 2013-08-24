Extension { #name : #Object }

{ #category : #'*ObjectBrowser-Objects' }
Object >> metaObject [
	^OBExternalObjectMetaObject for: self
]
