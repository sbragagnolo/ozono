Class {
	#name : #OBAbstractPageTemplate,
	#superclass : #Object,
	#instVars : [
		'model',
		'page',
		'doc'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'instance creation' }
OBAbstractPageTemplate class >> newFor: lessonToPDF [
	^ self new model: lessonToPDF.
]

{ #category : #builder }
OBAbstractPageTemplate >> buildOn: aPDFDoc. [
	page := PDFPage new.	
	doc := aPDFDoc.
	doc add:page.
	
	self buildPage.
]

{ #category : #builder }
OBAbstractPageTemplate >> buildPage [
	^self subclassResponsibility.
]

{ #category : #styles }
OBAbstractPageTemplate >> headingStyleSheet [
	^self subclassResponsibility.
]

{ #category : #styles }
OBAbstractPageTemplate >> labelStyleSheet [
	^self subclassResponsibility.
]

{ #category : #accessing }
OBAbstractPageTemplate >> model [
	^model.

]

{ #category : #accessing }
OBAbstractPageTemplate >> model:aValue [
	model := aValue.

]

{ #category : #styles }
OBAbstractPageTemplate >> valueStyleSheet [
	^self subclassResponsibility.
]
