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
OBMetaObject class >> createNewObjectBrowserObjectClassIn: aLesson [
	^ aLesson
		createClass: (OBObject name, self takeSequencialNumber asString) asSymbol
		subclassOf: OBObject
]

{ #category : #'class initialization' }
OBMetaObject class >> initialize [
	NextObjectBrowserClassNumber := 1
]

{ #category : #'instance-creation' }
OBMetaObject class >> newFrom: anObo on: aLesson [
	
	| metaObject |
	metaObject := self newOn: aLesson.
	anObo bePrototypeOf: metaObject.
	^metaObject
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

{ #category : #'instance-creation' }
OBMetaObject class >> takeSequencialNumber [

	NextObjectBrowserClassNumber in: [ :next | 
		NextObjectBrowserClassNumber := next + 1.
		^next
	]
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

	OBPharoReflection uniqueInstance
		addInstanceVariable: attributeName
		toClassOfObject: self concreteObject.

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
OBMetaObject >> attributeNamed: attributeName pointTo: anObject [

	OBPharoReflection uniqueInstance
		inObject: self concreteObject
		setInstanceVariable: attributeName
		withValue: anObject concreteObject.
]

{ #category : #attributes }
OBMetaObject >> attributeNames [

	^attributes ifNil: [ attributes := OBPharoReflection uniqueInstance instanceVariablesOfObject: self concreteObject ].
]

{ #category : #attributes }
OBMetaObject >> attributes [

	^(self allAttributeNames collect: [ :var | OBDirectAttribute newNamed: var owner: self ]) 
		asSortedCollection: [ :var1 :var2 | var1 name <= var2 name ]
]

{ #category : #references }
OBMetaObject >> basicObjectAtAttributeNamed: attributeName [

	^OBPharoReflection uniqueInstance inObject: concreteObject getInstanceVariable: attributeName
]

{ #category : #cloning }
OBMetaObject >> bePrototypeOf: clone [

	clone prototype: self.
	OBPharoReflection uniqueInstance
		makeClass: (OBPharoReflection uniqueInstance classOf: clone concreteObject) subclassOf: (OBPharoReflection uniqueInstance classOf: self concreteObject).
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
OBMetaObject >> compileMethod: aMethodCode notifying: someone [

	| selector obMethod |
	selector := OBPharoReflection uniqueInstance
		compile: aMethodCode
		inClass: (OBPharoReflection uniqueInstance classOf: self concreteObject)
		notifying: someone.
	selector ifNil: [ ^ OBNullMethod new ].
	
	obMethod := OBMethod new
		selector: selector;
		object: self;
		yourself.
	methods at: selector put: obMethod.
	self flushAttributesCache.
	self changed.
	^ obMethod
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

{ #category : #methods }
OBMetaObject >> includesSelector: aSelector [

	^self methods anySatisfy: [ :m | m selector == aSelector ]
]

{ #category : #'initialize-release' }
OBMetaObject >> initialize [

	super initialize.
	prototype := OBNullObject new.
	attributes := Set new.
	methods := Dictionary new.
]

{ #category : #'pharo-interaction' }
OBMetaObject >> inspect [

	self concreteObject inspect
]

{ #category : #methods }
OBMetaObject >> isRedefined: aSelector [

	^OBPharoReflection uniqueInstance
		inSubclassesOfClass: (OBPharoReflection uniqueInstance classOf: self concreteObject)
		isRedefined: aSelector
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
	allMethods:= prototype methods.
	allMethods do: [:method | dictionaryMethods at: method selector put: method ].	
	methods do: [:method | dictionaryMethods at: method selector put: method ].
	^ dictionaryMethods values
]

{ #category : #accessing }
OBMetaObject >> posibleName [

	^ ((OBPharoReflection uniqueInstance classNameOfObject: self concreteObject), self concreteObject hash asString) asLowercase.
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

{ #category : #methods }
OBMetaObject >> redefines: aSelector [

	^OBPharoReflection uniqueInstance
		inClass: (OBPharoReflection uniqueInstance classOf: self concreteObject)
		isRedefined: aSelector
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

	anAttribute removeFrom: (OBPharoReflection uniqueInstance classOf: self concreteObject).
	self flushAttributesCache.
	self changed.
]

{ #category : #'pharo-interaction' }
OBMetaObject >> removeClassFromSystem [

	OBPharoReflection uniqueInstance destroyClassOf: self concreteObject
]

{ #category : #methods }
OBMetaObject >> removeMethod: aMethod [

	(self includesSelector: aMethod selector) ifFalse: [
		self error: 'El método #', aMethod selector ,' pertenece a un prototipo, no puede eliminarse de este objeto'.
	].

	OBPharoReflection uniqueInstance inClassOf: self concreteObject removeMethodWithSelector: aMethod selector.
	methods removeKey: aMethod selector.
	self changed.
]

{ #category : #accessing }
OBMetaObject >> size [

	^self concreteObject size
]

{ #category : #methods }
OBMetaObject >> understands: aSelector [

	^OBPharoReflection uniqueInstance doesObject: self concreteObject undertandMessageSelector: aSelector
]
