Extension { #name : #UndeclaredVariable }

{ #category : #'*ObjectBrowser-Tests' }
UndeclaredVariable >> declareInstVariable [

	self resume: [parser declareInstVar: name]
]

{ #category : #'*ObjectBrowser-Tests' }
UndeclaredVariable >> declareTempVariable [

	self resume: [parser declareTempAndPaste: name]
]
