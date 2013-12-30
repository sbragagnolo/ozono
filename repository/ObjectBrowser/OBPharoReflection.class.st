"
Reflection utilities from Pharo
"
Class {
	#name : #OBPharoReflection,
	#superclass : #Object,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ObjectBrowser-PharoLayer'
}

{ #category : #'instance creation' }
OBPharoReflection class >> uniqueInstance [

	^UniqueInstance ifNil: [ UniqueInstance := OBPharoReflection new ]
]

{ #category : #'instance variables' }
OBPharoReflection >> addInstanceVariable: aVariableName toClassOfObject: anObject [

	^ anObject class addInstVarNamed: aVariableName
]

{ #category : #classes }
OBPharoReflection >> classNameOfObject: anObject [

	^anObject class name
]

{ #category : #classes }
OBPharoReflection >> classOf: anObject [

	 ^ anObject class
]

{ #category : #methods }
OBPharoReflection >> compile: code inLesson: aLesson inClass: aClass notifying: anObserver [

	"We use the direct compiler API because we want to change the class by a compilation binder object. That way we can control easily how names are binded in Ozono"
	OBPharoSystem uniqueInstance suspendSystemEventsWhile: [
		| method |

		"Compile the method"
		method  := OpalCompiler new
			environment: aClass environment;
			class: (OBCompilationBinder onLesson: aLesson forClass: aClass);
			category: #'object browser';
			source: code;
			requestor: anObserver;
			failBlock: [ ^nil ];
			compile.

		"Put the sourcecode in the changes file"	
		method putSource: code inFile: 2
				withPreamble: [:f | f cr; nextPut: $!; nextChunkPut: 'Behavior method'; cr].
				
		"Install the method in the class"
		aClass addSelector: method selector withMethod: method notifying: anObserver.
		
		^ method selector
	]
]

{ #category : #classes }
OBPharoReflection >> createClassNamed: aClassName subclassOf: aSuperclass inEnvironment: anEnvironment [

	OBPharoSystem uniqueInstance suspendSystemEventsWhile: [
		^OldClassBuilderAdapter new
			name: aClassName
			inEnvironment: anEnvironment
			subclassOf: aSuperclass
			type: aSuperclass typeOfClass
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: 'Useless'.
	]
]

{ #category : #classes }
OBPharoReflection >> destroyClassOf: anObject [

	anObject class removeFromSystem
]

{ #category : #queries }
OBPharoReflection >> doesObject: anObject undertandMessageSelector: aSelector [

	^anObject respondsTo: aSelector
]

{ #category : #queries }
OBPharoReflection >> inClass: aClass isRedefined: aSelector [

	^aClass
		allSuperclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #methods }
OBPharoReflection >> inClassOf: anObject removeMethodWithSelector: aSelector [

	OBPharoSystem uniqueInstance suspendSystemEventsWhile: [
		^ anObject class removeSelector: aSelector.
	]
]

{ #category : #methods }
OBPharoReflection >> inClassOfObject: anObject sourceCodeOfMethodWithSelector: aSelector [

	^ anObject class sourceCodeAt: aSelector
]

{ #category : #'instance variables' }
OBPharoReflection >> inObject: anObject getInstanceVariable: aVariable [ 

	^ anObject instVarNamed: aVariable
]

{ #category : #'instance variables' }
OBPharoReflection >> inObject: anObject setInstanceVariable: aVariable withValue: aValue [

	^ anObject instVarNamed: aVariable put: aValue.
]

{ #category : #queries }
OBPharoReflection >> inSubclassesOfClass: aClass isRedefined: aSelector [

	^aClass allSubclasses
		anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #'instance variables' }
OBPharoReflection >> instanceVariablesOfObject: anObject [

	^ anObject class instVarNames 
]

{ #category : #classes }
OBPharoReflection >> makeClass: aSuperclass subclassOf: aSubclass [

	OBPharoSystem uniqueInstance suspendSystemEventsWhile: [
		aSuperclass subclass: aSubclass name asSymbol
			instanceVariableNames: aSubclass instanceVariablesString
			classVariableNames: aSubclass classVariablesString
			poolDictionaries: aSubclass sharedPoolsString 
			category: aSubclass category.
	]
]
