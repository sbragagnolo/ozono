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
	^(anObjectBrowserObject variableNamed: atributeName ) objectPointed.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> createPepitaObObject: lesson [
	|pepita|
	
	pepita := ObjectBrowserObject newOn: lesson.
	pepita addVariable: 'dondeEstas'.
	pepita addVariable: 'energia'.
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
	
	rosario := ObjectBrowserObject newOn: lesson.
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
	^ LOOPLesson fileIn: (FileStream fileNamed: (self fileName: self lessonEmptyTitle)).
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> importLessonWithObjects [
	^ LOOPLesson fileIn: (FileStream fileNamed: (self fileName: self lessonWithObjectsTitle )).
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> importLessonWithState [
	^ LOOPLesson fileIn: (FileStream fileNamed: (self fileName: self lessonWithStateTitle)).
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
	^ LOOPLesson new title: self lessonEmptyTitle.

]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLesson [
	| lesson |
	lesson := LOOPLesson new title: self lessonWithObjectsTitle.
	self addObjectsTo: lesson .
	
	^lesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLessonWithState [
	| lesson pepita rosario fileEntry |
	fileEntry := FileDirectory directoryEntryFor: self lessonWithStateTitle asLegalSelector asFileName,'.st'.
	fileEntry ifNotNil: [ :f | f delete ].
	lesson := LOOPLesson new title: self lessonWithStateTitle.
	pepita := self createPepitaObObject: lesson .
	rosario := self createRosarioObObject: lesson .
	lesson addVariableNamed: 'pepita' pointingTo: pepita.
	lesson addVariableNamed: 'rosario' pointingTo: rosario .
	
	pepita variable: 'dondeEstas' pointTo: rosario.
	pepita variable: 'energia' pointTo: (NoObjectBrowserObject for: nil).
	
	^lesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> tearDown [
	FileDirectory default deleteFileNamed: self lessonEmptyTitle ifAbsent: [].
	FileDirectory default deleteFileNamed: self lessonWithObjectsTitle ifAbsent: [].
	FileDirectory default deleteFileNamed: self lessonWithStateTitle ifAbsent: [].
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> tearDownLesson: lessonTitle [
	FileDirectory default deleteFileNamed: (self fileName: lessonTitle)
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
		self assert: (lessonImported objects anySatisfy: [ :obj |  (obj hasVariable: 'energia') and: [(self contentPOintedTo: obj byAtribute: 'energia') isNil ]]).
		self tearDownLesson: self lessonWithStateTitle.
	] ensure: [ 
		lesson clean.
		lessonImported clean.
	]
]
