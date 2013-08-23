Class {
	#name : #NoObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'methods'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
NoObjectBrowserObject class >> for: anObject [
	^((anObject isKindOf: Collection) and: [ (anObject isKindOf: String) not ])
		ifTrue: [ ObjectBrowserCollection newWithRealObject: anObject ]
		ifFalse: [ self new: anObject ].
]

{ #category : #'instance-creation' }
NoObjectBrowserObject class >> new: anObject [
	^self new realObject: anObject; yourself.
]

{ #category : #comparing }
NoObjectBrowserObject >> = anotherObject [
	^(self class == anotherObject class) and:[(self realObject == anotherObject realObject) ]
]

{ #category : #'ui-actions' }
NoObjectBrowserObject >> actionsForAttributeListWith: aNullOBVariable [ 
	^#()
]

{ #category : #'ui-actions' }
NoObjectBrowserObject >> actionsForObjectBrowserReferencesList [
	^OrderedCollection new.
]

{ #category : #graph }
NoObjectBrowserObject >> addToGraph: aLessonGraph [ 
	aLessonGraph addNoObjectBrowserObject: self.
]

{ #category : #printing }
NoObjectBrowserObject >> asString [
	^self displayString 
]

{ #category : #attributes }
NoObjectBrowserObject >> attributes [

	^#()
]

{ #category : #methods }
NoObjectBrowserObject >> compileMethod: aText notifying: someone [
	self error: 'No puede modificarse este objeto'
]

{ #category : #printing }
NoObjectBrowserObject >> displayString [
	^self object printString
]

{ #category : #references }
NoObjectBrowserObject >> hasReferencesTo: anObject [
	^false
]

{ #category : #comparing }
NoObjectBrowserObject >> hash [
	^self realObject hash
]

{ #category : #methods }
NoObjectBrowserObject >> isRedefined: aSelector [
	^false
]

{ #category : #'ui-actions' }
NoObjectBrowserObject >> menu: aMenuMorph [ 
	^aMenuMorph
]

{ #category : #methods }
NoObjectBrowserObject >> methods [
	^methods ifNil: [ methods := realObject class methods collect:[:m | OBMethod new selector: (m selector); object: self; yourself ]. ]
]

{ #category : #methods }
NoObjectBrowserObject >> myClassHasMethod: aSelector [

	^true
]

{ #category : #accessing }
NoObjectBrowserObject >> posibleName [
	^'(NoObjectBrowserObject new: ', self realObject printString, ')'


]

{ #category : #printing }
NoObjectBrowserObject >> printString [
	^self object printString
]

{ #category : #'pharo-interaction' }
NoObjectBrowserObject >> realClass [
	^realObject class
]

{ #category : #accessing }
NoObjectBrowserObject >> realObject [
	^realObject
]

{ #category : #accessing }
NoObjectBrowserObject >> realObject: anObject [ 
	realObject := anObject.
]

{ #category : #methods }
NoObjectBrowserObject >> redefines: aSelector [
	^false
]

{ #category : #'pharo-interaction' }
NoObjectBrowserObject >> removeClassFromSystem [
	"Shouldn't remove anything'"
]

{ #category : #methods }
NoObjectBrowserObject >> sourceCodeAt: anOBMethod [ 
	^anOBMethod code
]

{ #category : #methods }
NoObjectBrowserObject >> understands: aSelector [
	^self object respondsTo: aSelector asSymbol 
]

{ #category : #attributes }
NoObjectBrowserObject >> variables [
	^OrderedCollection new.
]

{ #category : #exporting }
NoObjectBrowserObject >> writeCreateObjectOn: stream lesson: aLesson [
	"Un NoObjectBrowserObject no se escribe"
]

{ #category : #exporting }
NoObjectBrowserObject >> writeObjectDescriptionScriptOn: stream lesson: aLesson [
	"Un NoObjectBrowserObject no se escribe"
]

{ #category : #exporting }
NoObjectBrowserObject >> writeStateScriptOn: stream lesson: aLesson [
	"Un NoObjectBrowserObject no se escribe"
]
