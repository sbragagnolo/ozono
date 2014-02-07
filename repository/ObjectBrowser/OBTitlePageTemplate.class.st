Class {
	#name : #OBTitlePageTemplate,
	#superclass : #Object,
	#instVars : [
		'lessonToPDF',
		'page'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'instance creation' }
OBTitlePageTemplate class >> newFor: lessonToPDF [
	^ self new lessonToPDF: lessonToPDF.
]

{ #category : #builder }
OBTitlePageTemplate >> buildOn: pdfDoc [
	page := PDFPage new.	
	pdfDoc add: page.
	
	self createTitle. 
	self createAuthor. 
	self createCourse.
	self createTeacher.
	self createDate.

]

{ #category : #builder }
OBTitlePageTemplate >> createAuthor [
	self createLabel: 'Autor:' withText: (self lessonToPDF author)  withHeight: 15 onTop: 155.
]

{ #category : #builder }
OBTitlePageTemplate >> createCourse [
	self createLabel: 'Curso:' withText: (self lessonToPDF course)  withHeight: 15 onTop: 170.
]

{ #category : #builder }
OBTitlePageTemplate >> createDate [
	self createLabel: 'Fecha:' withText: (self lessonToPDF formattedDate)  withHeight: 15 onTop: 200.
]

{ #category : #builder }
OBTitlePageTemplate >> createLabel: labelText withText: text withHeight: height onTop: top [
	| labelRatio valueRatio |
	labelRatio := 0.3.
	valueRatio := 1 - labelRatio.
	page
		add:
			(PDFParagraphElement new
				styleSheet: self labelStyleSheet;
				dimension: (self usableWidth * labelRatio) mm @ height mm;
				from: self leftMargin mm @ top mm;
				text: labelText).
	page
		add:
			(PDFParagraphElement new
				styleSheet: self valueStyleSheet;
				dimension: (self usableWidth * valueRatio) mm @ height mm;
				from: (self leftMargin + (self usableWidth * labelRatio)) mm @ top mm;
				text: text).
]

{ #category : #builder }
OBTitlePageTemplate >> createTeacher [
	self createLabel: 'Profesor:' withText: (self lessonToPDF teacher)  withHeight: 15 onTop: 185.
]

{ #category : #builder }
OBTitlePageTemplate >> createTitle [
	| height top |
	height := 50.
	top := 50.
	
	page
		add:
			(PDFParagraphElement new
				styleSheet: self titleStyleSheet;
				dimension: self usableWidth mm @ height mm;
				from: self leftMargin mm @ top mm;
				text: self lessonToPDF lesson title)
]

{ #category : #styles }
OBTitlePageTemplate >> labelStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 24 pt) bold.
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	^titleStyleSheet.
]

{ #category : #margins }
OBTitlePageTemplate >> leftMargin [
	^30.
]

{ #category : #accessing }
OBTitlePageTemplate >> lessonToPDF [
	^ lessonToPDF
]

{ #category : #accessing }
OBTitlePageTemplate >> lessonToPDF:aValue [
	lessonToPDF := aValue.
]

{ #category : #'calculated properties' }
OBTitlePageTemplate >> pageHeight [
	^(page format height convertTo: Unit mm) value floor.
]

{ #category : #'calculated properties' }
OBTitlePageTemplate >> pageWidth [
	^(page format width convertTo: Unit mm) value floor.
]

{ #category : #margins }
OBTitlePageTemplate >> rightMargin [
	^30.
]

{ #category : #styles }
OBTitlePageTemplate >> titleStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFHelveticaFont new fontSize: 48 pt) bold italic.
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment center middle.
	^titleStyleSheet.
]

{ #category : #'calculated properties' }
OBTitlePageTemplate >> usableWidth [
	^self pageWidth - self leftMargin - self rightMargin.
]

{ #category : #styles }
OBTitlePageTemplate >> valueStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 22 pt).
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	^titleStyleSheet.
]
