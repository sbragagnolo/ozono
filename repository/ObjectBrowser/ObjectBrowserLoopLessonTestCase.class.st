Class {
	#name : #ObjectBrowserLoopLessonTestCase,
	#superclass : #TestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> addObjectsTo: lesson [ 
	| pepita rosario|
	pepita := self createPepitaObObject: lesson .
	rosario := self createRosarioObObject: lesson .
	lesson addVariableNamed: 'pepita' pointingTo: pepita.
	lesson addVariableNamed: 'rosario' pointingTo: rosario .
	^lesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> contentPOintedTo: anObjectBrowserObject byAtribute: atributeName [
	^(anObjectBrowserObject attributeNamed: atributeName ) objectPointed.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> createPepitaObObject: lesson [
	|pepita|
	
	pepita := lesson createObject.
	pepita addAttributeNamed: 'dondeEstas'.
	pepita addAttributeNamed: 'energia'.
	pepita compileMethod: 'energia
	^30.'.
	pepita compileMethod: 'lugar
	^dondeEstas'.
	pepita compileMethod: 'initialize
	energia := 30.'.
	pepita compileMethod: 'dondeEstas: lugar
	dondeEstas := lugar'.
	
	^pepita .
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> createRosarioObObject: lesson [
	|rosario|
	
	rosario := lesson createObject.
	rosario compileMethod: 'ciudad
	^''Rosario'''.
	
	^rosario .
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> fileName: lessonTitle [
	^lessonTitle asLegalSelector , '.st' .
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> importEmptyLesson [
	^ OBLesson fileIn: (FileStream fileNamed: (self fileName: self lessonEmptyTitle)).
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> importLessonWithObjects [
	^ OBLesson fileIn: (FileStream fileNamed: (self fileName: self lessonWithObjectsTitle )).
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> importLessonWithState [
	^ OBLesson fileIn: (FileStream fileNamed: (self fileName: self lessonWithStateTitle)).
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonEmptyTitle [
	
	^'Lesson Empty'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonWithObjectsTitle [
	
	^'Lesson Without State'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonWithStateTitle [
	
	^'LessonWithState'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareEmptyLesson [
	^ OBLesson new title: self lessonEmptyTitle.

]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLesson [
	| lesson |
	lesson := OBLesson new title: self lessonWithObjectsTitle.
	self addObjectsTo: lesson .
	
	^lesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLessonWithState [
	| lesson pepita rosario fileEntry |
	fileEntry := self lessonWithStateTitle asLegalSelector asFileName asFileReference, '.st'.
	fileEntry ensureDeleted.
	lesson := OBLesson new title: self lessonWithStateTitle.
	pepita := self createPepitaObObject: lesson .
	rosario := self createRosarioObObject: lesson .
	lesson addVariableNamed: 'pepita' pointingTo: pepita.
	lesson addVariableNamed: 'rosario' pointingTo: rosario .
	
	pepita attributeNamed: 'dondeEstas' pointTo: rosario.
	pepita attributeNamed: 'energia' pointTo: (OBExternalObjectMetaObject for: nil).
	
	^lesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> tearDown [
	(self lessonEmptyTitle) asFileReference ensureDeleted.
	(self lessonWithObjectsTitle) asFileReference ensureDeleted.
	(self lessonWithStateTitle) asFileReference ensureDeleted.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> tearDownLesson: lessonTitle [
	(self fileName: lessonTitle) asFileReference ensureDeleted
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testExportImportEmptyLessonSuccess [
	| lesson lessonImported |
	[
		lesson := self prepareEmptyLesson.
		lesson fileOut .
		lessonImported := self importEmptyLesson.
		self assert: lesson title equals:  lessonImported title.
		self assert: 0 equals:  lessonImported objects size.
		self tearDownLesson: self lessonEmptyTitle.
	] ensure: [ 
		lesson clean.
		lessonImported clean.
	]
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testExportImportLessonWithObjectsNoStateSuccess [
	| lesson lessonImported |
	[
		lesson := self prepareLesson.
		lesson fileOut .
		lessonImported := self importLessonWithObjects.
		self assert: lesson title equals:  lessonImported title.
		self assert: lesson objects size equals:  lessonImported objects size.
		self tearDownLesson: self lessonWithObjectsTitle.
	] ensure: [ 
		lesson clean.
		lessonImported clean.
	]
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testExportImportLessonWithObjectsStateSuccess [
	| lesson lessonImported |
	[
		lesson := self prepareLessonWithState.
		lesson fileOut .
		lessonImported := self importLessonWithState.
		self assert: lesson title equals:  lessonImported title.
		self assert: lesson objects size equals:  lessonImported objects size.
		self assert: (lessonImported objects anySatisfy: [ :obj |  (obj hasAttributeNamed: 'energia') and: [(self contentPOintedTo: obj byAtribute: 'energia') isNil ]]).
		self tearDownLesson: self lessonWithStateTitle.
	] ensure: [ 
		lesson clean.
		lessonImported clean.
	]
]
