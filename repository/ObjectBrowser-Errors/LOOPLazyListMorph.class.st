Class {
	#name : #LOOPLazyListMorph,
	#superclass : #OBLazyListMorph,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPLazyListMorph >> display: item atRow: row on: canvas [ 
	"Display the given item at row row."
	
	| drawBounds top |
	drawBounds := self drawBoundsForRow: row.
	drawBounds := drawBounds intersect: self bounds.
	self haltOnce.
	(listSource iconAt: row) ifNotNil: [ :icon | 
		top := drawBounds top + ((drawBounds height - icon height) // 2).
		canvas 
			translucentImage: icon
			at: drawBounds left @ top.
		drawBounds := drawBounds left: drawBounds left + icon width + 2 ].
	item isText 
		ifTrue: [ 
			canvas 
				drawString: item string
				in: drawBounds
				font: (font emphasized: (item emphasisAt: 1))
				color: (item colorAt: 1) ]
		ifFalse: [
			canvas 
				drawString: item
				in: drawBounds
				font: font
				color: (self colorForRow: row) ]
]
