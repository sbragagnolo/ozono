Extension { #name : #PluggableTreeMorph }

{ #category : #'*ObjectBrowser' }
PluggableTreeMorph >> expandNodeAt:aPosition [
	self expandAll:(self scroller submorphs at:1).
	self adjustSubmorphPositions.
	
]
