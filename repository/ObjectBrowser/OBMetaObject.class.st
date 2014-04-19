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
	#superclass : #OBAbstractMetaObject,
	#instVars : [
		'attributes',
		'lesson'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBMetaObject class >> createNewObjectBrowserObjectClassIn: aLesson [
	^ aLesson
		createClass: (OBObject name, self takeSequencialNumber asString) asSymbol
		subclassOf: OBObject
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

{ #category : #attributes }
OBMetaObject >> addAttributeNamed: attributeName [

	OBPharoReflection uniqueInstance
		addInstanceVariable: attributeName
		toClassOfObject: self baseObject.

	self flushAttributesCache.
	self changed.
]

{ #category : #references }
OBMetaObject >> addInversePrototypeRelationship: references [

	references add: self baseObject.
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
		inObject: self baseObject
		setInstanceVariable: attributeName
		withValue: anObject baseObject.
]

{ #category : #attributes }
OBMetaObject >> attributeNames [

	^attributes ifNil: [ attributes := OBPharoReflection uniqueInstance instanceVariablesOfObject: self baseObject ].
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
		makeClass: (OBPharoReflection uniqueInstance classOf: clone baseObject) subclassOf: (OBPharoReflection uniqueInstance classOf: self baseObject).
]

{ #category : #cloning }
OBMetaObject >> clone [
	^ self class newFrom: self on: self lesson.

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
		inLesson: self lesson
		inClass: (OBPharoReflection uniqueInstance classOf: self baseObject)
		notifying: someone.
	selector ifNil: [ 
			obMethod:= OBNullMethod new.
			obMethod code: aMethodCode.
			^ obMethod.
		 ].
	
	obMethod := OBMethod new
		selector: selector;
		object: self;
		yourself.
	methods at: selector put: obMethod.
	self flushAttributesCache.
	self changed.
	^ obMethod
]

{ #category : #printing }
OBMetaObject >> displayString [

	^self baseObject displayString
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

	self baseObject inspect
]

{ #category : #accessing }
OBMetaObject >> lesson [

	^lesson
]

{ #category : #accessing }
OBMetaObject >> lesson: aLesson [

	lesson := aLesson
]

{ #category : #methods }
OBMetaObject >> methods [
	| allMethods dictionaryMethods |
	dictionaryMethods := Dictionary new.
	allMethods := prototype methods.
	allMethods do: [ :method | dictionaryMethods at: method selector put: method ].
	methods do: [ :method | dictionaryMethods at: method selector put: method ].
	^ dictionaryMethods values
]

{ #category : #printing }
OBMetaObject >> printOn: aStream [

	self baseObject printOn: aStream.
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

	anAttribute removeFrom: (OBPharoReflection uniqueInstance classOf: self baseObject).
	self flushAttributesCache.
	self changed.
]

{ #category : #'pharo-interaction' }
OBMetaObject >> removeClassFromSystem [

	OBPharoReflection uniqueInstance destroyClassOf: self baseObject
]

{ #category : #methods }
OBMetaObject >> removeMethod: aMethod [

	(self includesSelector: aMethod selector) ifFalse: [
		self error: 'El método #', aMethod selector ,' pertenece a un prototipo, no puede eliminarse de este objeto'.
	].

	OBPharoReflection uniqueInstance inClassOf: self baseObject removeMethodWithSelector: aMethod selector.
	methods removeKey: aMethod selector.
	self changed.
]

{ #category : #methods }
OBMetaObject >> understands: aSelector [

	^OBPharoReflection uniqueInstance doesObject: self baseObject undertandMessageSelector: aSelector
]
