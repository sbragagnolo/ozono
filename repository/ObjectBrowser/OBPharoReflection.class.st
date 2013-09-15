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
OBPharoReflection >> compile: code inClass: aClass notifying: anObserver [

	OBPharoSystem uniqueInstance suspendSystemEventsWhile: [
		| methodNode methodAndNode |
		"Compile the method"
		methodNode  := aClass compilerClass new
				compile: code
				in: aClass
				classified: #'object browser'
				notifying: anObserver
				ifFail: [ nil ].
		
		"Put the sourcecode in the changes file"
		methodAndNode := CompiledMethodWithNode 
			generateMethodFromNode: methodNode trailer: aClass defaultMethodTrailer.
		methodAndNode method 
			putSource: code 
			fromParseNode: methodAndNode node 
			inFile: 2
			withPreamble: [:f | f cr; nextPut: $!; nextChunkPut: 'Behavior method'; cr].
		
		"Install the method in the class"
		aClass
			addSelector: methodAndNode selector
			withMethod: methodAndNode method 
			notifying: anObserver.
		^ methodAndNode method selector
	]
]

{ #category : #methods }
OBPharoReflection >> compile: code inLesson: aLesson inClass: aClass notifying: anObserver [

	OBPharoSystem uniqueInstance suspendSystemEventsWhile: [
		| methodNode methodAndNode |
		"Compile the method"
		methodNode  := aClass compilerClass new
				compile: code
				in: (OBCompilationBinder onLesson: aLesson forClass: aClass)
				classified: #'object browser'
				notifying: anObserver
				ifFail: [ self error ].
		
		"Put the sourcecode in the changes file"
		methodAndNode := CompiledMethodWithNode 
			generateMethodFromNode: methodNode trailer: aClass defaultMethodTrailer.
		methodAndNode method 
			putSource: code 
			fromParseNode: methodAndNode node 
			inFile: 2
			withPreamble: [:f | f cr; nextPut: $!; nextChunkPut: 'Behavior method'; cr].
		
		"Install the method in the class"
		aClass
			addSelector: methodAndNode selector
			withMethod: methodAndNode method 
			notifying: anObserver.
		^ methodAndNode method selector
	]
]

{ #category : #classes }
OBPharoReflection >> createClassNamed: aClassName subclassOf: aSuperclass inEnvironment: anEnvironment [

	OBPharoSystem uniqueInstance suspendSystemEventsWhile: [
		^ClassBuilder new
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
