Extension { #name : #Set }

{ #category : #'*ObjectBrowser' }
Set >> metaObject [
	^ OBSetMetaObject newWithRealObject: self prototype: OBSetPrototype new
]
