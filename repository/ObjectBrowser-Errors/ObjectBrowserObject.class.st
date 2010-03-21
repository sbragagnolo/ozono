Class {
	#name : #ObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'objectName',
		'objectBrowser',
		'prototype'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> buildClassForObjectName: aName andSuperclass: aSuperclass [
	^aSuperclass subclass: (aName capitalized asSymbol)
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ObjectBrowser-Objects'
	
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> createObjectBrowserObjectWithName: aName andClass: aClass inObjectBrowser: anObjectBrowser [ 
	| newObject |
	newObject := self
				new: aName
				realObject: aClass new
				objectBrowser: anObjectBrowser.
	anObjectBrowser addObject: newObject.
	^ newObject
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> createObjectBrowserObjectWithName: aName andSuperclass: aSuperclass inObjectBrowser: anObjectBrowser [ 
	| objectClass |
	objectClass := self buildClassForObjectName: aName andSuperclass: aSuperclass.
	^ self
		createObjectBrowserObjectWithName: aName
		andClass: objectClass
		inObjectBrowser: anObjectBrowser
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> new: aName realObject: anObject [
	^ self new objectName: aName;
		 realObject: anObject;
		 yourself
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject class >> new: aName realObject: anObject objectBrowser: ob [
	^ self new objectName: aName;
		 realObject: anObject;
		objectBrowser: ob;
		 yourself
]

{ #category : #accessing }
ObjectBrowserObject >> addVariable: variableName [
	self realClass addInstVarName: variableName.
	self changed.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> cloneWithName: aName [ 
	| obo |
	obo := ObjectBrowserObject
				createObjectBrowserObjectWithName: aName
				andSuperclass: self realClass
				inObjectBrowser: self objectBrowser.
	obo prototype: self.
	^ obo
]

{ #category : #printing }
ObjectBrowserObject >> compileMethod: aMethod  notifying: someone [
	| result |
	result := self realClass compile: aMethod classified: #'object browser'  notifying: someone.
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
	^self methods includes: aSelector 
]

{ #category : #accessing }
ObjectBrowserObject >> hasReferencesTo: anOBObject [

	^self references anySatisfy: [ :aVariable | aVariable = anOBObject realObject]
]

{ #category : #accessing }
ObjectBrowserObject >> hasVariable: aVariableName [
	^self variables includes: aVariableName 
]

{ #category : #accessing }
ObjectBrowserObject >> initialize [
	super initialize.
	self prototype: NullObjectBrowserObject new.
	^self
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
	^(self myClassMethods, prototype methods) asSet asOrderedCollection
]

{ #category : #accessing }
ObjectBrowserObject >> myClassHasMethod: aSelector [
	^self myClassMethods includes: aSelector 
]

{ #category : #accessing }
ObjectBrowserObject >> myClassMethods [
	^self realClass methodDict keys asOrderedCollection
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
	objectName := anObject
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> printString [
	^ self objectName
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
	^ self realClass instVarNames asOrderedCollection , prototype variables
]
