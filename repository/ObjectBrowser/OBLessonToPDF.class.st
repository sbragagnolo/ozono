"
An OBLessonToPDF is a builder to generate the PDF.
"
Class {
	#name : #OBLessonToPDF,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'filename',
		'date'
	],
	#classVars : [
		'author',
		'course',
		'path',
		'teacher'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'instance creation' }
OBLessonToPDF class >> newOnLesson:aLesson [
	^self new lesson:aLesson.
]

{ #category : #builder }
OBLessonToPDF >> addPagesTo: pdfDoc [
	(OBTitlePageTemplate newFor:self) buildOn:pdfDoc.
]

{ #category : #accessing }
OBLessonToPDF >> author [
	^author.
]

{ #category : #accessing }
OBLessonToPDF >> author: aString [ 
	author := aString.
]

{ #category : #labels }
OBLessonToPDF >> authorLabel [
	^'Autor' translated.
]

{ #category : #builder }
OBLessonToPDF >> buildPDFDocument [
	| pdfDoc |
	pdfDoc := PDFDocument new.
	
	pdfDoc metaData title: lesson title; 
		subject: ''; 
		author: self author; 
		keywords: '';
		creator: 'Ozono - Pharo'.
	
	pdfDoc format: PDFA4Format new.

	self addPagesTo:pdfDoc.
	
	^pdfDoc.
]

{ #category : #labels }
OBLessonToPDF >> cancelLabel [
	^'Cancelar' translated.
]

{ #category : #accessing }
OBLessonToPDF >> course [
	^course.
]

{ #category : #accessing }
OBLessonToPDF >> course:aValue [
	course:= aValue.
]

{ #category : #labels }
OBLessonToPDF >> courseLabel [
	^'Curso' translated.
]

{ #category : #accessing }
OBLessonToPDF >> date [
	^date ifNil:[ DateAndTime now].
]

{ #category : #accessing }
OBLessonToPDF >> filename [
	^ filename ifNil:[ filename := self lesson title , ' - ' , self author , '.pdf']
]

{ #category : #accessing }
OBLessonToPDF >> filename: anObject [
	filename := anObject
]

{ #category : #accessing }
OBLessonToPDF >> formattedDate [
	^ self date dayMonthYearDo: [ :d :m :y | d asString , '/' , m asString , '/' , y asString ].

]

{ #category : #calculated }
OBLessonToPDF >> fullpath [
	^ (self path endsWith: '/')
		ifTrue:[ self path , self filename ]
		ifFalse:[ self path , '/' , self filename]
]

{ #category : #actions }
OBLessonToPDF >> generate [
	| aStream |
	aStream := FileStream fileNamed: self fullpath.
	self buildPDFDocument exportTo: aStream.

]

{ #category : #labels }
OBLessonToPDF >> generateLabel [
	^'Generar PDF' translated.
]

{ #category : #accessing }
OBLessonToPDF >> lesson [
	^ lesson
]

{ #category : #accessing }
OBLessonToPDF >> lesson: anOBLesson [ 
	lesson := anOBLesson.

]

{ #category : #calculated }
OBLessonToPDF >> operatingSystem [
	^Smalltalk platform version
]

{ #category : #calculated }
OBLessonToPDF >> ozonoVersion [
	|wc|
	wc := (MCWorkingCopy hasPackageNamed:'ObjectBrowser').
	^wc ancestry ancestorStringWithout: wc packageName
]

{ #category : #accessing }
OBLessonToPDF >> path [
	^ path ifNil:[ path:= './'].
]

{ #category : #accessing }
OBLessonToPDF >> path: aPath [
	 path := aPath.
]

{ #category : #calculated }
OBLessonToPDF >> pharoVersion [
	^ Smalltalk version , ' ' , Smalltalk lastUpdateString
]

{ #category : #accessing }
OBLessonToPDF >> teacher [
	^teacher.
]

{ #category : #accessing }
OBLessonToPDF >> teacher:aValue. [
	teacher := aValue.
]

{ #category : #labels }
OBLessonToPDF >> teacherLabel [
	^'Profesor' translated.
]

{ #category : #accessing }
OBLessonToPDF >> title [
	^ 'Generar PDF' translated , ' - ' ,  self lesson title.
]

{ #category : #calculated }
OBLessonToPDF >> vmVersion [
	^ Smalltalk vm version.
]
