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
ObjectBrowserLoopLessonTestCase >> importLessonWithState [
	^ LOOPLesson fileIn: (self lessonWithStateTitle asFileName , '.st' ).
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
ObjectBrowserLoopLessonTestCase >> prepareLesson [
	| lesson pepita rosario|
	lesson := LOOPLesson new title: self lessonWithObjectsTitle.
	self addObjectsTo: lesson .
	
	^lesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLessonWithState [
	| lesson pepita rosario|
	lesson := LOOPLesson new title: self lessonWithStateTitle.
	pepita := self createPepitaObObject: lesson .
	rosario := self createRosarioObObject: lesson .
	lesson addVariableNamed: 'pepita' pointingTo: pepita.
	lesson addVariableNamed: 'rosario' pointingTo: rosario .
	
	pepita variable: 'dondeEstas' pointTo: rosario.
	pepita variable: 'energia' pointTo: nil.
	
	^lesson.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testFileInEmptyLessonSuccess [

]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testFileInLessonWithObjectsNoStateSuccess [
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testFileInLessonWithObjectsStateSuccess [
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testFileOutEmptyLessonSuccess [

]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testFileOutLessonWithObjectsNoStateSuccess [
	| lesson lessonImported |
	lesson := self prepareLesson.
	lesson fileOut .
	lessonImported := self importLessonWithObjects.
	self assert: lesson title equals:  lessonImported title.
	self assert: lesson objects equals:  lessonImported objects.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> testFileOutLessonWithObjectsStateSuccess [
	| lesson lessonImported |
	lesson := self prepareLessonWithState.
	lesson fileOut .
	lessonImported := self importLessonWithState.
	self assert: lesson title equals:  lessonImported title.
	self assert: lesson objects size equals:  lessonImported objects size.
	self assert: nil equals:  (self contentPOintedTo: (lessonImported objects at: 1) byAtribute: 'energia'). 
]
