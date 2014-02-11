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
	to := (self pageWidth - self rightMargin) mm @ (self pageHeight - self bottomMargin + 2) mm.
	page add: (PDFLineElement from: from to: to).

	page
		add:
			(PDFParagraphElement new
				text: 'Creado con Ozono' translated;
				from: self leftMargin mm @ (self pageHeight - self bottomMargin + 4) mm;
				style: self footerLeftStyleSheet;
				dimension: 15 mm @ 15 mm).

	page
		add:
			(PDFParagraphElement new
				text: self pageNumber asString , '/' , '*#pages#*';
				from: (self pageWidth - self rightMargin - 15) mm @ (self pageHeight - self bottomMargin + 4) mm;
				style: self footerRightStyleSheet;
				dimension: 15 mm @ 15 mm)
]

{ #category : #builder }
OBCommonPageTemplate >> createHeader [
	| from to |
	from := self leftMargin mm @ (self topMargin - 2) mm.
	to := (self pageWidth - self rightMargin) mm @ (self topMargin - 2) mm.
	page add: (PDFLineElement from: from to: to).

	page
		add:
			(PDFParagraphElement new
				text: self model author;
				from: self leftMargin mm @ (self topMargin - 5) mm;
				style: self headerLeftStyleSheet;
				dimension: 15 mm @ 15 mm).

	page
		add:
			(PDFParagraphElement new
				text: self model lesson title;
				from: (self pageWidth - self rightMargin - 40) mm @ (self topMargin - 5) mm;
				style: self headerRightStyleSheet;
				dimension: 15 mm @ 40 mm).
]

{ #category : #styles }
OBCommonPageTemplate >> footerLeftStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment left middle.
	styleSheet margin:0.
	^styleSheet.
]

{ #category : #styles }
OBCommonPageTemplate >> footerRightStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment right middle.
	styleSheet filled:true.
	styleSheet fillColor: (PDFColor formatRGB:Color orange).
	styleSheet margin:0.	
	^styleSheet.
]

{ #category : #styles }
OBCommonPageTemplate >> headerLeftStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment left middle.
	styleSheet margin:0.
	^styleSheet.
]

{ #category : #styles }
OBCommonPageTemplate >> headerRightStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment right middle.
	styleSheet margin:0.
	^styleSheet.
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
