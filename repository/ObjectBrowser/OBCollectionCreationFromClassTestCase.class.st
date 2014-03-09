Class {
	#name : #OBCollectionCreationFromClassTestCase,
	#superclass : #OBTestCase,
	#instVars : [
		'lessonModel',
		'workspace',
		'obj'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
OBCollectionCreationFromClassTestCase >> setUp [
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
OBCollectionCreationFromClassTestCase >> tearDown [ 
	super tearDown.
	workspace closeYourself.
]

{ #category : #'as yet unclassified' }
OBCollectionCreationFromClassTestCase >> testNewBag [
	self executeOnWorkspace: workspace code: 'obj x: Bag new'. 
	self assert: obj pointsTo baseObject x class = OBBag.
	self assert: obj pointsTo baseObject x isEmpty.
]

{ #category : #'as yet unclassified' }
OBCollectionCreationFromClassTestCase >> testNewBagInObject [
	obj pointsTo compileMethod: ' createX. x:= Bag  new. '.
	self executeOnWorkspace: workspace code: 'obj createX.'. 
	self assert: obj pointsTo baseObject x class = OBBag.
	self assert: obj pointsTo baseObject x isEmpty.
]

{ #category : #'as yet unclassified' }
OBCollectionCreationFromClassTestCase >> testNewOrderedCollection [
	self executeOnWorkspace: workspace code: 'obj x: OrderedCollection new'. 
	self assert: obj pointsTo baseObject x class = OBOrderedCollection.
	self assert: obj pointsTo baseObject x isEmpty.
]

{ #category : #'as yet unclassified' }
OBCollectionCreationFromClassTestCase >> testNewOrderedCollectionInObject [
	obj pointsTo compileMethod: ' createX. x:= OrderedCollection new. '.
	self executeOnWorkspace: workspace code: 'obj createX.'. 
	self assert: obj pointsTo baseObject x class = OBOrderedCollection.
	self assert: obj pointsTo baseObject x isEmpty.
]

{ #category : #'as yet unclassified' }
OBCollectionCreationFromClassTestCase >> testNewSet [
	self executeOnWorkspace: workspace code: 'obj x: Set new'. 
	self assert: obj pointsTo baseObject x class = Set.
	self assert: obj pointsTo baseObject x isEmpty.
]

{ #category : #'as yet unclassified' }
OBCollectionCreationFromClassTestCase >> testNewSetInObject [
	obj pointsTo compileMethod: ' createX. x:= Set new. '.
	self executeOnWorkspace: workspace code: 'obj createX.'. 
	self assert: obj pointsTo baseObject x class = OBSet.
	self assert: obj pointsTo baseObject x isEmpty.
]
