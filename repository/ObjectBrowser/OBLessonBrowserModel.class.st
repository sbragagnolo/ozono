"
I am the model of the lesson browser window
"
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
^  'iVBORw0KGgoAAAANSUhEUgAAABAAAAAMCAYAAABr5z2BAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAAbwAAAG8B8aLcQwAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AAIfSURBVCiRY/j//z8DMbit/JrBlOa3TujiTAxooLXsivuCPgZWZLGqnMOm//8zxGfXCO1D
V49iQE3ece0fPz/XJRQx/EbSbMTFyd8rJa5ZAhMrz9wX31J6uZWBgYGBBSa4oI+B+9L1rQtk
JHU3MzBYwjRrf/76ehEPt0gQAwMDY0HKllQebuGEf///XpCR1C1GMWDPkclLbt0/ou7hUBLE
wMDAUJ17RO3wqXkr2dm4/7z/+DT95r2DHizMbOclxTRCWyZaPoM7+////wwl6buiBPmlf5vo
BT9Oj17S1Fl5287BMu0iAwPDf2FB+R8B7g2bqnOPmmALXIb///8zeDtV7GdgYPjPwMDwn4mJ
+b+UuNZvBgaG/+YGEZeKUreH4IsdhtmdP5QUZIx/wgyAYT5e8X/VucfSCEUvCwsL+2Nv54oj
s5fHO/369Q3utU+fXzK+fncvqCbv/2c2Vq63gvzSt3h5RB8yMDAwQmOPkYGBgZExN3F9wPb9
XTPuPDgujh7HLMxsDOxs3AysrBwMosJKnwX5ZT7///+PgYdLiNlEL+QdH6/4NpafP7/kv3p7
T1xe2vCnqLDSu0s3tkvCXPLn7y+GP99/MTB8Z2D4/ecnr5CA3AtJMY3jyvIW27XUXFYmFDH8
Z5zV+UP+5etbKjKSurcZGBhe7TkyefmjpxcUGRj+MzExsf7k5RZ+KCQg90BcVOW4lqrLhoQi
hr/IrgQALWYsWii40fMAAAAASUVORK5CYII='
]

{ #category : #'as yet unclassified' }
OBLessonBrowserModel class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Ozono)
		order: 0.1;
		action: [ OBLesson browseLessons ];
		icon: self icon
]

{ #category : #'as yet unclassified' }
OBLessonBrowserModel class >> on: aLOOPLessonContainer [
	^self new lessonContainer: aLOOPLessonContainer;
		yourself.
]

{ #category : #labels }
OBLessonBrowserModel >> aboutText [
	^(TextStream on: String new)
		nextPutAll: 'Ozono version: ', (BaselineOfOzono project currentVersion) versionString;
		crlf;
		nextPutAll: 'Ozono mcz: ', OBLessonToPDF new ozonoVersion ;
		crlf;		
		nextPutAll: 'Pharo version: ' , OBLessonToPDF new pharoVersion ;
		crlf;
		nextPutAll: 'VM version: ' , OBLessonToPDF new vmVersion ;
		crlf;
		nextPutAll: 'OS version: ' , OBLessonToPDF new operatingSystem ;
		contents.
]

{ #category : #private }
OBLessonBrowserModel >> chooseLessonFile [

	^ UITheme current
		chooseFileIn: World
		title: 'Selecciona la leccion a importar' translated
		extensions: #('st', 'ob', 'o3') 
		path: nil
		preview: nil.
]

{ #category : #actions }
OBLessonBrowserModel >> createNewFreeLesson [

	| lesson lessonName |
	lessonName :=self obtainLessonName.
	lessonName ifNotNil:[
		lesson := lessonContainer createLessonNamed: lessonName .
		lesson openInWorld.
		self changed .
	]
]

{ #category : #actions }
OBLessonBrowserModel >> fileOutSelectedLesson [
	[ 
	self selectedLesson fileOut.
	UIManager inform: self lessonExportedMessage ]
		on: FileExistsException
		do: [ UIManager inform: self lessonExportErrorMessage ]
]

{ #category : #actions }
OBLessonBrowserModel >> importLesson [

	self chooseLessonFile ifNotNil: [ :fileEntry | ^self importLesson: fileEntry ]
]

{ #category : #actions }
OBLessonBrowserModel >> importLesson: aFileEntry [

	| lesson |
	lesson := OBLesson fileIn: aFileEntry.
	lesson openInWorld.
	self changed.
]

{ #category : #labels }
OBLessonBrowserModel >> importLessonLabel [

	^'Importar Lección' translated
]

{ #category : #'initialize-release' }
OBLessonBrowserModel >> initialize [

	self selectedLesson: OBNullLesson new.
]

{ #category : #accessing }
OBLessonBrowserModel >> lessonContainer: aLessonContainer [

	lessonContainer := aLessonContainer
]

{ #category : #actions }
OBLessonBrowserModel >> lessonExportErrorMessage [ 
	^ 'No se pudo exportar la lección' translated
]

{ #category : #actions }
OBLessonBrowserModel >> lessonExportedMessage [ 
	^ '¡La lección se exportó correctamente!' translated
]

{ #category : #accessing }
OBLessonBrowserModel >> lessons [

	^lessonContainer lessons
]

{ #category : #labels }
OBLessonBrowserModel >> newFreeLessonLabel [

	^'Nueva Lección' translated 
]

{ #category : #private }
OBLessonBrowserModel >> obtainLessonName [

	| lessonName |
	lessonName := self request: 'Nombre de la leccion' translated  default: 'Free Lesson'.
	^ lessonName
]

{ #category : #showing }
OBLessonBrowserModel >> openInWorld [

	window := OBLessonBrowserWindow show: self.
]

{ #category : #actions }
OBLessonBrowserModel >> openSelectedLesson [

	self selectedLesson openInWorld
]

{ #category : #actions }
OBLessonBrowserModel >> pdfSelectedLesson [
	(OBGeneratePDFWindow newOnLesson:selectedLesson) openInWorld.
]

{ #category : #labels }
OBLessonBrowserModel >> printLessonLabel [
	^'Imprimir Lección' translated
]

{ #category : #actions }
OBLessonBrowserModel >> removeSelectedLesson [

	| lesson |
	lesson := self selectedLesson.
	lesson delete.
	self lessons remove: lesson.
	lesson clean.
	self changed.
]

{ #category : #actions }
OBLessonBrowserModel >> renameSelectedLesson [

	| newTitle |
	newTitle := self obtainLessonName.
	(newTitle notNil and: [ newTitle notEmpty ])
		ifTrue: [ 
			self selectedLesson title: newTitle.
			self changed ]
]

{ #category : #private }
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

{ #category : #updating }
OBLessonBrowserModel >> updateLOOP [

	[
		Gofer it
			url: 'http://www.smalltalkhub.com/mc/Uqbar/Ozono/main';
			package: 'ConfigurationOfObjectBrowser';
			load.
		(ConfigurationOfObjectBrowser project version: #stable) load.
		self changed: #aboutText.
	] on: Warning do: [ :w | w resume  ]
]

{ #category : #labels }
OBLessonBrowserModel >> updateLOOPLabel [

	^'¡Actualizar Software!' translated 
]
