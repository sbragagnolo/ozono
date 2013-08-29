"
I am the meta-object that represents an (sub)instance of OBRealObject.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBMetaObject,
	#superclass : #Object,
	#instVars : [
		'prototype',
		'methods',
		'lesson',
		'attributes',
		'concreteObject'
	],
	#classVars : [
		'NextObjectBrowserClassNumber'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBMetaObject class >> createNewObjectBrowserObjectClassFrom: aClass in: aLesson [
	| objectBrowserClassNumber |
	objectBrowserClassNumber := NextObjectBrowserClassNumber.
	NextObjectBrowserClassNumber := NextObjectBrowserClassNumber + 1.
	^aLesson createClass: ('ObjectBrowserObject',  objectBrowserClassNumber printString) asSymbol subclassOf: aClass			
]

{ #category : #'instance-creation' }
OBMetaObject class >> createNewObjectBrowserObjectClassIn: aLesson [
	^self createNewObjectBrowserObjectClassFrom: OBObject in: aLesson.
	
]

{ #category : #'class initialization' }
OBMetaObject class >> initialize [
	NextObjectBrowserClassNumber := 1
]

{ #category : #'instance-creation' }
OBMetaObject class >> newFrom: anObo on: aLesson [
	
	| concreteClass concreteObject metaObject |
	metaObject := self new.
	
	concreteClass := self createNewObjectBrowserObjectClassFrom: anObo realClass in: aLesson.
	concreteObject := concreteClass new.
	concreteObject metaObject: metaObject.

	^metaObject
		concreteObject: concreteObject;
		prototype: anObo;
		lesson: aLesson;
		yourself.
]

{ #category : #'instance-creation' }
OBMetaObject class >> newOn: aLesson [
	| concreteClass concreteObject metaObject |
	metaObject := self new.
	
	concreteClass := self createNewObjectBrowserObjectClassIn: aLesson.
	concreteObject := concreteClass new.
	concreteObject metaObject: metaObject.
	
	^ metaObject
		concreteObject: concreteObject;
		lesson: aLesson;
		yourself.
]

{ #category : #methods }
OBMetaObject >> >> aSelector [

	^methods at: aSelector.
]

{ #category : #visiting }
OBMetaObject >> accept: aVisitor [

	aVisitor visitObject: self.
]

{ #category : #'ui-actions' }
OBMetaObject >> actionsForAttributeListWith: selectedAttribute [

	| actions |
	actions := OrderedCollection with: #('Crear nueva referencia' createAttribute).
	actions addAll: (selectedAttribute actionsForAttributeList).
	^actions asArray
]

{ #category : #'ui-actions' }
OBMetaObject >> actionsForObjectBrowserReferencesList [

	^#(#('Clonar objeto referenciado' #cloneObject)).
]

{ #category : #attributes }
OBMetaObject >> addAttributeNamed: attributeName [

	self realClass addInstVarNamed: attributeName.
	self flushAttributesCache.
	self changed.
]

{ #category : #references }
OBMetaObject >> addInversePrototypeRelationship: references [

	references add: self concreteObject.
]

{ #category : #graph }
OBMetaObject >> addPrototypeRelationshipTo: anObjectBrowserObject in: aGraph [

	self accept: aGraph.
	aGraph addReferenceFrom: anObjectBrowserObject to: self named: 'prototype'.
]

{ #category : #attributes }
OBMetaObject >> allAttributeNames [

	^prototype allAttributeNames, self attributeNames.
]

{ #category : #attributes }
OBMetaObject >> allRelationships [
	
	"Returns all normal attributes plus special ones such as the prototype if available"
	| prototypeRelationship |
	prototypeRelationship := self prototype relationWith: self.
	^prototypeRelationship withRelationships: self attributes
]

{ #category : #printing }
OBMetaObject >> asString [

	^self posibleName
]

{ #category : #attributes }
OBMetaObject >> attributeNamed: varName [

	^self attributes detect: [:v | v name = varName ].
]

{ #category : #attributes }
OBMetaObject >> attributeNamed: attributeNamed pointTo: anObject [

	self concreteObject instVarNamed: attributeNamed put: anObject concreteObject.
]

{ #category : #attributes }
OBMetaObject >> attributeNames [

	^attributes ifNil: [ attributes := self realClass instVarNames ].
]

{ #category : #attributes }
OBMetaObject >> attributes [

	^(self allAttributeNames collect: [ :var | OBDirectAttribute newNamed: var owner: self ]) 
		asSortedCollection: [ :var1 :var2 | var1 name <= var2 name ]
]

{ #category : #references }
OBMetaObject >> basicObjectAtAttributeNamed: attributeName [

	^concreteObject instVarNamed: attributeName
]

{ #category : #cloning }
OBMetaObject >> bePrototypeOf: clone [

	clone prototype: self.
	self realClass
		subclass: clone realClass name asSymbol
		instanceVariableNames: (clone realClass instVarNames inject: '' into:[:v :tot| tot,' ',v])
		classVariableNames: (clone realClass classVarNames inject: '' into:[:v :tot| tot,' ',v])
		poolDictionaries: clone realClass sharedPoolsString 
		category: clone realClass category.
]

{ #category : #cloning }
OBMetaObject >> clone [

	| clone |
	clone := self class newFrom: self on: self lesson.
	self lesson addObject: clone.
	^ clone
]

{ #category : #methods }
OBMetaObject >> compileMethod: aMethod [

	self compileMethod: aMethod notifying: nil 
]

{ #category : #methods }
OBMetaObject >> compileMethod: aMethod notifying: someone [

	| result obMethod |
	self suspendAllWhile: [
		result := self realClass compile: aMethod classified: #'object browser'  notifying: someone.
		result ifNil: [ ^OBNullMethod new ].
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

{ #category : #accessing }
OBMetaObject >> concreteObject [

	^ concreteObject
]

{ #category : #accessing }
OBMetaObject >> concreteObject: anObject [

	concreteObject := anObject
]

{ #category : #printing }
OBMetaObject >> displayString [

	^self concreteObject displayString
]

{ #category : #attributes }
OBMetaObject >> flushAttributesCache [

	"We flush the cached attributed.
	We keep a cache because we are not the only ones that can add attributes into an object, which can happen also e.g., in method compilation."
	attributes := nil
]

{ #category : #attributes }
OBMetaObject >> hasAttributeNamed: anAttributeName [

	^self allAttributeNames includes: anAttributeName
]

{ #category : #references }
OBMetaObject >> hasReferencesTo: anOBObject [

	^self referencedObjects includes: anOBObject concreteObject
]

{ #category : #methods }
OBMetaObject >> includesSelector: aSelector [

	^self methods anySatisfy: [ :m | m selector == aSelector ]
]

{ #category : #'initialize-release' }
OBMetaObject >> initialize [

	super initialize.
	self concreteObject ifNotNil: [self concreteObject initialize].
	prototype ifNil: [ prototype := OBNullObject new].
	attributes := Set new.
	methods := Dictionary new.
	^self
]

{ #category : #'pharo-interaction' }
OBMetaObject >> inspect [

	self concreteObject inspect
]

{ #category : #methods }
OBMetaObject >> isRedefined: aSelector [

	^self realClass allSubclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #accessing }
OBMetaObject >> lesson [

	^lesson
]

{ #category : #accessing }
OBMetaObject >> lesson: aLesson [

	lesson := aLesson
]

{ #category : #'ui-actions' }
OBMetaObject >> menu: aMenuMorph [

	aMenuMorph addLine.
	^aMenuMorph addList: (self actionsForObjectBrowserReferencesList).
]

{ #category : #methods }
OBMetaObject >> methods [

	| allMethods dictionaryMethods |
	dictionaryMethods := Dictionary new.
	allMethods:= prototype methods .
	allMethods do: [:method | dictionaryMethods at: method selector put: method ].	
	methods do: [:method | dictionaryMethods at: method selector put: method ].
	^ dictionaryMethods values
]

{ #category : #accessing }
OBMetaObject >> object [

	self deprecated.
	^self
]

{ #category : #accessing }
OBMetaObject >> posibleName [

	^ (self realClass name, self concreteObject hash asString) asLowercase.
]

{ #category : #printing }
OBMetaObject >> printOn: aStream [

	self concreteObject printOn: aStream.
]

{ #category : #cloning }
OBMetaObject >> prototype [

	^prototype
]

{ #category : #cloning }
OBMetaObject >> prototype: anObject [

	prototype := anObject
]

{ #category : #'pharo-interaction' }
OBMetaObject >> realClass [

	^self concreteObject class
]

{ #category : #methods }
OBMetaObject >> redefines: aSelector [

	^self realClass allSuperclasses anySatisfy: [ :sc | sc includesSelector: aSelector ]
]

{ #category : #references }
OBMetaObject >> referencedObjects [

	| refs |
	refs := self attributes asBag collect: [:v | self basicObjectAtAttributeNamed:  v name ].
	prototype addInversePrototypeRelationship: refs.
	^refs.
	

]

{ #category : #cloning }
OBMetaObject >> relationWith: aClone [
	
	^OBSpecialAttribute 
		newNamed: 'prototype'
		owner: aClone
		pointingTo: self
]

{ #category : #attributes }
OBMetaObject >> removeAttribute: anAttribute [

	anAttribute removeFrom: self realClass.
	self flushAttributesCache.
	self changed.
]

{ #category : #'pharo-interaction' }
OBMetaObject >> removeClassFromSystem [

	self realClass removeFromSystem
]

{ #category : #methods }
OBMetaObject >> removeMethod: aMethod [

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
OBMetaObject >> size [

	^self concreteObject size
]

{ #category : #methods }
OBMetaObject >> sourceCodeAt: aMethod [

	^ aMethod code.
]

{ #category : #'pharo-interaction' }
OBMetaObject >> suspendAllWhile: aBlock [

	SystemAnnouncer uniqueInstance suspendAllWhile: aBlock
]

{ #category : #methods }
OBMetaObject >> understands: aSelector [

	^self concreteObject respondsTo: aSelector
]
