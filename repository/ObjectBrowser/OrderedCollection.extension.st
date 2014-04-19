Extension { #name : #OrderedCollection }

{ #category : #'*ObjectBrowser' }
OrderedCollection >> metaObject [
	^ OBOrderedCollection newWithRealObject: self prototype: OBOrderedCollectionPrototype new
]
