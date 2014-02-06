Class {
	#name : #OBLessonToPDF,
	#superclass : #Object,
	#instVars : [
		'lesson'
	],
	#classVars : [
		'author',
		'course',
		'teacher'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'instance creation' }
OBLessonToPDF class >> newOnLesson:aLesson [
	^self new lesson:aLesson.
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
	lesson := anOBLesson
]

{ #category : #calculated }
OBLessonToPDF >> operatingSystem [
	^Smalltalk platform version
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
