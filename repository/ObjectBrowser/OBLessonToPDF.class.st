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
OBLessonToPDF class >> newOnLesson: aLesson [
	^ self new lesson: aLesson
]

{ #category : #builder }
OBLessonToPDF >> addPagesTo: pdfDoc [
	(OBPDFBuilder new lessonToPDF:self) buildOn:pdfDoc.
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
	| pdfDoc replacer |
	pdfDoc := PDFDocument new.
	
	pdfDoc metaData title: lesson title; 
		subject: ''; 
		author: self author; 
		keywords: '';
		creator: 'Ozono - Pharo'.
	
	pdfDoc format: PDFA4Format new.

	self addPagesTo: pdfDoc.
	
	replacer := OBLabelReplacer new.
	replacer at:#pages put: pdfDoc pages size.
	replacer replaceAll:pdfDoc.
	
	^pdfDoc.
]

{ #category : #labels }
OBLessonToPDF >> cancelLabel [
	^'Cancelar' translated.
]

{ #category : #calculated }
OBLessonToPDF >> controlCode [
	| seed |
	seed := self formattedDate , '-' , self author , '-' , self lesson title.
	^ seed base64Encoded
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

{ #category : #labels }
OBLessonToPDF >> diagramForm [
	^ lesson objectDiagram imageForm.
]

{ #category : #accessing }
OBLessonToPDF >> filename [
	^ filename ifNil:[ filename := self lesson title , ' - ' , self author , '.pdf']
]

{ #category : #accessing }
OBLessonToPDF >> filename: anObject [
	filename := anObject
]

{ #category : #calculated }
OBLessonToPDF >> formattedControlCode [
	| r |
	r:=''.
	self controlCode withIndexDo: [ :e :i |
		( i \\ 16 = 0) ifTrue:[ r := r , ' ' ].
		r := r , e asString.
	].
	^r.
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
	aStream truncate:aStream size.
	aStream close.

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
	^Smalltalk platform prettyName.
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
