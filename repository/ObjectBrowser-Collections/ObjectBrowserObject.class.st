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
		realObject: (klass new);
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
	actions := OrderedCollection with: #('crear nueva referencia'		createAttribute).
	actions addAll: (selectedAttribute actionsForAttributeList).
	^actions asArray
]

{ #category : #accessing }
ObjectBrowserObject >> actionsForObjectVariableList [
	^#(#('Clonar objeto referenciado' #cloneObject)).
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
	self realClass addInstVarNamed: variableName.
	self flushVariablesCache.
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
		instanceVariableNames: (clone realClass instVarNames inject: '' into:[:v :tot| tot,' ',v])
		classVariableNames: (clone realClass classVarNames inject: '' into:[:v :tot| tot,' ',v])
		poolDictionaries: clone realClass sharedPoolsString 
		category: clone realClass category.
]

{ #category : #printing }
ObjectBrowserObject >> clone [
	^self class newFrom: self on: self lesson.
]

{ #category : #accessing }
ObjectBrowserObject >> collectRealVariables [
	^self realClass instVarNames
]

{ #category : #printing }
ObjectBrowserObject >> compileMethod: aMethod [
	self compileMethod: aMethod notifying: nil 
]

{ #category : #printing }
ObjectBrowserObject >> compileMethod: aMethod notifying: someone [
	| result obMethod |
	SystemChangeNotifier uniqueInstance doSilently: [
		result := self realClass compile: aMethod classified: #'object browser'  notifying: someone.
		result ifNil: [ ^self ].
		obMethod := OBMethod new 
			selector: result;
			object: self;
			yourself.
		methods at: result put: obMethod.
		self flushVariablesCache.
		self changed.
		^obMethod
	]
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> displayString [
	^self realObject displayString
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> fileOut [

	| internalStream |
	internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: 'fileOut' isSt: true.
]

{ #category : #accessing }
ObjectBrowserObject >> flushVariablesCache [
	variables := nil
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
	^self realClass allSubclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
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
	aMenuMorph addLine.
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
	^ (self realClass name, self realObject hash asString) asLowercase.
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

{ #category : #associating }
ObjectBrowserObject >> realClassForVariableNamed: aByteString [ 
	^ (self realObject instVarNamed: aByteString) class .
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

{ #category : #accessing }
ObjectBrowserObject >> realObjectVariables [
	variables ifNil: [ variables := self collectRealVariables asSet  ].
	^ (variables union: prototype realObjectVariables).  
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> redefines: aSelector [
	^self realClass allSuperclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
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
	variables remove: anAttribute name.
	anAttribute removeFrom: self realClass.
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
	^(self realObjectVariables collect: [ :var | OBAttribute newNamed: var owner: self ]) 
		asSortedCollection: [ :var1 :var2 | var1 name <= var2 name ]
]

{ #category : #exportation }
ObjectBrowserObject >> writeCloneScriptOn: stream for: clone lesson: aLesson [
	stream nextPutAll: self posibleName , ' bePrototypeOf: ', clone posibleName, '.'. 
	stream cr.
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
	self collectRealVariables asSet do:[ :v | 
		stream nextPutAll: self posibleName , ' addVariable: ''', v, '''.'.
		stream cr.
		].
]
