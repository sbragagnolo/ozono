Extension { #name : #SortedCollection }

{ #category : #'*ObjectBrowser' }
SortedCollection >> metaObject [
	^ OBSortedMetaObject newWithRealObject: self prototype: OBSortedPrototype new
]
