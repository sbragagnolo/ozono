Class {
	#name : #OBFileinV3,
	#superclass : #Object,
	#category : #'ObjectBrowser-Filein'
}

{ #category : #filein }
OBFileinV3 >> fileIn: aFileEntry [

	| lessonImported inStream |
	
	Author fullName ifNil: [Author requestFullName].	
	SystemAnnouncer uniqueInstance suspendAllWhile: [
		[ [
			ClassBuilder beSilent: true.
			inStream := aFileEntry readStream.
			lessonImported := Compiler new 
				evaluate: inStream
				in: nil
				to: OBLesson
				notifying: nil
				ifFail: [ ^nil ]
				logged: true.
			] valueSuppressingAllMessages.
		] ensure: [ 
			ClassBuilder beSilent: false.
			inStream ifNotNilDo: [ :s | s close ]
		].
		lessonImported isNil ifTrue: [self error: 'La Lección no pudo ser importada'].
		^ lessonImported.
	]
]
