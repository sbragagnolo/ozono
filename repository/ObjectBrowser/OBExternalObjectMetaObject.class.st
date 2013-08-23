"
I am a meta-object representing an object that is not from the object browser but from pharo. For example, my realObject may be a number or a string.

I do not support all the same operations as an OBMetaObject, but mostly introspection.
"
Class {
	#name : #OBExternalObjectMetaObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'methods'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBExternalObjectMetaObject class >> for: anObject [
	^((anObject isKindOf: Collection) and: [ (anObject isKindOf: String) not ])
		ifTrue: [ ObjectBrowserCollection newWithRealObject: anObject ]
		ifFalse: [ self new: anObject ].
]

{ #category : #'instance-creation' }
OBExternalObjectMetaObject class >> new: anObject [
	^self new realObject: anObject; yourself.
]

{ #category : #comparing }
OBExternalObjectMetaObject >> = anotherObject [
	^(self class == anotherObject class) and:[(self realObject == anotherObject realObject) ]
]

{ #category : #'ui-actions' }
OBExternalObjectMetaObject >> actionsForAttributeListWith: aNullOBVariable [ 
	^#()
]

{ #category : #'ui-actions' }
OBExternalObjectMetaObject >> actionsForObjectBrowserReferencesList [
	^OrderedCollection new.
]

{ #category : #graph }
OBExternalObjectMetaObject >> addToGraph: aLessonGraph [ 
	aLessonGraph addNoObjectBrowserObject: self.
]

{ #category : #printing }
OBExternalObjectMetaObject >> asString [
	^self displayString 
]

{ #category : #attributes }
OBExternalObjectMetaObject >> attributes [

	^#()
]

{ #category : #methods }
OBExternalObjectMetaObject >> compileMethod: aText notifying: someone [
	self error: 'No puede modificarse este objeto'
]

{ #category : #printing }
OBExternalObjectMetaObject >> displayString [
	^self object printString
]

{ #category : #references }
OBExternalObjectMetaObject >> hasReferencesTo: anObject [
	^false
]

{ #category : #comparing }
OBExternalObjectMetaObject >> hash [
	^self realObject hash
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
	^methods ifNil: [ methods := realObject class methods collect:[:m | OBMethod new selector: (m selector); object: self; yourself ]. ]
]

{ #category : #methods }
OBExternalObjectMetaObject >> myClassHasMethod: aSelector [

	^true
]

{ #category : #accessing }
OBExternalObjectMetaObject >> posibleName [
	^'(',self class name,' new: ', self realObject printString, ')'


]

{ #category : #printing }
OBExternalObjectMetaObject >> printString [
	^self realObject printString
]

{ #category : #'pharo-interaction' }
OBExternalObjectMetaObject >> realClass [
	^realObject class
]

{ #category : #accessing }
OBExternalObjectMetaObject >> realObject [
	^realObject
]

{ #category : #accessing }
OBExternalObjectMetaObject >> realObject: anObject [ 
	realObject := anObject.
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

{ #category : #exporting }
OBExternalObjectMetaObject >> writeCreateObjectOn: stream lesson: aLesson [
	"Un NoObjectBrowserObject no se escribe"
]

{ #category : #exporting }
OBExternalObjectMetaObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [
	"Un NoObjectBrowserObject no se escribe"
]

{ #category : #exporting }
OBExternalObjectMetaObject >> writeStateScriptOn: stream lesson: aLesson [
	"Un NoObjectBrowserObject no se escribe"
]