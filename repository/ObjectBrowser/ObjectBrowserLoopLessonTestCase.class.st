Class {
	#name : #ObjectBrowserLoopLessonTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'lesson',
		'lessonImported'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #adding }
ObjectBrowserLoopLessonTestCase >> addObjectsTo: lesson [ 
	| pepita rosario|
	pepita := self createPepitaObObject: lesson .
	rosario := self createRosarioObObject: lesson .
	lesson createVariableNamed: 'pepita' pointingTo: pepita.
	lesson createVariableNamed: 'rosario' pointingTo: rosario .
	^lesson.
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> assertEquals: block inAllObjectsFrom: aLesson and: otherLesson [
	aLesson variables do: [ :variable 
			 |  self assert: (block value: (self find: variable in: otherLesson) pointsTo)
				equals:  (block value: variable pointsTo) ]

]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> contentPointedTo: anObjectBrowserObject byAtribute: atributeName [
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

{ #category : #accessing }
ObjectBrowserLoopLessonTestCase >> fileName: lessonTitle [
	^lessonTitle asLegalSelector , OBLesson fileOutter fileExtension.
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> find: variable in: aLesson [
	^ aLesson variables detect: [ :v | v name = variable name ]
]

{ #category : #actions }
ObjectBrowserLoopLessonTestCase >> importLesson: aLesson [
	^ OBLesson fileIn: (FileStream fileNamed: (self fileName: aLesson name asFileName)).
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonEmptyTitle [
	
	^'Lesson Empty'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonWithCollectionTitle [
	
	^'Lesson With Collections'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonWithObjectsTitle [
	
	^'Lesson Without State'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonWithPrototypesTitle [
	
	^'LessonWithPrototypes'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonWithStateTitle [
	
	^'LessonWithState'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> lessonWithTestTitle [
	
	^'LessonWithTest'.
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
ObjectBrowserLoopLessonTestCase >> prepareLessonWithCollections [
	| aLesson pepita rosario fileEntry theSet theDictionary |
	fileEntry := self lessonWithCollectionTitle asLegalSelector asFileName asFileReference, '.st'.
	fileEntry ensureDelete.
	aLesson := OBLesson new title: self lessonWithCollectionTitle.
	pepita := self createPepitaObObject: aLesson .
	rosario := self createRosarioObObject: aLesson .
	aLesson createVariableNamed: 'pepita' pointingTo: pepita.
	aLesson createVariableNamed: 'rosario' pointingTo: rosario .
	theSet := (aLesson literalNamed: #set) clone.
	theSet add: pepita baseObject.
	theSet add: rosario baseObject.
	
	theDictionary := (aLesson literalNamed: #dictionary) clone.
	theDictionary at: pepita baseObject put: rosario baseObject.
	theDictionary at: 1 put: 'hola'.
	theDictionary at: 1 put: pepita baseObject.
	
	pepita attributeNamed: 'dondeEstas' pointTo: rosario.
	pepita attributeNamed: 'energia' pointTo: (OBExternalObjectMetaObject for: nil).
	
	^ aLesson
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLessonWithPrototypes [
	|  aLesson clon rosario fileEntry |
	fileEntry := self lessonWithPrototypesTitle asLegalSelector asFileName asFileReference, '.st'.
	fileEntry ensureDelete.
	aLesson := OBLesson new title: self lessonWithPrototypesTitle.
	
	rosario := self createRosarioObObject: aLesson .
	aLesson createVariableNamed: 'rosario' pointingTo: rosario .
	
	clon := rosario clone.
	aLesson addObject: clon.
	aLesson createVariableNamed: 'clon' pointingTo: clon.
	
	clon compileMethod: 'otroMetodo
	^''Soy un clon'''.
	
	^ aLesson
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLessonWithState [
	|  aLesson pepita rosario fileEntry |
	fileEntry := self lessonWithStateTitle asLegalSelector asFileName asFileReference, '.st'.
	fileEntry ensureDelete.
	aLesson := OBLesson new title: self lessonWithStateTitle.
	pepita := self createPepitaObObject: aLesson .
	rosario := self createRosarioObObject: aLesson .
	aLesson createVariableNamed: 'pepita' pointingTo: pepita.
	aLesson createVariableNamed: 'rosario' pointingTo: rosario .
	
	pepita attributeNamed: 'dondeEstas' pointTo: rosario.
	pepita attributeNamed: 'energia' pointTo: (OBExternalObjectMetaObject for: nil).
	
	^ aLesson
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> prepareLessonWithTest [
	|  aLesson fileEntry |
	fileEntry := self lessonWithTestTitle asLegalSelector asFileName asFileReference, '.st'.
	fileEntry ensureDelete.
	aLesson := OBLesson new title: self lessonWithTestTitle.

	aLesson compileTest: 'testSomething ^''all is cool'''.
		
	^ aLesson
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> setUp [

	lesson := nil.
	lessonImported := nil.

]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> tearDown [

	lesson ifNotNilDo: [:l | self tearDownLesson: l. l clean].
	lessonImported ifNotNilDo: #clean.

]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> tearDownLesson: lessonTitle [
	(self fileName: lessonTitle name) asFileReference ensureDelete
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> testExportImportEmptyLessonSuccess [

	lesson := self prepareEmptyLesson.
	lesson fileOut .
	lessonImported := self importLesson: lesson.
	
	self assert: lesson title equals:  lessonImported title.
	self assert: 0 equals:  lessonImported objects size.
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> testExportImportLessonWithCollections [

	lesson := self prepareLessonWithCollections.
	lesson fileOut .
	lessonImported := self importLesson: lesson.
	
	self assert: lesson title equals:  lessonImported title.
	self assert: lessonImported objects size equals:  lesson objects size.
	self assert: (lessonImported objects anySatisfy: [ :obj |
		(obj hasAttributeNamed: 'energia') and: [(self contentPointedTo: obj byAtribute: 'energia') isNil ]
	])
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> testExportImportLessonWithObjectsNoStateSuccess [

	lesson := self prepareLesson.
	lesson fileOut.
	lessonImported := self importLesson: lesson.
	
	self assert: lesson title equals:  lessonImported title.
	self assert: lesson objects size equals:  lessonImported objects size
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> testExportImportLessonWithObjectsStateSuccess [

		lesson := self prepareLessonWithState.
		lesson fileOut.
		lessonImported := self importLesson: lesson.
		
		self assert: lesson title equals:  lessonImported title.
		self assert: lesson objects size equals:  lessonImported objects size.
		self assert: (lessonImported objects anySatisfy: [ :obj |
			(obj hasAttributeNamed: 'energia') and: [(self contentPointedTo: obj byAtribute: 'energia') isNil ]
		]).
		self assert: (self variablesFrom: lesson equalVariablesFrom: lessonImported)
]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> testExportImportLessonWithPrototypesSuccess [

		lesson := self prepareLessonWithPrototypes.
		lesson fileOut.
		lessonImported := self importLesson: lesson.
		
		self assertEquals: [ :obo | (obo methods collect: #selector) , obo attributeNames ] inAllObjectsFrom: lesson and: lessonImported.

]

{ #category : #tests }
ObjectBrowserLoopLessonTestCase >> testExportImportLessonWithTestSuccess [

		lesson := self prepareLessonWithTest.
		lesson fileOut.
		lessonImported := self importLesson: lesson.
		
		self assert: lesson title equals:  lessonImported title.
		self assert: lesson tests size equals:  lessonImported tests size.
]

{ #category : #'as yet unclassified' }
ObjectBrowserLoopLessonTestCase >> variablesFrom: lesson equalVariablesFrom: lessonImported [
	lesson variables
		with: lessonImported variables
		do: [ :v1 :v2 | 
			v1 pointsTo class = v2 pointsTo class
				ifFalse: [ ^ false ] ].
	^ true
]
