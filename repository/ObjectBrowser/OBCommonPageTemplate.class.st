Class {
	#name : #OBCommonPageTemplate,
	#superclass : #OBAbstractPageTemplate,
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #builder }
OBCommonPageTemplate >> buildPage. [	
	self createHeader.
	self createFooter.
	self createContent.

]

{ #category : #builder }
OBCommonPageTemplate >> createContent [
	self subclassResponsibility.
]

{ #category : #builder }
OBCommonPageTemplate >> createFooter [
	| from to |
	from := self leftMargin mm @ (self pageHeight - self bottomMargin + 2) mm.
	to :=  (self pageWidth - self rightMargin) mm @ (self pageHeight - self bottomMargin + 2) mm.
	page add: (PDFLineElement from:  from to:to ).
]

{ #category : #builder }
OBCommonPageTemplate >> createHeader [
]

{ #category : #styles }
OBCommonPageTemplate >> headingStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 16 pt) bold italic.
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	^titleStyleSheet.
]

{ #category : #styles }
OBCommonPageTemplate >> labelStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 14 pt) bold.
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	^titleStyleSheet.
]

{ #category : #styles }
OBCommonPageTemplate >> valueStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 12 pt).
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	^titleStyleSheet.
]
