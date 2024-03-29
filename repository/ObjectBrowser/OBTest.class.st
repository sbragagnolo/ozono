"
I am a test of the object browser. I run using the variables of the lesson.
"
Class {
	#name : #OBTest,
	#superclass : #Object,
	#instVars : [
		'selector',
		'lesson',
		'result'
	],
	#category : #'ObjectBrowser-TestFramework'
}

{ #category : #'instance-creation' }
OBTest class >> newWithSelector: aTestSelector onLesson: aLesson [
	^self new
		selector: aTestSelector;
		lesson: aLesson;
		yourself
]

{ #category : #visiting }
OBTest >> accept: aVisitor [

	^ aVisitor visitTest: self
]

{ #category : #accessing }
OBTest >> code [
	^lesson executionContext class sourceCodeAt: selector
]

{ #category : #ui }
OBTest >> deleteConfirmationMessage [
	^ '¿Está seguro de eliminar el test?' translated
]

{ #category : #'*ObjectBrowser-Fileout' }
OBTest >> fileOut [

	OBLesson fileOutter export: self.
]

{ #category : #ui }
OBTest >> icon [
	^result icon.
]

{ #category : #'initialize-release' }
OBTest >> initialize [

	super initialize.
	result := OBTestNotRun new.
]

{ #category : #accessing }
OBTest >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #selection }
OBTest >> makeSelectionOn: anObjectBrowser [
	anObjectBrowser testCaseSelected: self.
]

{ #category : #accessing }
OBTest >> name [

	^ selector
]

{ #category : #printing }
OBTest >> printString [
	^selector 
]

{ #category : #running }
OBTest >> run [

	| context |
	context := lesson executionContext.
	context prepare.
	context setTestSelector: self selector.
	[ ^ result := self runContext: context ] ensure: [
		"We restore the lesson in the context because the test framework wipes all the variables in it and puts a nil in them"
		context lesson: lesson.
		"We restore the variables also."
		context prepare.
	]
]

{ #category : #running }
OBTest >> runContext: aPreparedContext [
	[ 
	[ aPreparedContext runCase ]
		on: TestFailure
		do: [ :signal | ^ OBTestFailure new: signal ] ]
		on: Error
		do: [ :signal | ^ OBTestError new: signal ].
	^ OBTestSuccess new
]

{ #category : #accessing }
OBTest >> selector [
	^selector
]

{ #category : #accessing }
OBTest >> selector: aTestSelector [
	selector := aTestSelector
]
