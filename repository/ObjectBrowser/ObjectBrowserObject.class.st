Class {
	#name : #ObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'prototype',
		'methods',
		'lesson',
		'attributes'
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

{ #category : #'ui-actions' }
ObjectBrowserObject >> actionsForAttributeListWith: selectedAttribute [
	| actions |
	actions := OrderedCollection with: #('Crear nueva referencia' createAttribute).
	actions addAll: (selectedAttribute actionsForAttributeList).
	^actions asArray
]

{ #category : #'ui-actions' }
ObjectBrowserObject >> actionsForObjectBrowserReferencesList [
	^#(#('Clonar objeto referenciado' #cloneObject)).
]

{ #category : #attributes }
ObjectBrowserObject >> addAttributeNamed: attributeName [

	self realClass addInstVarNamed: attributeName.
	self flushAttributesCache.
	self changed.
]

{ #category : #references }
ObjectBrowserObject >> addInversePrototypeRelationship: references [

	references add: self realObject.
]

{ #category : #graph }
ObjectBrowserObject >> addPrototypeRelationshipTo: anObjectBrowserObject in: aGraph [
	self addToGraph: aGraph.
	aGraph addReferenceFrom: anObjectBrowserObject to: self named: 'prototype'.
]

{ #category : #graph }
ObjectBrowserObject >> addToGraph: aGraph [
	aGraph addObjectBrowserObject: self.
]

{ #category : #attributes }
ObjectBrowserObject >> allAttributeNames [

	^prototype allAttributeNames, self attributeNames.
]

{ #category : #printing }
ObjectBrowserObject >> asString [
	^self posibleName
]

{ #category : #attributes }
ObjectBrowserObject >> attributeNamed: varName [

	^self attributes detect: [:v | v name = varName ].
]

{ #category : #attributes }
ObjectBrowserObject >> attributeNamed: attributeNamed pointTo: anObject [

	self realObject instVarNamed: attributeNamed put: anObject realObject.
]

{ #category : #attributes }
ObjectBrowserObject >> attributeNames [

	^attributes ifNil: [ attributes := self realClass instVarNames ].
]

{ #category : #attributes }
ObjectBrowserObject >> attributes [

	^(self allAttributeNames collect: [ :var | OBAttribute newNamed: var owner: self ]) 
		asSortedCollection: [ :var1 :var2 | var1 name <= var2 name ]
]

{ #category : #cloning }
ObjectBrowserObject >> bePrototypeOf: clone [

	clone prototype: self.
	self realClass
		subclass: clone realClass name asSymbol
		instanceVariableNames: (clone realClass instVarNames inject: '' into:[:v :tot| tot,' ',v])
		classVariableNames: (clone realClass classVarNames inject: '' into:[:v :tot| tot,' ',v])
		poolDictionaries: clone realClass sharedPoolsString 
		category: clone realClass category.
]

{ #category : #cloning }
ObjectBrowserObject >> clone [

	^self class newFrom: self on: self lesson.
]

{ #category : #methods }
ObjectBrowserObject >> compileMethod: aMethod [
	self compileMethod: aMethod notifying: nil 
]

{ #category : #methods }
ObjectBrowserObject >> compileMethod: aMethod notifying: someone [
	| result obMethod |
	self suspendAllWhile: [
		result := self realClass compile: aMethod classified: #'object browser'  notifying: someone.
		result ifNil: [ ^self ].
		obMethod := OBMethod new 
			selector: result;
			object: self;
			yourself.
		methods at: result put: obMethod.
		self flushAttributesCache.
		self changed.
		^obMethod
	]
]

{ #category : #printing }
ObjectBrowserObject >> displayString [
	^self realObject displayString
]

{ #category : #exporting }
ObjectBrowserObject >> fileOut [

	| internalStream |
	internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: 'fileOut' isSt: true.
]

{ #category : #attributes }
ObjectBrowserObject >> flushAttributesCache [

	"We flush the cached attributed.
	We keep a cache because we are not the only ones that can add attributes into an object, which can happen also e.g., in method compilation."
	attributes := nil
]

{ #category : #references }
ObjectBrowserObject >> fullfillObjectBrowserObjectsCollection: aCollection [
|pointed|
	(aCollection includes: self) ifFalse: [
		aCollection add: self.
		self attributes do: [ :v | pointed := self objectPointedByVariableNamed: v name. (pointed notNil and: [
				pointed class isKindOf: ObjectBrowserObject]) ifTrue: [ pointed fullfillObjectBrowserObjectsCollection: aCollection ]].
		]
]

{ #category : #attributes }
ObjectBrowserObject >> hasAttributeNamed: anAttributeName [

	^self allAttributeNames includes: anAttributeName
]

{ #category : #methods }
ObjectBrowserObject >> hasMethod: aSelector [
	^self methods anySatisfy: [:m | m selector = aSelector ]
]

{ #category : #references }
ObjectBrowserObject >> hasReferencesTo: anOBObject [

	^self knownObjects includes: anOBObject realObject 
]

{ #category : #'initialize-release' }
ObjectBrowserObject >> initialize [
	super initialize.

	self realObject ifNotNil: [self realObject initialize].
	prototype ifNil: [ prototype := NullObjectBrowserObject new].
	attributes := Set new.
	methods := Dictionary new.
	^self
]

{ #category : #'pharo-interaction' }
ObjectBrowserObject >> inspect [
	self realObject inspect
]

{ #category : #methods }
ObjectBrowserObject >> isRedefined: aSelector [
	^self realClass allSubclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #references }
ObjectBrowserObject >> knownObjects [
	| refs |
	refs := self attributes asBag collect: [:v | self objectPointedByVariableNamed:  v name ].
	prototype addInversePrototypeRelationship: refs.
	^refs.
	

]

{ #category : #accessing }
ObjectBrowserObject >> lesson [

	^lesson
]

{ #category : #accessing }
ObjectBrowserObject >> lesson: aLesson [

	lesson := aLesson
]

{ #category : #'ui-actions' }
ObjectBrowserObject >> menu: aMenuMorph [
	aMenuMorph addLine.
	^aMenuMorph addList: (self actionsForObjectBrowserReferencesList).
]

{ #category : #methods }
ObjectBrowserObject >> methodOfSelector: aSelector [
	"Para testing"
	^self myClassMethods detect: [:m | m selector = aSelector ].
]

{ #category : #methods }
ObjectBrowserObject >> methods [
"	^self myClassMethods union: prototype methods"
	| allMethods dictionaryMethods |
	dictionaryMethods := Dictionary new.
	allMethods:= prototype methods .
	allMethods do: [:method | dictionaryMethods at: method selector put: method ].	
	self myClassMethods do: [:method | dictionaryMethods at: method selector put: method ].
	^ dictionaryMethods values asSortedCollection: [:obMethod1 :obMethod2 | obMethod1 selector < obMethod2 selector].
]

{ #category : #methods }
ObjectBrowserObject >> myClassHasMethod: aSelector [
	^methods includesKey: aSelector selector 
]

{ #category : #methods }
ObjectBrowserObject >> myClassMethodSelectors [
	^self realClass selectors asOrderedCollection
]

{ #category : #methods }
ObjectBrowserObject >> myClassMethods [
	^methods values
]

{ #category : #exporting }
ObjectBrowserObject >> myNewScriptOn: aLesson [

	^ObjectBrowserObject name , ' newOn: ', aLesson lessonIdentification
]

{ #category : #accessing }
ObjectBrowserObject >> object [

	self deprecated.
	^self
]

{ #category : #references }
ObjectBrowserObject >> objectPointedByVariableNamed: varName [
	^realObject instVarNamed: varName
]

{ #category : #accessing }
ObjectBrowserObject >> posibleName [

	^ (self realClass name, self realObject hash asString) asLowercase.
]

{ #category : #printing }
ObjectBrowserObject >> printOn: aStream [
	self realObject printOn: aStream.
]

{ #category : #cloning }
ObjectBrowserObject >> prototype [

	^prototype
]

{ #category : #cloning }
ObjectBrowserObject >> prototype: anObject [

	prototype := anObject
]

{ #category : #'pharo-interaction' }
ObjectBrowserObject >> realClass [
	"la clase de la que hay que mostrar metodos y variables"
	^self realObject class
]

{ #category : #references }
ObjectBrowserObject >> realClassForVariableNamed: aByteString [ 
	^ (self realObject instVarNamed: aByteString) class .
]

{ #category : #accessing }
ObjectBrowserObject >> realObject [

	^ realObject
]

{ #category : #accessing }
ObjectBrowserObject >> realObject: anObject [

	realObject := anObject
]

{ #category : #methods }
ObjectBrowserObject >> redefines: aSelector [
	^self realClass allSuperclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #references }
ObjectBrowserObject >> references [
	| refs |
	refs := self attributes collect: [:v | self objectPointedBy:  v name ].
	prototype addInversePrototypeRelationship: refs.
	^refs.
	

]

{ #category : #attributes }
ObjectBrowserObject >> removeAttribute: anAttribute [

	anAttribute removeFrom: self realClass.
	self flushAttributesCache.
	self changed.
]

{ #category : #'pharo-interaction' }
ObjectBrowserObject >> removeClassFromSystem [
	self realClass removeFromSystem
]

{ #category : #methods }
ObjectBrowserObject >> removeMethod: aMethod [
	(self myClassHasMethod: aMethod) ifFalse: [
		self error: 'El método #', aMethod selector ,' pertenece a un prototipo, no puede eliminarse'.
	].

	self suspendAllWhile: [
		self realClass removeSelector: aMethod selector.
		methods removeKey: aMethod selector.
		self changed.
	]
]

{ #category : #accessing }
ObjectBrowserObject >> size [

	^self realObject size
]

{ #category : #methods }
ObjectBrowserObject >> sourceCodeAt: aMethod [
	^ aMethod code.
]

{ #category : #'pharo-interaction' }
ObjectBrowserObject >> suspendAllWhile: aBlock [
	SystemAnnouncer uniqueInstance suspendAllWhile: aBlock
]

{ #category : #methods }
ObjectBrowserObject >> understands: aSelector [
	^self realObject respondsTo: aSelector
]

{ #category : #attributes }
ObjectBrowserObject >> variableNames [

	^self attributes collect: [:var | var name]
]

{ #category : #exporting }
ObjectBrowserObject >> writeAttributesOn: stream [

	self attributeNames asSet do:[ :v | 
		stream
			nextPutAll: self posibleName;
			space;
			nextPutAll: (self class>>#addAttributeNamed:) selector;
			space;
			nextPutAll: '''';
			nextPutAll: v asString;
			nextPutAll: '''.';
			cr.
		].
]

{ #category : #exporting }
ObjectBrowserObject >> writeCloneScriptOn: stream for: clone lesson: aLesson [

	stream nextPutAll: self posibleName , ' bePrototypeOf: ', clone posibleName, '.'. 
	stream cr.
]

{ #category : #exporting }
ObjectBrowserObject >> writeCreateObjectOn: stream lesson: aLesson [

	stream nextPutAll: self posibleName ,  ' := ', (self myNewScriptOn: aLesson) , '.' .
	stream cr.
]

{ #category : #exporting }
ObjectBrowserObject >> writeCreationScriptOver: stream [

	| objectVariable |
	objectVariable := self posibleName.
	
	stream nextPutAll: '| ', objectVariable , '|'.
	
	self writeObjectDescriptionScriptOn:  stream .

	stream nextPutAll: 'self addObject: ', objectVariable, '.'.
	stream cr.
]

{ #category : #exporting }
ObjectBrowserObject >> writeMethodsOn: stream [
	
	self myClassMethods do:[ :m |
		stream nextPutAll: self posibleName  , ' compileMethod: ''' , (m code copyReplaceAll: $' asString with: $' asString,$' asString ), '''.'.
		stream cr.
		].

]

{ #category : #exporting }
ObjectBrowserObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self prototype writeCloneScriptOn: stream for: self lesson: aLesson .
	self writeAttributesOn: stream .
	self writeMethodsOn: stream .
	

]

{ #category : #exporting }
ObjectBrowserObject >> writeStateScriptOn: stream lesson: aLesson [

	"saves the state, all the variables values and relationships"
	self attributes do:  [ :var | 
			stream nextPutAll: self posibleName , ' attributeNamed: ''',var name,''' pointTo: ', (lesson objectBrowserObjectForRealObject: (self objectPointedByVariableNamed: var name)) posibleName, '.'. 
			stream cr].
]
