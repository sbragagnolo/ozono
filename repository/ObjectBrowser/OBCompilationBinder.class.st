Class {
	#name : #OBCompilationBinder,
	#superclass : #Object,
	#instVars : [
		'class',
		'lesson'
	],
	#category : #'ObjectBrowser-PharoLayer'
}

{ #category : #'instance creation' }
OBCompilationBinder class >> onLesson: aLesson forClass: aClass [

	^ self new 
			lesson: aLesson;
			class: aClass;
			yourself
]

{ #category : #compiling }
OBCompilationBinder >> addInstVarNamed: aName [

	class addInstVarNamed: aName
]

{ #category : #compiling }
OBCompilationBinder >> allInstVarNames [

	^ class allInstVarNames
]

{ #category : #compiling }
OBCompilationBinder >> bindingOf: aName [ 

	^ lesson bindingOf: aName
]

{ #category : #accessing }
OBCompilationBinder >> class: anOBClass [

	class := anOBClass
]

{ #category : #compiling }
OBCompilationBinder >> environment [

	^ lesson lessonEnvironment
]

{ #category : #compiling }
OBCompilationBinder >> instSize [

	^ class instSize
]

{ #category : #compiling }
OBCompilationBinder >> instVarNames [
	
	^ class instVarNames
]

{ #category : #accessing }
OBCompilationBinder >> lesson: aLesson [
	
	lesson := aLesson
]

{ #category : #compiling }
OBCompilationBinder >> literalScannedAs: anObject notifying: anEncoderForV3PlusClosures [ 
	
	^ class literalScannedAs: anObject notifying: anEncoderForV3PlusClosures
]

{ #category : #compiling }
OBCompilationBinder >> parserClass [

	^ self class parserClass.
]

{ #category : #compiling }
OBCompilationBinder >> variablesAndOffsetsDo: aBlockClosure [ 

	class variablesAndOffsetsDo: aBlockClosure
]
