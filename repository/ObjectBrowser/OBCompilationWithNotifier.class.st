Class {
	#name : #OBCompilationWithNotifier,
	#superclass : #OBTestCase,
	#instVars : [
		'pepita',
		'code',
		'textEditor'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #tests }
OBCompilationWithNotifier >> mockNotifier [
	^OBNotifierMock new test:self;
	code: code;
	yourself.
]

{ #category : #running }
OBCompilationWithNotifier >> setUp [
	super setUp.
	pepita := currentLesson createObject.
	code := 'createOrdered 
		{var} := nil.
		^{var}.' format: { 'var' -> self unknownVariableName} asDictionary.

]

{ #category : #tests }
OBCompilationWithNotifier >> testUknownVariableIsUnknown [

	self deny: (pepita baseObject class instVarNames includes: 'anUnknownVariable').
]

{ #category : #tests }
OBCompilationWithNotifier >> testWrittenUknownVariableAndAddedOnTheFlyAsInstance [

	[
		pepita compileMethod: code notifying: self mockNotifier.
	] on: OCUndeclaredVariableWarning do: [ :notification |
		notification declareInstVar: notification node name.
	].
	self assert: (pepita baseObject class instVarNames includes: self unknownVariableName).
]

{ #category : #tests }
OBCompilationWithNotifier >> testWrittenUknownVariableAndAddedOnTheFlyAsTemp [

	[
		pepita compileMethod: code notifying: self mockNotifier.
	] on: OCUndeclaredVariableWarning do: [ :notification |
		notification declareTempAndPaste: notification node name.
	].
	self deny: (pepita baseObject class instVarNames includes: self unknownVariableName).
]

{ #category : #running }
OBCompilationWithNotifier >> unknownVariableName [

	^ 'anUnknownVariable'
]
