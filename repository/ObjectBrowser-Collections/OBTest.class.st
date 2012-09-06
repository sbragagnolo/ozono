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

{ #category : #'as yet unclassified' }
OBTest class >> newText: aTestSelector onLesson: aLesson [
	^self new
		selector: aTestSelector;
		lesson: aLesson;
		yourself
]

{ #category : #'as yet unclassified' }
OBTest >> clickIcon [
	'click all you want it is gona be ok'
]

{ #category : #'as yet unclassified' }
OBTest >> code [
	^lesson executionContext class sourceCodeAt: selector
]

{ #category : #'as yet unclassified' }
OBTest >> icon [
	^result icon.
]

{ #category : #'as yet unclassified' }
OBTest >> initialize [
	result := LOOPTestNotRan new.
]

{ #category : #'as yet unclassified' }
OBTest >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #'as yet unclassified' }
OBTest >> printString [
	^selector 
]

{ #category : #'as yet unclassified' }
OBTest >> run [
	| context |
	context := lesson executionContext.
	context prepare.
	context setTestSelector: self selector.
	^result := self runContext: context.
]

{ #category : #'as yet unclassified' }
OBTest >> runContext: aPreparedContext [
	[[aPreparedContext runCase] on: TestFailure do: [ :signal | ^LOOPTestFailure new: signal ]] on: Error do: [ :signal | ^LOOPTestError new: signal ].
	^LOOPTestSuccess new
]

{ #category : #'as yet unclassified' }
OBTest >> selector [
	^selector
]

{ #category : #'as yet unclassified' }
OBTest >> selector: aTestSelector [
	selector := aTestSelector
]

{ #category : #'as yet unclassified' }
OBTest >> writeExportScriptOn: stream  lesson: aLesson [
	stream
		nextPutAll: aLesson lessonIdentification;
		nextPutAll: ' compileTest: ';
		nextPutAll: '''';
		nextPutAll: ((aLesson executionContext class sourceCodeAt: self selector asSymbol) copyReplaceAll: '''' with: '''''');
		nextPutAll: '''.';
		cr.
]

{ #category : #'as yet unclassified' }
OBTest >> writeYourOwnCodeOn: stream  lesson: aLesson [
	stream
		nextPutAll: ((aLesson executionContext class sourceCodeAt: self selector asSymbol) copyReplaceAll: '''' with: '''''');
		nextPutAll: '''.';
		cr.
]
