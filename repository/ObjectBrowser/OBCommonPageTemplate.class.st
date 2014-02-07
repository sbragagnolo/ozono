Class {
	#name : #OBCommonPageTemplate,
	#superclass : #OBAbstractPageTemplate,
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #builder }
OBCommonPageTemplate >> buildOn: aPDFDoc. [
	page := PDFPage new.	
	aPDFDoc add: page.
	
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
