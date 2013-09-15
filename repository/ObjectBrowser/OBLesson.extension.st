Extension { #name : #OBLesson }

{ #category : #'*ObjectBrowser-Fileout' }
OBLesson >> fileOut [

	OBFileOutV3 new export: self.
]
