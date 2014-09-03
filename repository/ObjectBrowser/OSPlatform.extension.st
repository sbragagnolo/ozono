Extension { #name : #OSPlatform }

{ #category : #'*ObjectBrowser-PDFGeneration' }
OSPlatform >> prettyName [
	^ self name , '/' , self prettyVersion.
]

{ #category : #'*ObjectBrowser-PDFGeneration' }
OSPlatform >> prettyVersion [
	^ self version.
]
