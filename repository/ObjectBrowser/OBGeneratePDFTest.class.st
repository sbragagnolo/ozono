Class {
	#name : #OBGeneratePDFTest,
	#superclass : #OBTestCase,
	#instVars : [
		'lessonToPDF',
		'oldAuthor',
		'oldTeacher',
		'oldCourse'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #asserts }
OBGeneratePDFTest >> asserts: aPDFPage containsAParagraphWith: aString [ 
	| paragraphElements |
	paragraphElements := aPDFPage elements select: [ :e | e isKindOf: PDFCompositeText ].
	self assert:(paragraphElements anySatisfy: [ :e | e text = aString ])
]

{ #category : #running }
OBGeneratePDFTest >> fillUpLesson [
	| pepita |
	currentLesson title: 'A Test Lesson'.
	pepita := currentLesson createObject.
	pepita addAttributeNamed: 'energia'.
	pepita attributeNamed: 'energia' pointTo: (OBExternalObjectMetaObject for: 1234).	
		
	currentLesson createVariableNamed: 'pepita' pointingTo: pepita.

]

{ #category : #utils }
OBGeneratePDFTest >> formattedDate [
	^DateAndTime now dayMonthYearDo: [ :d :m :y | d asString , '/' , m asString , '/' , y asString ]. 
]

{ #category : #running }
OBGeneratePDFTest >> setUp [
	super setUp.
	self fillUpLesson.
	lessonToPDF := OBLessonToPDF newOnLesson: currentLesson.
	oldAuthor := lessonToPDF author.
	oldTeacher := lessonToPDF teacher.
	oldCourse := lessonToPDF course.
	lessonToPDF author: 'anAuthor'.
	lessonToPDF teacher: 'aTeacher'.
	lessonToPDF course: 'aCourse'
]

{ #category : #running }
OBGeneratePDFTest >> tearDown [
	super tearDown.
	lessonToPDF author: oldAuthor .
	lessonToPDF teacher: oldTeacher.
	lessonToPDF course: oldCourse.
]

{ #category : #tests }
OBGeneratePDFTest >> testControlCode [
	|  expectedValue |
	expectedValue := self formattedDate , '-anAuthor-A Test Lesson'.	
	self assert:lessonToPDF controlCode base64Decoded = expectedValue.
]

{ #category : #tests }
OBGeneratePDFTest >> testHeaderAndFooter [
	| pdfDoc|
	pdfDoc := lessonToPDF buildPDFDocument.
	pdfDoc pages
		do: [ :page | 
			self asserts: page containsAParagraphWith: 'A Test Lesson'.
			self asserts: page containsAParagraphWith: 'anAuthor'.
			self asserts: page containsAParagraphWith: 'aCourse'.
			self asserts: page containsAParagraphWith: 'aTeacher'.
			self asserts: page containsAParagraphWith: self formattedDate ]
]

{ #category : #tests }
OBGeneratePDFTest >> testInfoSection [
	| pdfDoc infoPage |
	pdfDoc := lessonToPDF buildPDFDocument.
	infoPage := pdfDoc pages at: 1.
	self asserts: infoPage containsAParagraphWith: lessonToPDF operatingSystem.
	self asserts: infoPage containsAParagraphWith: lessonToPDF pharoVersion.
	self asserts: infoPage containsAParagraphWith: lessonToPDF ozonoVersion.
	self asserts: infoPage containsAParagraphWith: lessonToPDF vmVersion.
	self asserts: infoPage containsAParagraphWith: lessonToPDF formattedControlCode.
]

{ #category : #tests }
OBGeneratePDFTest >> testObjectSection [
	| pdfDoc page |
	pdfDoc := lessonToPDF buildPDFDocument.
	page := pdfDoc pages at: 1.
	
	self asserts: page containsAParagraphWith: 'pepita'.
	self asserts: page containsAParagraphWith: '1234'.
]
