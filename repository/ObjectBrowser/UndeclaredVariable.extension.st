Extension { #name : #UndeclaredVariable }

{ #category : #'*ObjectBrowser-UI-Model' }
UndeclaredVariable >> asOBUndeclaredVariable [

	^ OBUndeclaredVariable new
		setParser: parser name: name range: interval
		yourself.
]
