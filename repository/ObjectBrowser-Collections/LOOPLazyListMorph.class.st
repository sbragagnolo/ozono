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
	(listSource iconAt: row) ifNotNil: [ :icon | 
		top := drawBounds top + ((drawBounds height - icon height) // 2).
		canvas 
			translucentImage: icon
			at: drawBounds left @ top.
		drawBounds := drawBounds left: drawBounds left + icon width + 2 ].
	
	canvas 
		drawString: item string
		in: drawBounds
		font: (listSource fontAt: row withBasicFont: font)
		color: (listSource colorAt: row)
]
