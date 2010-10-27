Class {
	#name : #NoObjectBrowserObject,
	#superclass : #Object,
	#instVars : [
		'realObject',
		'methods'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
NoObjectBrowserObject class >> new: anObject [
	^self new realObject: anObject; yourself.
]

{ #category : #'as yet unclassified' }
NoObjectBrowserObject >> = anotherObject [
	^(self class == anotherObject class) and:[(self realObject == anotherObject realObject) ]
]

{ #category : #'as yet unclassified' }
NoObjectBrowserObject >> actionsForAttributeListWith: aNullOBVariable [ 
	^#()
]

{ #category : #accessing }
NoObjectBrowserObject >> actionsForObjectVariableList [
	^OrderedCollection new.
]

{ #category : #'graph model' }
NoObjectBrowserObject >> addToGraph: aLessonGraph [ 
	aLessonGraph addNoObjectBrowserObject: self.
]

{ #category : #printing }
NoObjectBrowserObject >> asString [
	^self posibleName
]

{ #category : #'as yet unclassified' }
NoObjectBrowserObject >> canDelete [
	^ realObject isNil.
]

{ #category : #compiling }
NoObjectBrowserObject >> compileMethod: aText [ 
	self error: 'No puede modificarse este objeto'
]

{ #category : #printing }
NoObjectBrowserObject >> displayString [
	^self object printString
]

{ #category : #'as yet unclassified' }
NoObjectBrowserObject >> fullfillObjectBrowserObjectsCollection: aSet [ 
	(aSet includes: self) ifFalse:[
		aSet add: self 
		]
]

{ #category : #'as yet unclassified' }
NoObjectBrowserObject >> hasReferencesTo: anObject [
	^false
]

{ #category : #'as yet unclassified' }
NoObjectBrowserObject >> hash [
	^self realObject hash
]

{ #category : #menu }
NoObjectBrowserObject >> menu: aMenuMorph [ 
	aMenuMorph add: 'Borrar' action: #deleteObject.
	^aMenuMorph
]

{ #category : #accessing }
NoObjectBrowserObject >> methods [
	^methods 
]

{ #category : #accessing }
NoObjectBrowserObject >> object [
	^realObject
]

{ #category : #accessing }
NoObjectBrowserObject >> posibleName [
	^self object printString
]

{ #category : #accessing }
NoObjectBrowserObject >> printString [
	^self object printString
]

{ #category : #accessing }
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
	methods := realObject class methods 
				collect:[:m | OBMethod new selector: (m selector); yourself ].
]

{ #category : #accessing }
NoObjectBrowserObject >> sourceCodeAt: anOBMethod [ 
	^(realObject class sourceCodeAt: anOBMethod selector)
				makeSelectorBoldIn: realObject class.
]

{ #category : #accessing }
NoObjectBrowserObject >> variables [
	^OrderedCollection new.
]
