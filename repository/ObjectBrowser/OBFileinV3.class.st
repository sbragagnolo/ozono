Class {
	#name : #OBFileinV3,
	#superclass : #Object,
	#instVars : [
		'bindingScope'
	],
	#category : #'ObjectBrowser-Filein'
}

{ #category : #bindings }
OBFileinV3 >> beOldVersion [

	bindingScope := OBBindingsV2AndBelow new
]

{ #category : #bindings }
OBFileinV3 >> bindingScope [

	^ bindingScope
]

{ #category : #filein }
OBFileinV3 >> fileIn: aFileEntry [

	| lessonImported fileContents stream |
	
	stream := aFileEntry readStream.
	fileContents := stream contents.
	stream close.
	
	(fileContents beginsWith: OBFileOutV3 fileOutVersionHeader3)
		ifFalse: [ self beOldVersion ].
	
	Author fullName ifNil: [Author requestFullName].	
	SystemAnnouncer uniqueInstance suspendAllWhile: [
		[ [
			ClassBuilder beSilent: true.
			lessonImported := Compiler new 
				evaluate: fileContents
				in: nil
				to: self bindingScope
				notifying: nil
				ifFail: [ ^nil ]
				logged: true.
			lessonImported isNil ifTrue: [self error: 'La Lección no pudo ser importada'].
			^ lessonImported.
			] valueSuppressingAllMessages.
		] ensure: [ 
			ClassBuilder beSilent: false.
		].
	]
]

{ #category : #'initialize-release' }
OBFileinV3 >> initialize [

	super initialize.
	bindingScope := OBLesson.
]
