Extension { #name : #UndeclaredVariable }

{ #category : #'*ObjectBrowser-UI-Model' }
UndeclaredVariable >> asOBUndeclaredVariable [

	^ OBUndeclaredVariable new
		setParser: parser name: name range: interval
		yourself.
]

{ #category : #'*ObjectBrowser-Tests' }
UndeclaredVariable >> declareInstVariable [

	self resume: [parser declareInstVar: name]
]

{ #category : #'*ObjectBrowser-Tests' }
UndeclaredVariable >> declareTempVariable [

	self resume: [parser declareTempAndPaste: name]
]
