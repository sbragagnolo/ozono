Class {
	#name : #OBPDFVisitor,
	#superclass : #Object,
	#instVars : [
		'builder',
		'objectName'
	],
	#classVars : [
		'debug'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #accessing }
OBPDFVisitor >> builder [
	^ builder
]

{ #category : #accessing }
OBPDFVisitor >> builder: anObject [
	builder := anObject
]

{ #category : #accessing }
OBPDFVisitor >> objectName [
	^objectName.
]

{ #category : #visitor }
OBPDFVisitor >> visitCollection: anOBCollectionMetaObject [ 
	builder createLabel: 'Tipo y elementos: ' translated  withText: anOBCollectionMetaObject baseObject asString.
]

{ #category : #visitor }
OBPDFVisitor >> visitDirectAttribute: anOBDirectAttribute [ 
	builder createLabel: anOBDirectAttribute name asString withText: anOBDirectAttribute objectPointed asString.
]

{ #category : #visitor }
OBPDFVisitor >> visitLesson: lesson [
	lesson variables do:[ :e | e accept: self].
	self visitTests: lesson.
]

{ #category : #visitor }
OBPDFVisitor >> visitLessonVariable: variable [
	builder createSubHeading: variable name.
	objectName := variable name.
	variable pointsTo accept:self.
]

{ #category : #visitor }
OBPDFVisitor >> visitMethod: anOBMethod [ 
	|str|
	str:=self objectName , '>>', anOBMethod code.
	builder createCode:str.
]

{ #category : #visitor }
OBPDFVisitor >> visitObject: anOBObject [ 
	anOBObject attributes do:[:e | e accept:self.].
	anOBObject methods do:[:e | e accept:self.].
	

]

{ #category : #visitor }
OBPDFVisitor >> visitTest: anOBTest [
	builder createCode: anOBTest code.
]

{ #category : #visitor }
OBPDFVisitor >> visitTests: lesson [
	builder createSubHeading: 'Tests'.
	lesson tests do: [ :test | test accept: self ]
]
