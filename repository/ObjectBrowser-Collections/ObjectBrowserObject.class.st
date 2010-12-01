Class {
	#name : #ObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'prototype',
		'variables',
		'methods',
		'lesson'
	],
	#classVars : [
		'NextObjectBrowserClassNumber'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> createNewObjectBrowserObjectClassFrom: aClass in: aLesson [
	| objectBrowserClassNumber |
	objectBrowserClassNumber := NextObjectBrowserClassNumber.
	NextObjectBrowserClassNumber := NextObjectBrowserClassNumber + 1.
	^aLesson createClass: ('ObjectBrowserObject',  objectBrowserClassNumber printString) asSymbol subclassOf: aClass			
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> createNewObjectBrowserObjectClassIn: aLesson [
	^self createNewObjectBrowserObjectClassFrom: ObjectBrowserClass in: aLesson.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> initialize [
	NextObjectBrowserClassNumber := 1
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> newFrom: anObo on: aLesson [
	| klass |
	klass := self createNewObjectBrowserObjectClassFrom: anObo realClass in: aLesson.
	^super new
		realObject: klass new;
		prototype: anObo;
		lesson: aLesson;
		yourself.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> newOn: aLesson [
	| klass |
	klass := self createNewObjectBrowserObjectClassIn: aLesson.
	^super new
		realObject: klass new;
		lesson: aLesson;
		yourself.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> newOn: aLesson withRealObject: realObject [
	^super new
		realObject: realObject;
		lesson: aLesson;
		yourself.
]

{ #category : #accessing }
ObjectBrowserObject >> actionsForAttributeListWith: selectedAttribute [
	| actions |
	actions := OrderedCollection with: #('crear nueva variable'		createAttribute).
	actions addAll: (selectedAttribute actionsForAttributeList).
	^actions asArray
]

{ #category : #accessing }
ObjectBrowserObject >> actionsForObjectVariableList [
	^#(
		#('clonar' #cloneObject) 
		).
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> addInversePrototypeRelationship: references [

	references add: self realObject.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> addPrototypeRelationshipTo: anObjectBrowserObject in: aGraph [
	self addToGraph: aGraph.
	aGraph addReferenceFrom: anObjectBrowserObject to: self named: 'prototype'.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> addToGraph: aGraph [
	aGraph addObjectBrowserObject: self.
]

{ #category : #accessing }
ObjectBrowserObject >> addVariable: variableName [
	self realClass addInstVarName: variableName.
	variables add: (OBAttribute newNamed: variableName).
	self changed.
]

{ #category : #accessing }
ObjectBrowserObject >> asString [
	^self posibleName
]

{ #category : #accessing }
ObjectBrowserObject >> at: index [
	self deprecated: 'No hay mas diccionarios, no usar!'.
	^self realObject at: index .
]

{ #category : #accessing }
ObjectBrowserObject >> at: index put: obj [
	self deprecated: 'para mi esto no sirve.  Guille'.
	^self realObject at: index put: obj.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> bePrototypeOf: clone [
	clone prototype: self.
	self realClass
		subclass: clone realClass name asSymbol
		instanceVariableNames: clone realClass instVarNames 
		classVariableNames: clone realClass classVarNames  
		poolDictionaries: clone realClass poolDictionaryNames 
		category: clone realClass category.
]

{ #category : #printing }
ObjectBrowserObject >> clone [
	^self class newFrom: self on: self lesson.
]

{ #category : #printing }
ObjectBrowserObject >> compileMethod: aMethod [
	| result |
	result := self realClass compile: aMethod classified: #'object browser'  notifying: nil.
	methods at: result put: (OBMethod new 
		selector: result;
		object: self;
		yourself).
	self changed.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> displayString [
	^self realObject displayString
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> doesNotUnderstand: aMessage [ 
	self deprecated: 'para mi esto ya no sirve.  Guille'.
	(self realObject respondsTo: aMessage selector) not
		ifTrue: [self error: self printString , ' no entiende el mensaje ' , aMessage selector].
	^self realObject perform: aMessage selector withArguments: aMessage arguments
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> fileOut [

	| internalStream |
	internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: 'fileOut' isSt: true.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> fullfillObjectBrowserObjectsCollection: aCollection [
|pointed|
	(aCollection includes: self) ifFalse: [
		aCollection add: self.
		self variables do: [ :v | pointed := self objectPointedByVariableNamed: v name. (pointed notNil and: [
				pointed class isKindOf: ObjectBrowserObject]) ifTrue: [ pointed fullfillObjectBrowserObjectsCollection: aCollection ]].
		]
]

{ #category : #accessing }
ObjectBrowserObject >> hasClones [
	^self realClass subclasses notEmpty
]

{ #category : #accessing }
ObjectBrowserObject >> hasMethod: aSelector [
	^self methods anySatisfy: [:m | m selector = aSelector ]
]

{ #category : #accessing }
ObjectBrowserObject >> hasReferencesTo: anOBObject [

	^self knownObjects includes: anOBObject realObject 
]

{ #category : #accessing }
ObjectBrowserObject >> hasVariable: aVariableName [
	^self variables anySatisfy: [:v | v name = aVariableName ]
]

{ #category : #accessing }
ObjectBrowserObject >> initialize [
	super initialize.
	self realObject ifNotNil: [self realObject initialize].
	prototype ifNil: [ prototype := NullObjectBrowserObject new].
	variables := Set new.
	methods := Dictionary new.
	^self
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> inspect [
	ToolSet inspect: self realObject 
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> isClone [
	^prototype notNil
]

{ #category : #accessing }
ObjectBrowserObject >> isNull [
	self deprecated: 'para mi esto ya no sirve.  Guille'.
	^false
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> isRedefined: aSelector [
	^self realClass isOverridden: aSelector.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> knownObjects [
	| refs |
	refs := self variables asBag collect: [:v | self objectPointedByVariableNamed:  v name ].
	prototype addInversePrototypeRelationship: refs.
	^refs.
	

]

{ #category : #printing }
ObjectBrowserObject >> lesson [
	^lesson
]

{ #category : #printing }
ObjectBrowserObject >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #accessing }
ObjectBrowserObject >> menu: aMenuMorph [
	^aMenuMorph addList: (self actionsForObjectVariableList).
]

{ #category : #accessing }
ObjectBrowserObject >> methodCategory: aSelector [
	self deprecated: 'para mi esto ya no sirve.  Guille'.
	^ self realClass organization categoryOfElement: aSelector.
]

{ #category : #accessing }
ObjectBrowserObject >> methodOfSelector: aSelector [
	"Para testing"
	^self myClassMethods detect: [:m | m selector = aSelector ].
]

{ #category : #accessing }
ObjectBrowserObject >> methods [
"	^self myClassMethods union: prototype methods"
	| allMethods dictionaryMethods |
	dictionaryMethods := Dictionary new.
	allMethods:= prototype methods .
	allMethods do: [:method | dictionaryMethods at: method selector put: method ].	
	self myClassMethods do: [:method | dictionaryMethods at: method selector put: method ].
	^ dictionaryMethods values asSortedCollection: [:obMethod1 :obMethod2 | obMethod1 selector < obMethod2 selector].
]

{ #category : #accessing }
ObjectBrowserObject >> myClassHasMethod: aSelector [
	^methods includesKey: aSelector selector 
]

{ #category : #accessing }
ObjectBrowserObject >> myClassMethodSelectors [
	^self realClass selectors asOrderedCollection
]

{ #category : #accessing }
ObjectBrowserObject >> myClassMethods [
	^methods values
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> myClassVariables [
	^variables
]

{ #category : #exportation }
ObjectBrowserObject >> myNewScriptOn: aLesson [
	^ObjectBrowserObject name , ' newOn: ', aLesson lessonIdentification
]

{ #category : #printing }
ObjectBrowserObject >> object [
	^self
]

{ #category : #accessing }
ObjectBrowserObject >> objectPointedByVariableNamed: varName [
	^realObject instVarNamed: varName
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> posibleName [
	^ self realClass name asLowercase.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> printOn: aStream [
	self realObject printOn: aStream.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> prototype [
	^prototype
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> prototype: anObject [
	prototype := anObject
]

{ #category : #accessing }
ObjectBrowserObject >> realClass [
	"la clase de la que hay que mostrar metodos y variables"
	^self realObject class
]

{ #category : #accessing }
ObjectBrowserObject >> realObject [
	"el objeto al que le digo cosas desde el workspace"
	^ realObject
]

{ #category : #accessing }
ObjectBrowserObject >> realObject: anObject [
	realObject := anObject
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> redefines: aSelector [
	^self realClass isOverride: aSelector.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> references [
	| refs |
	refs := self variables collect: [:v | self objectPointedBy:  v name ].
	prototype addInversePrototypeRelationship: refs.
	^refs.
	

]

{ #category : #accessing }
ObjectBrowserObject >> removeClassFromSystem [
	self realClass removeFromSystem
]

{ #category : #accessing }
ObjectBrowserObject >> removeMethod: aMethod [
	(self myClassHasMethod: aMethod) 
	ifTrue: [
		self realClass removeSelector: aMethod selector.
		methods removeKey: aMethod selector.
		self changed.
	]
	ifFalse: [
		self error: 'El método #', aMethod selector ,' pertenece a un prototipo, no puede eliminarse'.
	]
]

{ #category : #accessing }
ObjectBrowserObject >> removeVariable: anAttribute [
	anAttribute removeFrom: self realClass.
	variables remove: anAttribute.
	self changed.
]

{ #category : #accessing }
ObjectBrowserObject >> size [
	^self realObject size
]

{ #category : #accessing }
ObjectBrowserObject >> sourceCodeAt: aMethod [
	^ aMethod code.
]

{ #category : #printing }
ObjectBrowserObject >> understands: aSelector [
	^self realObject respondsTo: aSelector
]

{ #category : #accessing }
ObjectBrowserObject >> variable: varName pointTo: anObject [
	self realObject instVarNamed: varName put: anObject realObject.
]

{ #category : #accessing }
ObjectBrowserObject >> variableNamed: varName [
	^self variables detect: [:v | v name = varName ].
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> variableNames [
	^self variables collect:[:var | var name]
]

{ #category : #accessing }
ObjectBrowserObject >> variables [
	^ (variables union: prototype variables)
]

{ #category : #exportation }
ObjectBrowserObject >> writeCloneScriptOn: stream for: clone lesson: aLesson [
	stream nextPutAll: self posibleName , ' bePrototypeOf: ', clone posibleName, '.'. 
]

{ #category : #exportation }
ObjectBrowserObject >> writeCreateObjectOn: stream lesson: aLesson [
	stream nextPutAll: self posibleName ,  ' := ', (self myNewScriptOn: aLesson) , '.' .
	stream cr.
]

{ #category : #exportation }
ObjectBrowserObject >> writeCreationScriptOver: stream [
	| objectVariable |
	objectVariable := self posibleName.
	
	stream nextPutAll: '| ', objectVariable , '|'.
	
	self writeObjectDescriptionScriptOn:  stream .

	stream nextPutAll: 'self addObject: ', objectVariable, '.'.
	stream cr.
]

{ #category : #exportation }
ObjectBrowserObject >> writeMethodsOn: stream [ .
	
	self myClassMethods do:[ :m |
		stream nextPutAll: self posibleName  , ' compileMethod: ''' , (m code copyReplaceAll: $' asString with: $' asString,$' asString ), '''.'.
		stream cr.
		].

]

{ #category : #exportation }
ObjectBrowserObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self writeCreateObjectOn: stream lesson: aLesson.
	self prototype writeCloneScriptOn: stream for: self lesson: aLesson .
	self writeVarianblesOn: stream .
	self writeMethodsOn: stream .
	

]

{ #category : #exportation }
ObjectBrowserObject >> writeStateScriptOn: stream lesson: aLesson [
	"saves the state, all the variables values and relationships"
	self variables do:  [ :var | 
			stream nextPutAll: self posibleName , ' variable: ''',var name,''' pointTo: ', (lesson objectBrowserObjectForRealObject: (self objectPointedByVariableNamed: var name)) posibleName, '.'. 
			stream cr].
]

{ #category : #exportation }
ObjectBrowserObject >> writeVarianblesOn: stream [ .

	self myClassVariables do:[ :v | 
		stream nextPutAll: self posibleName , ' addVariable: ''', v name, '''.'.
		stream cr.
		].
]
