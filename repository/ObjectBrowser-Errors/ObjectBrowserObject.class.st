Class {
	#name : #ObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'objectName',
		'objectBrowser',
		'prototype',
		'variables',
		'methods'
	],
	#classVars : [
		'NextObjectBrowserClassNumber'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> createNewObjectBrowserObjectClass [
	^self createNewObjectBrowserObjectClassFrom: ObjectBrowserClass.
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> createNewObjectBrowserObjectClassFrom: aClass [
	| objectBrowserClassNumber |
	objectBrowserClassNumber := NextObjectBrowserClassNumber.
	NextObjectBrowserClassNumber := NextObjectBrowserClassNumber + 1.
	
	^aClass subclass: ('ObjectBrowserObject',  objectBrowserClassNumber printString) asSymbol 
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'ObjectBrowser-Objects'.
			
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> initialize [
	NextObjectBrowserClassNumber := 1
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> new [
	| klass |
	klass := self createNewObjectBrowserObjectClass.
	^super new
		realObject: klass new;
		yourself.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> newFrom: anObo [
	| klass |
	klass := self createNewObjectBrowserObjectClassFrom: anObo class.
	^super new
		realObject: klass new;
		prototype: anObo;
		yourself.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> addInversePrototypeRelationship: references [

	references add: self.
]

{ #category : #accessing }
ObjectBrowserObject >> addVariable: variableName [
	self realClass addInstVarName: variableName.
	variables add: (OBVariable new name: variableName ; yourself ).
	self changed.
]

{ #category : #printing }
ObjectBrowserObject >> clone [
	^self class newFrom: self.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> cloneWithName: aName [ 
	| obo |
	obo := ObjectBrowserObject
				createObjectBrowserObjectWithName: aName
				andSuperclass: self realClass
				inObjectBrowser: self objectBrowser.
	obo prototype: self.
	self changed.
	^ obo
]

{ #category : #printing }
ObjectBrowserObject >> compileMethod: aMethod [
	| result |
	result := self realClass compile: aMethod classified: #'object browser'  notifying: nil.
	methods add: (OBMethod new 
		selector: result;
		yourself).
	result ifNotNil: [self changed].
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> doesNotUnderstand: aMessage [ 
	(self realObject respondsTo: aMessage selector) not
		ifTrue: [self error: self printString , ' no entiende el mensaje ' , aMessage selector].
	^self realObject perform: aMessage selector withArguments: aMessage arguments
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

	^self references anySatisfy: [ :aVariable | aVariable = anOBObject realObject]
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
	methods := Set new.
	^self
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> inspect [
	ToolSet inspect: self realObject 
]

{ #category : #accessing }
ObjectBrowserObject >> isNull [
	^false
]

{ #category : #accessing }
ObjectBrowserObject >> methodCategory: aSelector [
	^ self realClass organization categoryOfElement: aSelector.
]

{ #category : #accessing }
ObjectBrowserObject >> methods [
	^(self myClassMethods union: prototype methods)
]

{ #category : #accessing }
ObjectBrowserObject >> myClassHasMethod: aSelector [
	^self myClassMethodSelectors includes: aSelector 
]

{ #category : #accessing }
ObjectBrowserObject >> myClassMethodSelectors [
	^self realClass selectors asOrderedCollection
]

{ #category : #accessing }
ObjectBrowserObject >> myClassMethods [
	^methods
]

{ #category : #accessing }
ObjectBrowserObject >> objectBrowser [
	^objectBrowser
]

{ #category : #accessing }
ObjectBrowserObject >> objectBrowser: anOB [
	objectBrowser := anOB 
]

{ #category : #accessing }
ObjectBrowserObject >> objectName [
	^ objectName
]

{ #category : #accessing }
ObjectBrowserObject >> objectName: anObject [
	objectName := anObject.
	self changed.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> printString [
	^ 'anObject'
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
ObjectBrowserObject >> references [
	| refs |
	refs := self variables collect: [:v | self realObject instVarNamed: v asSymbol ].
	prototype addInversePrototypeRelationship: refs.
	^refs.
]

{ #category : #accessing }
ObjectBrowserObject >> removeClassFromSystem [
	self realClass removeFromSystem
]

{ #category : #accessing }
ObjectBrowserObject >> removeFromSystem [
	self hasClones
		ifTrue: [self error: 'No se puede eliminar un objeto con clones'].
	(self objectBrowser canDelete: self)
		ifFalse: [self error: 'No se puede eliminar a un objeto que es referenciado por otro'].
	self objectBrowser removeObject: self.
	self removeClassFromSystem
]

{ #category : #accessing }
ObjectBrowserObject >> removeMethod: aSelector [
	self realClass removeSelector: aSelector.
	self changed.
]

{ #category : #accessing }
ObjectBrowserObject >> removeVariable: variableName [
	self realClass removeInstVarName: variableName.
	self changed.
]

{ #category : #accessing }
ObjectBrowserObject >> size [
	^self realObject size
]

{ #category : #accessing }
ObjectBrowserObject >> sourceCodeAt: aSelector [ 
	^ (self myClassHasMethod: aSelector)
		ifTrue: [(self realClass sourceCodeAt: aSelector)
				makeSelectorBoldIn: self realClass]
		ifFalse: [prototype sourceCodeAt: aSelector]
]

{ #category : #accessing }
ObjectBrowserObject >> variables [
	^ (variables union: prototype variables)
]
