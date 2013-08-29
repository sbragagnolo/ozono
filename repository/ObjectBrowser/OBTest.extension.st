Extension { #name : #OBTest }

{ #category : #'*ObjectBrowser-Fileout' }
OBTest >> fileOut [

	OBFileOutV3 new export: self.
]
