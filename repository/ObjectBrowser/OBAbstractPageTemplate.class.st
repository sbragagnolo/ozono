Class {
	#name : #OBAbstractPageTemplate,
	#superclass : #Object,
	#instVars : [
		'lessonToPDF',
		'page',
		'pageNumber'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'instance creation' }
OBAbstractPageTemplate class >> newFor: lessonToPDF pageNumber: pageNumber. [
	^ self new lessonToPDF: lessonToPDF; pageNumber:pageNumber.
]

{ #category : #margins }
OBAbstractPageTemplate >> bottomMargin [
	^35.
]

{ #category : #builder }
OBAbstractPageTemplate >> buildOn: aPDFDoc. [
	self subclassResponsibility.
]

{ #category : #tools }
OBAbstractPageTemplate >> createHeading: text withHeight: height onTop:top. [
	page
		add:
			(PDFParagraphElement new
				styleSheet: self headingStyleSheet;
				dimension: self usableWidth mm @ height mm;
				from: self leftMargin mm @ (self topMargin + top) mm;
				text: text)
]

{ #category : #tools }
OBAbstractPageTemplate >> createLabel: labelText withText: text withHeight: height onTop: top [
	^self createLabel: labelText withText: text withHeight: height onTop: top labelRatio: 0.3
]

{ #category : #tools }
OBAbstractPageTemplate >> createLabel: labelText withText: text withHeight: height onTop: top labelRatio: labelRatio [
	| valueRatio |
	valueRatio := 1 - labelRatio.
	page
		add:
			(PDFParagraphElement new
				styleSheet: self labelStyleSheet;
				dimension: (self usableWidth * labelRatio) mm @ height mm;
				from: self leftMargin mm @ (self topMargin + top) mm;
				text: labelText).
	page
		add:
			(PDFParagraphElement new
				styleSheet: self valueStyleSheet;
				dimension: (self usableWidth * valueRatio) mm @ height mm;
				from: (self leftMargin + (self usableWidth * labelRatio)) mm @ (self topMargin + top + 2) mm;
				text: text).
]

{ #category : #styles }
OBAbstractPageTemplate >> headingStyleSheet [
	^self subclassResponsibility.
]

{ #category : #styles }
OBAbstractPageTemplate >> labelStyleSheet [
	^self subclassResponsibility.
]

{ #category : #margins }
OBAbstractPageTemplate >> leftMargin [
	^30.
]

{ #category : #accessing }
OBAbstractPageTemplate >> lessonToPDF [
	^ lessonToPDF
]

{ #category : #accessing }
OBAbstractPageTemplate >> lessonToPDF:aValue [
	lessonToPDF := aValue.
]

{ #category : #'calculated properties' }
OBAbstractPageTemplate >> pageHeight [
	^(page format height convertTo: Unit mm) value floor.
]

{ #category : #accessing }
OBAbstractPageTemplate >> pageNumber [
	^pageNumber
]

{ #category : #accessing }
OBAbstractPageTemplate >> pageNumber: aValue [
	pageNumber := aValue.
]

{ #category : #'calculated properties' }
OBAbstractPageTemplate >> pageWidth [
	^(page format width convertTo: Unit mm) value floor.
]

{ #category : #margins }
OBAbstractPageTemplate >> rightMargin [
	^30.
]

{ #category : #margins }
OBAbstractPageTemplate >> topMargin [
	^35.
]

{ #category : #'calculated properties' }
OBAbstractPageTemplate >> usableWidth [
	^self pageWidth - self leftMargin - self rightMargin.
]

{ #category : #styles }
OBAbstractPageTemplate >> valueStyleSheet [
	^self subclassResponsibility.
]
