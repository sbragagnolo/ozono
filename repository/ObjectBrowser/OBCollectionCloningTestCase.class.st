Class {
	#name : #OBCollectionCloningTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'lessonModel',
		'workspace',
		'obj'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
OBCollectionCloningTestCase >> setUp [
	super setUp.
	workspace :=  currentLesson createWorkspace: 'WS' contents: ''.
	
	lessonModel := OBLessonModel onLesson: currentLesson.
	
	lessonModel createVariable: 'obj'.
	obj := lessonModel variableNamed: 'obj'.
	obj pointsTo addAttributeNamed:'x'.
	obj pointsTo compileMethod: 'x. ^x'.
	obj pointsTo compileMethod: 'x:aValue.  x:= aValue'.
]

{ #category : #'as yet unclassified' }
OBCollectionCloningTestCase >> tearDown [ 
	super tearDown.
	workspace closeYourself.
]

{ #category : #'as yet unclassified' }
OBCollectionCloningTestCase >> testCloneBag [
	self executeOnWorkspace: workspace code: 'obj x: bag clone'. 
	self assert: obj pointsTo baseObject x class = OBBag.
	self assert: obj pointsTo baseObject x isEmpty.
]

{ #category : #'as yet unclassified' }
OBCollectionCloningTestCase >> testCloneOrdered [
	self executeOnWorkspace: workspace code: 'obj x: ordered clone'. 
	self assert: obj pointsTo baseObject x class = OBOrderedCollection.
	self assert: obj pointsTo baseObject x isEmpty.
]

{ #category : #'as yet unclassified' }
OBCollectionCloningTestCase >> testCloneSet [
	self executeOnWorkspace: workspace code: 'obj x: set clone'. 
	self assert: obj pointsTo baseObject x class = OBSet.
	self assert: obj pointsTo baseObject x isEmpty.	
]
