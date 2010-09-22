Class {
	#name : #ObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'objectName',
		'objectBrowser',
		'prototype',
		'variables',
		'methods',
		'lesson'
	],
	#classVars : [
		'NextObjectBrowserClassNumber'
	],
	#category : #'ObjectBrowser-Model'
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
		#- "
		#('renombrar objeto' #renameObject)
		#('eliminar objeto' #deleteObject)").
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> addInversePrototypeRelationship: references [

	references add: self.
]

{ #category : #accessing }
ObjectBrowserObject >> addVariable: variableName [
	self realClass addInstVarName: variableName.
	variables add: (OBVariable newNamed: variableName).
	self changed.
]

{ #category : #accessing }
ObjectBrowserObject >> at: index [
	^self realObject at: index .
]

{ #category : #accessing }
ObjectBrowserObject >> at: index put: obj [
	^self realObject at: index put: obj.
]

{ #category : #printing }
ObjectBrowserObject >> clone [
	^self class newFrom: self on: self lesson.
]

{ #category : #printing }
ObjectBrowserObject >> compileMethod: aMethod [
	| result |
	result := self realClass compile: aMethod classified: #'object browser'  notifying: nil.
	methods add: (OBMethod new 
		selector: result;
		object: self;
		yourself).
	result ifNotNil: [self changed].
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> doesNotUnderstand: aMessage [ 
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

{ #category : #printing }
ObjectBrowserObject >> lesson [
	^lesson
]

{ #category : #printing }
ObjectBrowserObject >> lesson: aLesson [
	lesson := aLesson
]

{ #category : #accessing }
ObjectBrowserObject >> methodCategory: aSelector [
	^ self realClass organization categoryOfElement: aSelector.
]

{ #category : #accessing }
ObjectBrowserObject >> methodOfSelector: aSelector [
	^self myClassMethods detect: [:m | m selector = aSelector ].
]

{ #category : #accessing }
ObjectBrowserObject >> methods [
	^(self myClassMethods union: prototype methods)
]

{ #category : #accessing }
ObjectBrowserObject >> myClassHasMethod: aSelector [
	^self myClassMethods includes: aSelector 
]

{ #category : #accessing }
ObjectBrowserObject >> myClassMethodSelectors [
	^self realClass selectors asOrderedCollection
]

{ #category : #accessing }
ObjectBrowserObject >> myClassMethods [
	^methods
]

{ #category : #printing }
ObjectBrowserObject >> object [
	^self
]

{ #category : #accessing }
ObjectBrowserObject >> objectBrowser [
	^objectBrowser
]

{ #category : #accessing }
ObjectBrowserObject >> objectBrowser: anOB [
	objectBrowser := anOB 
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> objectPointedBy:  varName [
	^self realObject instVarNamed: varName 
	

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
ObjectBrowserObject >> referencePosibleName: name [
	|object|
	object := self objectPointedBy: name.

	( object isKindOf: ObjectBrowserObject ) 
		ifTrue: [ ^object posibleName ] 
		ifFalse: [^ object printString ].
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> references [
	| refs |
	refs := self variables collect: [:v | self objectPointedBy:  v asSymbol].
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
ObjectBrowserObject >> removeMethod: aMethod [
	self realClass removeSelector: aMethod selector.
	self myClassMethods remove: aMethod.
	self changed.
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

{ #category : #accessing }
ObjectBrowserObject >> variable: varName pointTo: anObject [
	self realObject instVarNamed: varName put: anObject.
]

{ #category : #accessing }
ObjectBrowserObject >> variableNamed: varName [
	^self variables detect: [:v | v name = varName ].
]

{ #category : #accessing }
ObjectBrowserObject >> variables [
	^ (variables union: prototype variables)
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> writeCreateObjectOn: stream [ .
	stream nextPutAll: self posibleName ,  ' := ', ObjectBrowserObject name , ' new.'.
	stream cr.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> writeCreationScriptOver: stream [
	| objectVariable |
	objectVariable := self posibleName.
	
	stream nextPutAll: '| ', objectVariable , '|'.
	
	self writeObjectDescriptionScriptOn:  stream .

	stream nextPutAll: 'self addObject: ', objectVariable, '.'.
	stream cr.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> writeMethodsOn: stream [ .
	
	self methods do:[ :m |
		stream nextPutAll: self posibleName  , ' compileMethod: ''' , (m code copyReplaceAll: $' asString with: $' asString,$' asString ), '''.'.
		stream cr.
		].

]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> writeObjectDescriptionScriptOn: stream [ 

	self writeCreateObjectOn: stream .
	self writeVarianblesOn: stream .
	self writeMethodsOn: stream .
	

]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> writeStateScriptOn: stream [
	"saves the state, all the variables values and relationships"
	self variables do:  [ :var | 
			stream nextPutAll: self posibleName , ' variable: ''',var name,''' pointTo: ', (self referencePosibleName: var name) , '.'. 
			stream cr].

]

{ #category : #'as yet unclassified' }
ObjectBrowserObject >> writeVarianblesOn: stream [ .

	self variables do:[ :v | 
		stream nextPutAll: self posibleName , ' addVariable: ''', v name, '''.'.
		stream cr.
		].
]
