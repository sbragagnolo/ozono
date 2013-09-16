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
OBCompilationBinder >> allInstVarNames [

	^ class allInstVarNames
]
