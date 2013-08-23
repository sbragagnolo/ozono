"
I am the meta-object that represents an (sub)instance of OBRealObject.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBNormalMetaObject,
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

{ #category : #'instance-creation' }
OBNormalMetaObject class >> createNewObjectBrowserObjectClassFrom: aClass in: aLesson [
	| objectBrowserClassNumber |
	objectBrowserClassNumber := NextObjectBrowserClassNumber.
	NextObjectBrowserClassNumber := NextObjectBrowserClassNumber + 1.
	^aLesson createClass: ('ObjectBrowserObject',  objectBrowserClassNumber printString) asSymbol subclassOf: aClass			
]

{ #category : #'instance-creation' }
OBNormalMetaObject class >> createNewObjectBrowserObjectClassIn: aLesson [
	^self createNewObjectBrowserObjectClassFrom: OBRealObject in: aLesson.
	
]

{ #category : #'class initialization' }
OBNormalMetaObject class >> initialize [
	NextObjectBrowserClassNumber := 1
]

{ #category : #'instance-creation' }
OBNormalMetaObject class >> newFrom: anObo on: aLesson [
	| klass |
	klass := self createNewObjectBrowserObjectClassFrom: anObo realClass in: aLesson.
	^super new
		realObject: klass new;
		prototype: anObo;
		lesson: aLesson;
		yourself.
]

{ #category : #'instance-creation' }
OBNormalMetaObject class >> newOn: aLesson [
	| klass |
	klass := self createNewObjectBrowserObjectClassIn: aLesson.
	^super new
		realObject: (klass new);
		lesson: aLesson;
		yourself.
]

{ #category : #'instance-creation' }
OBNormalMetaObject class >> newOn: aLesson withRealObject: realObject [
	^super new
		realObject: realObject;
		lesson: aLesson;
		yourself.
]

{ #category : #methods }
OBNormalMetaObject >> >> aSelector [

	^methods at: aSelector.
]

{ #category : #'ui-actions' }
OBNormalMetaObject >> actionsForAttributeListWith: selectedAttribute [

	| actions |
	actions := OrderedCollection with: #('Crear nueva referencia' createAttribute).
	actions addAll: (selectedAttribute actionsForAttributeList).
	^actions asArray
]

{ #category : #'ui-actions' }
OBNormalMetaObject >> actionsForObjectBrowserReferencesList [

	^#(#('Clonar objeto referenciado' #cloneObject)).
]

{ #category : #attributes }
OBNormalMetaObject >> addAttributeNamed: attributeName [

	self realClass addInstVarNamed: attributeName.
	self flushAttributesCache.
	self changed.
]

{ #category : #references }
OBNormalMetaObject >> addInversePrototypeRelationship: references [

	references add: self realObject.
]

{ #category : #graph }
OBNormalMetaObject >> addPrototypeRelationshipTo: anObjectBrowserObject in: aGraph [

	self addToGraph: aGraph.
	aGraph addReferenceFrom: anObjectBrowserObject to: self named: 'prototype'.
]

{ #category : #graph }
OBNormalMetaObject >> addToGraph: aGraph [

	aGraph addObjectBrowserObject: self.
]

{ #category : #attributes }
OBNormalMetaObject >> allAttributeNames [

	^prototype allAttributeNames, self attributeNames.
]

{ #category : #printing }
OBNormalMetaObject >> asString [

	^self posibleName
]

{ #category : #attributes }
OBNormalMetaObject >> attributeNamed: varName [

	^self attributes detect: [:v | v name = varName ].
]

{ #category : #attributes }
OBNormalMetaObject >> attributeNamed: attributeNamed pointTo: anObject [

	self realObject instVarNamed: attributeNamed put: anObject realObject.
]

{ #category : #attributes }
OBNormalMetaObject >> attributeNames [

	^attributes ifNil: [ attributes := self realClass instVarNames ].
]

{ #category : #attributes }
OBNormalMetaObject >> attributes [

	^(self allAttributeNames collect: [ :var | OBAttribute newNamed: var owner: self ]) 
		asSortedCollection: [ :var1 :var2 | var1 name <= var2 name ]
]

{ #category : #references }
OBNormalMetaObject >> basicObjectAtAttributeNamed: attributeName [

	^realObject instVarNamed: attributeName
]

{ #category : #cloning }
OBNormalMetaObject >> bePrototypeOf: clone [

	clone prototype: self.
	self realClass
		subclass: clone realClass name asSymbol
		instanceVariableNames: (clone realClass instVarNames inject: '' into:[:v :tot| tot,' ',v])
		classVariableNames: (clone realClass classVarNames inject: '' into:[:v :tot| tot,' ',v])
		poolDictionaries: clone realClass sharedPoolsString 
		category: clone realClass category.
]

{ #category : #cloning }
OBNormalMetaObject >> clone [

	^self class newFrom: self on: self lesson.
]

{ #category : #methods }
OBNormalMetaObject >> compileMethod: aMethod [

	self compileMethod: aMethod notifying: nil 
]

{ #category : #methods }
OBNormalMetaObject >> compileMethod: aMethod notifying: someone [

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
OBNormalMetaObject >> displayString [

	^self realObject displayString
]

{ #category : #exporting }
OBNormalMetaObject >> fileOut [

	| internalStream |
	internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: 'fileOut' isSt: true.
]

{ #category : #attributes }
OBNormalMetaObject >> flushAttributesCache [

	"We flush the cached attributed.
	We keep a cache because we are not the only ones that can add attributes into an object, which can happen also e.g., in method compilation."
	attributes := nil
]

{ #category : #attributes }
OBNormalMetaObject >> hasAttributeNamed: anAttributeName [

	^self allAttributeNames includes: anAttributeName
]

{ #category : #references }
OBNormalMetaObject >> hasReferencesTo: anOBObject [

	^self referencedObjects includes: anOBObject realObject
]

{ #category : #methods }
OBNormalMetaObject >> includesSelector: aSelector [

	^self methods includesKey: aSelector
]

{ #category : #'initialize-release' }
OBNormalMetaObject >> initialize [

	super initialize.
	self realObject ifNotNil: [self realObject initialize].
	prototype ifNil: [ prototype := NullObjectBrowserObject new].
	attributes := Set new.
	methods := Dictionary new.
	^self
]

{ #category : #'pharo-interaction' }
OBNormalMetaObject >> inspect [

	self realObject inspect
]

{ #category : #methods }
OBNormalMetaObject >> isRedefined: aSelector [

	^self realClass allSubclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #accessing }
OBNormalMetaObject >> lesson [

	^lesson
]

{ #category : #accessing }
OBNormalMetaObject >> lesson: aLesson [

	lesson := aLesson
]

{ #category : #'ui-actions' }
OBNormalMetaObject >> menu: aMenuMorph [

	aMenuMorph addLine.
	^aMenuMorph addList: (self actionsForObjectBrowserReferencesList).
]

{ #category : #methods }
OBNormalMetaObject >> methods [

	| allMethods dictionaryMethods |
	dictionaryMethods := Dictionary new.
	allMethods:= prototype methods .
	allMethods do: [:method | dictionaryMethods at: method selector put: method ].	
	methods do: [:method | dictionaryMethods at: method selector put: method ].
	^ dictionaryMethods values asSortedCollection: [:obMethod1 :obMethod2 | obMethod1 selector < obMethod2 selector].
]

{ #category : #exporting }
OBNormalMetaObject >> myNewScriptOn: aLesson [

	^self class name , ' newOn: ', aLesson lessonIdentification
]

{ #category : #accessing }
OBNormalMetaObject >> object [

	self deprecated.
	^self
]

{ #category : #accessing }
OBNormalMetaObject >> posibleName [

	^ (self realClass name, self realObject hash asString) asLowercase.
]

{ #category : #printing }
OBNormalMetaObject >> printOn: aStream [

	self realObject printOn: aStream.
]

{ #category : #cloning }
OBNormalMetaObject >> prototype [

	^prototype
]

{ #category : #cloning }
OBNormalMetaObject >> prototype: anObject [

	prototype := anObject
]

{ #category : #'pharo-interaction' }
OBNormalMetaObject >> realClass [

	^self realObject class
]

{ #category : #accessing }
OBNormalMetaObject >> realObject [

	^ realObject
]

{ #category : #accessing }
OBNormalMetaObject >> realObject: anObject [

	realObject := anObject
]

{ #category : #methods }
OBNormalMetaObject >> redefines: aSelector [

	^self realClass allSuperclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #references }
OBNormalMetaObject >> referencedObjects [

	| refs |
	refs := self attributes asBag collect: [:v | self basicObjectAtAttributeNamed:  v name ].
	prototype addInversePrototypeRelationship: refs.
	^refs.
	

]

{ #category : #attributes }
OBNormalMetaObject >> removeAttribute: anAttribute [

	anAttribute removeFrom: self realClass.
	self flushAttributesCache.
	self changed.
]

{ #category : #'pharo-interaction' }
OBNormalMetaObject >> removeClassFromSystem [

	self realClass removeFromSystem
]

{ #category : #methods }
OBNormalMetaObject >> removeMethod: aMethod [

	(self includesSelector: aMethod selector) ifFalse: [
		self error: 'El método #', aMethod selector ,' pertenece a un prototipo, no puede eliminarse de este objeto'.
	].

	self suspendAllWhile: [
		self realClass removeSelector: aMethod selector.
		methods removeKey: aMethod selector.
		self changed.
	]
]

{ #category : #accessing }
OBNormalMetaObject >> size [

	^self realObject size
]

{ #category : #methods }
OBNormalMetaObject >> sourceCodeAt: aMethod [

	^ aMethod code.
]

{ #category : #'pharo-interaction' }
OBNormalMetaObject >> suspendAllWhile: aBlock [

	SystemAnnouncer uniqueInstance suspendAllWhile: aBlock
]

{ #category : #methods }
OBNormalMetaObject >> understands: aSelector [

	^self realObject respondsTo: aSelector
]

{ #category : #attributes }
OBNormalMetaObject >> variableNames [

	^self attributes collect: [:var | var name]
]

{ #category : #exporting }
OBNormalMetaObject >> writeAttributesOn: stream [

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
OBNormalMetaObject >> writeCloneScriptOn: stream for: clone lesson: aLesson [

	stream nextPutAll: self posibleName , ' bePrototypeOf: ', clone posibleName, '.'. 
	stream cr.
]

{ #category : #exporting }
OBNormalMetaObject >> writeCreateObjectOn: stream lesson: aLesson [

	stream nextPutAll: self posibleName ,  ' := ', (self myNewScriptOn: aLesson) , '.' .
	stream cr.
]

{ #category : #exporting }
OBNormalMetaObject >> writeCreationScriptOver: stream [

	| objectVariable |
	objectVariable := self posibleName.
	
	stream nextPutAll: '| ', objectVariable , '|'.
	
	self writeObjectDescriptionScriptOn:  stream .

	stream nextPutAll: 'self addObject: ', objectVariable, '.'.
	stream cr.
]

{ #category : #exporting }
OBNormalMetaObject >> writeMethodsOn: stream [
	
	methods do:[ :m |
		stream nextPutAll: self posibleName  , ' compileMethod: ''' , (m code copyReplaceAll: $' asString with: $' asString,$' asString ), '''.'.
		stream cr.
		].

]

{ #category : #exporting }
OBNormalMetaObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self prototype writeCloneScriptOn: stream for: self lesson: aLesson .
	self writeAttributesOn: stream .
	self writeMethodsOn: stream .
	

]

{ #category : #exporting }
OBNormalMetaObject >> writeStateScriptOn: stream lesson: aLesson [

	"saves the state, all the variables values and relationships"
	self attributes do:  [ :var | 
			stream nextPutAll: self posibleName , ' attributeNamed: ''',var name,''' pointTo: ', (lesson objectBrowserObjectForRealObject: (self basicObjectAtAttributeNamed: var name)) posibleName, '.'. 
			stream cr].
]
