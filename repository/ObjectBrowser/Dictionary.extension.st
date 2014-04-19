Extension { #name : #Dictionary }

{ #category : #'*ObjectBrowser' }
Dictionary >> metaObject [
	^ OBDictionaryMetaObject newWithRealObject: self prototype: OBDictionaryPrototype new
]
