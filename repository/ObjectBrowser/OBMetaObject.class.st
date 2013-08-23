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
OBMetaObject class >> createNewObjectBrowserObjectClassFrom: aClass in: aLesson [
	| objectBrowserClassNumber |
	objectBrowserClassNumber := NextObjectBrowserClassNumber.
	NextObjectBrowserClassNumber := NextObjectBrowserClassNumber + 1.
	^aLesson createClass: ('ObjectBrowserObject',  objectBrowserClassNumber printString) asSymbol subclassOf: aClass			
]

{ #category : #'instance-creation' }
OBMetaObject class >> createNewObjectBrowserObjectClassIn: aLesson [
	^self createNewObjectBrowserObjectClassFrom: OBRealObject in: aLesson.
	
]

{ #category : #'class initialization' }
OBMetaObject class >> initialize [
	NextObjectBrowserClassNumber := 1
]

{ #category : #'instance-creation' }
OBMetaObject class >> newFrom: anObo on: aLesson [
	| klass |
	klass := self createNewObjectBrowserObjectClassFrom: anObo realClass in: aLesson.
	^super new
		realObject: klass new;
		prototype: anObo;
		lesson: aLesson;
		yourself.
]

{ #category : #'instance-creation' }
OBMetaObject class >> newOn: aLesson [
	| klass |
	klass := self createNewObjectBrowserObjectClassIn: aLesson.
	^super new
		realObject: (klass new);
		lesson: aLesson;
		yourself.
]

{ #category : #'instance-creation' }
OBMetaObject class >> newOn: aLesson withRealObject: realObject [
	^super new
		realObject: realObject;
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

	references add: self realObject.
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

	self realObject instVarNamed: attributeNamed put: anObject realObject.
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

	^realObject instVarNamed: attributeName
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

	^self class newFrom: self on: self lesson.
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
OBMetaObject >> displayString [

	^self realObject displayString
]

{ #category : #exporting }
OBMetaObject >> fileOut [

	| internalStream |
	internalStream := (String new: 100) writeStream.

	self writeCreationScriptOver: internalStream.

	internalStream trailer.
	FileStream writeSourceCodeFrom: internalStream baseName: 'fileOut' isSt: true.
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

	^self referencedObjects includes: anOBObject realObject
]

{ #category : #methods }
OBMetaObject >> includesSelector: aSelector [

	^self methods anySatisfy: [ :m | m selector == aSelector ]
]

{ #category : #'initialize-release' }
OBMetaObject >> initialize [

	super initialize.
	self realObject ifNotNil: [self realObject initialize].
	prototype ifNil: [ prototype := OBNullObject new].
	attributes := Set new.
	methods := Dictionary new.
	^self
]

{ #category : #'pharo-interaction' }
OBMetaObject >> inspect [

	self realObject inspect
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

{ #category : #exporting }
OBMetaObject >> myNewScriptOn: aLesson [

	^self class name , ' newOn: ', aLesson lessonIdentification
]

{ #category : #accessing }
OBMetaObject >> object [

	self deprecated.
	^self
]

{ #category : #accessing }
OBMetaObject >> posibleName [

	^ (self realClass name, self realObject hash asString) asLowercase.
]

{ #category : #printing }
OBMetaObject >> printOn: aStream [

	self realObject printOn: aStream.
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

	^self realObject class
]

{ #category : #accessing }
OBMetaObject >> realObject [

	^ realObject
]

{ #category : #accessing }
OBMetaObject >> realObject: anObject [

	realObject := anObject
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

	^self realObject size
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

	^self realObject respondsTo: aSelector
]

{ #category : #exporting }
OBMetaObject >> writeAttributesOn: stream [

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
OBMetaObject >> writeCloneScriptOn: stream for: clone lesson: aLesson [

	stream nextPutAll: self posibleName , ' bePrototypeOf: ', clone posibleName, '.'. 
	stream cr.
]

{ #category : #exporting }
OBMetaObject >> writeCreateObjectOn: stream lesson: aLesson [

	stream nextPutAll: self posibleName ,  ' := ', (self myNewScriptOn: aLesson) , '.' .
	stream cr.
]

{ #category : #exporting }
OBMetaObject >> writeCreationScriptOver: stream [

	| objectVariable |
	objectVariable := self posibleName.
	
	stream nextPutAll: '| ', objectVariable , '|'.
	
	self writeObjectDescriptionScriptOn:  stream .

	stream nextPutAll: 'self addObject: ', objectVariable, '.'.
	stream cr.
]

{ #category : #exporting }
OBMetaObject >> writeMethodsOn: stream [
	
	methods do:[ :m |
		stream nextPutAll: self posibleName  , ' compileMethod: ''' , (m code copyReplaceAll: $' asString with: $' asString,$' asString ), '''.'.
		stream cr.
		].

]

{ #category : #exporting }
OBMetaObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [

	self prototype writeCloneScriptOn: stream for: self lesson: aLesson .
	self writeAttributesOn: stream .
	self writeMethodsOn: stream .
	

]

{ #category : #exporting }
OBMetaObject >> writeStateScriptOn: stream lesson: aLesson [

	"saves the state, all the variables values and relationships"
	self attributes do:  [ :var | 
			stream nextPutAll: self posibleName , ' attributeNamed: ''',var name,''' pointTo: ', (lesson objectBrowserObjectForRealObject: (self basicObjectAtAttributeNamed: var name)) posibleName, '.'. 
			stream cr].
]
