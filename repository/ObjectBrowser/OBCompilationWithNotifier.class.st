Class {
	#name : #OBCompilationWithNotifier,
	#superclass : #OBTestCase,
	#instVars : [
		'pepita',
		'code'
	],
	#category : #'ObjectBrowser-Tests'
}

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
		pepita compileMethod: code notifying: self.
	] on: UndeclaredVariable do: [ :notification |
		notification declareInstVariable.
	].
	self assert: (pepita baseObject class instVarNames includes: self unknownVariableName).
]

{ #category : #tests }
OBCompilationWithNotifier >> testWrittenUknownVariableAndAddedOnTheFlyAsTemp [

	[
		pepita compileMethod: code notifying: self.
	] on: UndeclaredVariable do: [ :notification |
		notification declareTempVariable.
	].
	self deny: (pepita baseObject class instVarNames includes: self unknownVariableName).
]

{ #category : #running }
OBCompilationWithNotifier >> unknownVariableName [

	^ 'anUnknownVariable'
]
