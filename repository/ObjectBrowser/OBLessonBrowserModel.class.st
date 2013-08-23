Class {
	#name : #OBLessonBrowserModel,
	#superclass : #Object,
	#instVars : [
		'lessonContainer',
		'window',
		'selectedLesson'
	],
	#category : #'ObjectBrowser-UILessonBrowser'
}

{ #category : #'as yet unclassified' }
OBLessonBrowserModel class >> icon [
	^Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self iconContents readStream).
]

{ #category : #'as yet unclassified' }
OBLessonBrowserModel class >> iconContents [
^'/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRof
Hh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwh
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAAR
CAAPABMDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAA
AgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkK
FhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG
h4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl
5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREA
AgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk
NOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOE
hYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk
5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDuNf1e7hDJZ3EqSi4MbFEDY9M7iAByOfwr
P+2Xh1F7W91SeN5pDCGSdfL3qAxVVHIIHPzHnOOa2PEOgnW4ZreWaVYmPKoQDwQeD25ArIg8
J2E1xv8Asru4m8+V5XGBJjGVA6ccentVpqxjKL5jttOZk0+FVleQBcB2bJb3zRTrSNktUULg
DOAO3NFQbH//2Q=='
]

{ #category : #'as yet unclassified' }
OBLessonBrowserModel class >> menuCommandOn: aBuilder [ 
	<worldMenu>
	(aBuilder item: #'PdeP Software')
		order: 0.1;
		target: self;
		icon: UITheme current homeIcon.
	(aBuilder item: #'Lesson Browser')
		parent: #'PdeP Software';  
		action: [LOOPLesson browseLessons];
		icon: self icon.
]

{ #category : #'as yet unclassified' }
OBLessonBrowserModel class >> on: aLOOPLessonContainer [
	^self new lessonContainer: aLOOPLessonContainer;
		yourself.
]

{ #category : #accessing }
OBLessonBrowserModel >> aboutText [
	^'LOOP version: ', (ConfigurationOfObjectBrowser project version:#stable) versionString
]

{ #category : #importing }
OBLessonBrowserModel >> chooseLessonFile. [
	^ UITheme current
		chooseFileIn: World
		title: 'Selecciona la leccion a importar' translated
		extensions: #('st') 
		path: nil
		preview: nil.
]

{ #category : #creation }
OBLessonBrowserModel >> chooseTheFile. [
	^ UITheme current
		chooseFileIn: self 
		title: 'Selecciona la leccion a importar'
		extensions: #('*.st') 
		path: nil
		preview: nil.
]

{ #category : #creation }
OBLessonBrowserModel >> createFreeLesson [
	| lesson |
	lesson := lessonContainer createFreeLesson.
	lesson openInWorld.

]

{ #category : #creation }
OBLessonBrowserModel >> createNewFreeLesson [
	| lesson lessonName |
	lessonName :=self obtainLessonName.
	lessonName ifNotNil:[
		lesson := lessonContainer createLessonNamed: lessonName .
		lesson openInWorld.
		self changed .
	]
]

{ #category : #export }
OBLessonBrowserModel >> fileOutSelectedLesson [
	self selectedLesson fileOut.
	UIManager inform: 'La lección se exportó correctamente!'.
]

{ #category : #importing }
OBLessonBrowserModel >> importLesson [
	self chooseLessonFile ifNotNil: [ :fileEntry | ^self importLesson: fileEntry ]
]

{ #category : #importing }
OBLessonBrowserModel >> importLesson: aFileEntry [
	"LOOPImportFileList open. - > esto abre el browser con el boton importar que esta ahora"
	| lesson lessonName |
	lesson := LOOPLesson fileIn: aFileEntry.
	lesson openInWorld.
	self changed.
]

{ #category : #importing }
OBLessonBrowserModel >> importLessonLabel [
	^'Importar Leccion'
]

{ #category : #accessing }
OBLessonBrowserModel >> initialize [
	self selectedLesson: NullLOOPLesson new.
]

{ #category : #creation }
OBLessonBrowserModel >> lessonContainer: aLessonContainer [
	lessonContainer := aLessonContainer
]

{ #category : #showing }
OBLessonBrowserModel >> lessonListMenu: aMenu shifted: shifted [
	^aMenu addList: self selectedLesson menuActions.
]

{ #category : #creation }
OBLessonBrowserModel >> lessons [
	^lessonContainer lessons
]

{ #category : #accessing }
OBLessonBrowserModel >> newFreeLessonLabel [
	^'Nueva Leccion' translated 
]

{ #category : #creation }
OBLessonBrowserModel >> obtainLessonName [
	| lessonName |
	lessonName := self request: 'Nombre de la leccion' translated  default: 'Free Lesson'.
	^ lessonName
]

{ #category : #showing }
OBLessonBrowserModel >> openInWorld [
	window := OBLessonBrowserWindow show: self.
]

{ #category : #accessing }
OBLessonBrowserModel >> openSelectedLesson [
	self selectedLesson openInWorld
]

{ #category : #accessing }
OBLessonBrowserModel >> removeSelectedLesson [
	| lesson |
	lesson := self selectedLesson.
	lesson delete.
	self lessons remove: lesson.
	lesson clean.
	self changed.
]

{ #category : #accessing }
OBLessonBrowserModel >> renameSelectedLesson [
	|newTitle|
	
	newTitle := self obtainLessonName.
	(newTitle notNil and: [newTitle notEmpty]) 
		ifTrue: [self selectedLesson title: newTitle.	self changed ].
]

{ #category : #creation }
OBLessonBrowserModel >> request: aTitle default: aDefaultValue [
	^ UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #accessing }
OBLessonBrowserModel >> selectedLesson [
	^selectedLesson
]

{ #category : #accessing }
OBLessonBrowserModel >> selectedLesson: aLOOPLesson [ 
	selectedLesson := aLOOPLesson.
]

{ #category : #creation }
OBLessonBrowserModel >> updateLOOP [
	[
		Gofer it
			url: 'http://www.smalltalkhub.com/mc/Guille/LOOP/main';
			package: 'ConfigurationOfObjectBrowser';
			load.
		(ConfigurationOfObjectBrowser project version: #stable) load.
		self changed: #aboutText.
	] on: Warning do: [ :w | w resume ]
]

{ #category : #creation }
OBLessonBrowserModel >> updateLOOPLabel [
	^'Actualizar Software!' translated 
]
