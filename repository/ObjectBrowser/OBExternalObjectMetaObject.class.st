"
I am a meta-object representing an object that is not from the object browser but from pharo. For example, my realObject may be a number or a string.

I do not support all the same operations as an OBMetaObject, but mostly introspection.
"
Class {
	#name : #OBExternalObjectMetaObject,
	#superclass : #OBAbstractMetaObject,
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBExternalObjectMetaObject class >> for: anObject [
	^((anObject isKindOf: Collection) and: [ (anObject isKindOf: String) not ])
		ifTrue: [ OBCollectionMetaObject newWithRealObject: anObject ]
		ifFalse: [ self new: anObject ].
]

{ #category : #'instance-creation' }
OBExternalObjectMetaObject class >> new: anObject [
	^self new concreteObject: anObject; yourself.
]

{ #category : #comparing }
OBExternalObjectMetaObject >> = anotherObject [
	^(self class == anotherObject class) and:[(self baseObject == anotherObject baseObject) ]
]

{ #category : #visiting }
OBExternalObjectMetaObject >> accept: aVisitor [

	aVisitor visitOBExternalObject: self.
]

{ #category : #'ui-actions' }
OBExternalObjectMetaObject >> actionsForAttributeListWith: aNullOBVariable [ 
	^#()
]

{ #category : #'ui-actions' }
OBExternalObjectMetaObject >> actionsForObjectBrowserReferencesList [
	^OrderedCollection new.
]

{ #category : #printing }
OBExternalObjectMetaObject >> asString [
	^self displayString 
]

{ #category : #attributes }
OBExternalObjectMetaObject >> attributes [

	^#()
]

{ #category : #accessing }
OBExternalObjectMetaObject >> baseObject [

	^ concreteObject
]

{ #category : #cloning }
OBExternalObjectMetaObject >> clone [

	^self class for: self baseObject.
]

{ #category : #methods }
OBExternalObjectMetaObject >> compileMethod: aText notifying: someone [
	self error: 'No puede modificarse este objeto'
]

{ #category : #accessing }
OBExternalObjectMetaObject >> concreteObject: anObject [ 

	concreteObject := anObject.
]

{ #category : #printing }
OBExternalObjectMetaObject >> displayString [
	^self baseObject printString
]

{ #category : #references }
OBExternalObjectMetaObject >> hasReferencesTo: anObject [
	^false
]

{ #category : #comparing }
OBExternalObjectMetaObject >> hash [
	^self baseObject hash
]

{ #category : #methods }
OBExternalObjectMetaObject >> isRedefined: aSelector [
	^false
]

{ #category : #'ui-actions' }
OBExternalObjectMetaObject >> menu: aMenuMorph [ 
	^aMenuMorph
]

{ #category : #methods }
OBExternalObjectMetaObject >> methods [
	^ methods
		ifNil: [ 
			methods := concreteObject class methods
				collect: [ :m | 
					OBMethod new
						selector: m selector;
						object: self;
						yourself ] ]
]

{ #category : #methods }
OBExternalObjectMetaObject >> myClassHasMethod: aSelector [

	^true
]

{ #category : #accessing }
OBExternalObjectMetaObject >> posibleName [
	^'(',self class name,' new: ', self baseObject printString, ')'


]

{ #category : #printing }
OBExternalObjectMetaObject >> printString [
	^self baseObject printString
]

{ #category : #'pharo-interaction' }
OBExternalObjectMetaObject >> realClass [
	^concreteObject class
]

{ #category : #methods }
OBExternalObjectMetaObject >> redefines: aSelector [
	^false
]

{ #category : #'pharo-interaction' }
OBExternalObjectMetaObject >> removeClassFromSystem [
	"Shouldn't remove anything'"
]

{ #category : #methods }
OBExternalObjectMetaObject >> sourceCodeAt: anOBMethod [ 
	^anOBMethod code
]

{ #category : #methods }
OBExternalObjectMetaObject >> understands: aSelector [
	^self object respondsTo: aSelector asSymbol 
]

{ #category : #attributes }
OBExternalObjectMetaObject >> variables [
	^OrderedCollection new.
]
