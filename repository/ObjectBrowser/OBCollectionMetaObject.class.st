"
I am the meta-object that represents an (sub)instance of a collection.

I provide reflective access to the object to treat it as it is inside a prototipical system:

- attributes (instance variables)
- methods
- cloning

I also provide some information of the actions that can be performed on me that is for usage of the UI.
"
Class {
	#name : #OBCollectionMetaObject,
	#superclass : #OBMetaObject,
	#instVars : [
		'posibleName',
		'allClassesMethods'
	],
	#classVars : [
		'CreationObservers',
		'NextCollectionClassNumberAvailable'
	],
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'instance creation' }
OBCollectionMetaObject class >> basicNew [	
	^super basicNew posibleName: self name asLowercase , self collectionClassNumber asString ; yourself 
]

{ #category : #'as yet unclassified' }
OBCollectionMetaObject class >> collectionClassNumber [
	"devuelve un numero valido de coleccion en el sistema, que no se repite con otra colleccion"
	NextCollectionClassNumberAvailable ifNil: [NextCollectionClassNumberAvailable := 0].
	NextCollectionClassNumberAvailable :=  NextCollectionClassNumberAvailable + 1.
	^ NextCollectionClassNumberAvailable - 1.

]

{ #category : #'instance creation' }
OBCollectionMetaObject class >> new [
	^self error: 'Siempre hay que decir que sabor de coleccion queremos'
]

{ #category : #'instance creation' }
OBCollectionMetaObject class >> new: setName [
	^self error: 'Siempre hay que decir que sabor de coleccion queremos'
]

{ #category : #'instance creation' }
OBCollectionMetaObject class >> newWithRealObject: realObject inLesson: aLesson prototype: aPrototypeObject [
	^super new
		concreteObject: realObject;
		lesson: aLesson;
		prototype: aPrototypeObject;
		yourself.
]

{ #category : #visiting }
OBCollectionMetaObject >> accept: aVisitor [

	aVisitor visitCollection: self.
]

{ #category : #adding }
OBCollectionMetaObject >> add: anObj [

	self baseObject add: anObj baseObject.
]

{ #category : #attributes }
OBCollectionMetaObject >> addAttributeNamed: anAttributeName [

	self signalNotModificableCollection
]

{ #category : #attributes }
OBCollectionMetaObject >> allRelationships [
	
	"Returns all normal attributes plus special ones such as the prototype if available"
	| prototypeRelationship |
	prototypeRelationship := self prototype relationWith: self.
	^prototypeRelationship withRelationships: self basicRelationships
]

{ #category : #printing }
OBCollectionMetaObject >> baseDisplayString [

	^ prototype baseDisplayString
]

{ #category : #attributes }
OBCollectionMetaObject >> basicRelationships [
	
	^self baseObject collect: [ :elem | 
		OBSpecialAttribute 
			newNamed: 'elemento'
			owner: self
			pointingTo: elem metaObject
		]
]

{ #category : #methods }
OBCollectionMetaObject >> compileMethod: aMethod  notifying: someone [

	self signalNotModificableCollection
]

{ #category : #methods }
OBCollectionMetaObject >> createMethodWithSelector: aSelector [
	^ OBMethod new
		selector: aSelector;
		object: self;
		yourself
]

{ #category : #printing }
OBCollectionMetaObject >> displayString [

	| className prefix |
	className := self baseObject class name.
	className first isVowel 
		ifTrue: [ prefix := 'an'. ]
		ifFalse: [ prefix:= 'a' ].
	^(prefix, self baseObject class name) asLegalSelector
]

{ #category : #references }
OBCollectionMetaObject >> hasReferencesTo: anOBObject [

	^self baseObject includes: anOBObject baseObject
]

{ #category : #'ui-actions' }
OBCollectionMetaObject >> icon [
	^nil
]

{ #category : #'ui-actions' }
OBCollectionMetaObject >> makeSelectionOn: anObjectBrowser [

	anObjectBrowser selectedPage: #objects.
]

{ #category : #methods }
OBCollectionMetaObject >> methods [
	^ methodsToDisplay
		ifNil: [ methodsToDisplay := self methodsToDisplay asSortedCollection: [ :m1 :m2 | m1 selector < m2 selector ] ]
]

{ #category : #methods }
OBCollectionMetaObject >> methodsToDisplay [
	"(self baseObject class allSelectorsAboveUntil: Collection) collect:..."

	^ self selectorsToDispay collect: [ :aSelector | self createMethodWithSelector: aSelector ]
]

{ #category : #accessing }
OBCollectionMetaObject >> posibleName [

	^ posibleName
]

{ #category : #accessing }
OBCollectionMetaObject >> posibleName: aPosibleName [

	posibleName := aPosibleName
]

{ #category : #printing }
OBCollectionMetaObject >> printString [

	^'aCollection'.
]

{ #category : #attributes }
OBCollectionMetaObject >> removeAttribute: variableName [

	self signalNotModificableCollection
]

{ #category : #'pharo-interaction' }
OBCollectionMetaObject >> removeClassFromSystem [

	"Does nothing. If not, it would remove the collection from the system"

]

{ #category : #methods }
OBCollectionMetaObject >> removeMethod: aSelector [

	self signalNotModificableCollection
]

{ #category : #methods }
OBCollectionMetaObject >> selectorsToDispay [
	^ #(#allSatisfy: #anySatisfy: #asBag #asOrderedCollection #asSet #asSortedCollection: #collect: #count: #detect:ifNone: #detectMax: #detectMin: #do: #gather: #includes: #inject:into: #isEmpty #occurrencesOf: #reject: #select: #size #sum:)
]

{ #category : #accessing }
OBCollectionMetaObject >> signalNotModificableCollection [
	self error: 'las colecciones no son modificables'
]

{ #category : #methods }
OBCollectionMetaObject >> sourceCodeAt: aSelector [

	^'Código mágico :O'
]

{ #category : #'ui-actions' }
OBCollectionMetaObject >> treeContents [
	^OrderedCollection new.
]

{ #category : #attributes }
OBCollectionMetaObject >> variables [

	^ #()
]
