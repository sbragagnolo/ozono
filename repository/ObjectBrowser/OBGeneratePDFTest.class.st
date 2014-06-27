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

{ #category : #utils }
OBGeneratePDFTest >> formattedDate [
	^DateAndTime now dayMonthYearDo: [ :d :m :y | d asString , '/' , m asString , '/' , y asString ]. 
]

{ #category : #running }
OBGeneratePDFTest >> setUp [
	super setUp.
	
	currentLesson title:'A Test Lesson'.
	
	lessonToPDF := OBLessonToPDF newOnLesson: currentLesson.
	oldAuthor := lessonToPDF author.
	oldTeacher := lessonToPDF teacher.
	oldCourse := lessonToPDF course.
	
	lessonToPDF author:'anAuthor'.
	lessonToPDF teacher:'aTeacher'.
	lessonToPDF course:'aCourse'.
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
OBGeneratePDFTest >> testInfoPage [
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
OBGeneratePDFTest >> testTitle [
	| pdfDoc titlePage|
	pdfDoc := lessonToPDF buildPDFDocument.
	titlePage := pdfDoc pages at:1.

	self asserts:titlePage containsAParagraphWith:'A Test Lesson'.
	self asserts:titlePage containsAParagraphWith:'anAuthor'.
	self asserts:titlePage containsAParagraphWith:'aCourse'.
	self asserts:titlePage containsAParagraphWith:'aTeacher'.
	self asserts:titlePage containsAParagraphWith:self formattedDate.
]
