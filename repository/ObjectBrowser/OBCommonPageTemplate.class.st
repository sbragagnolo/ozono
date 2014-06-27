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
