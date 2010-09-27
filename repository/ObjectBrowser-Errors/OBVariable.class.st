Class {
	#name : #OBVariable,
	#superclass : #Object,
	#instVars : [
		'name',
		'reference',
		'originalName',
		'lesson'
	],
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBVariable class >> newNamed: variableName [

	^self new
		name: variableName;
		originalName: variableName;
		yourself 
]

{ #category : #'as yet unclassified' }
OBVariable >> actionsForAttributeList [
	^#(('eliminar variable'		deleteVariable))
]

{ #category : #'as yet unclassified' }
OBVariable >> asString [
	^self name, ' - (' , self pointsTo displayString , ')'.
]

{ #category : #'as yet unclassified' }
OBVariable >> asStringOrText [ 
	^self name
]

{ #category : #'as yet unclassified' }
OBVariable >> desreference [
	self pointTo: (NoObjectBrowserObject new: nil).
]

{ #category : #messages }
OBVariable >> errorNotIndexable [
	"Create an error notification that the receiver is not indexable."

	self error: ('Instances of {1} are not indexable' translated format: {self pointsTo printString})
]

{ #category : #showing }
OBVariable >> icon [
	^ObjectBrowserIcons referenceIcon
]

{ #category : #'as yet unclassified' }
OBVariable >> isPointingTo: anObject [
	^reference = anObject
]

{ #category : #selection }
OBVariable >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser selectedObjectBrowserVariable: self.
]

{ #category : #menues }
OBVariable >> menu: aMenuMorph [ 
	aMenuMorph add: 'dereferenciar' action: #dereferenceSelectedVariable.
	self pointsTo menu: aMenuMorph.
	^aMenuMorph
]

{ #category : #'as yet unclassified' }
OBVariable >> name [
	^name
]

{ #category : #'as yet unclassified' }
OBVariable >> name: aNameString [
	name := aNameString
]

{ #category : #accessing }
OBVariable >> originalName: anObject [
	originalName := anObject
]

{ #category : #'as yet unclassified' }
OBVariable >> pointTo: anObject [
	reference := anObject.
	self changed.
]

{ #category : #'as yet unclassified' }
OBVariable >> pointsTo [
	^reference
]

{ #category : #'as yet unclassified' }
OBVariable >> printString [ 
	^self pointsTo printString 
]

{ #category : #messages }
OBVariable >> referencePosibleName [
	^self pointsTo posibleName
]

{ #category : #'as yet unclassified' }
OBVariable >> removeFrom: aRealClass [
	aRealClass removeInstVarName: originalName.
]

{ #category : #'as yet unclassified' }
OBVariable >> renameAs: aString [

	self name: aString 
]

{ #category : #accessing }
OBVariable >> treeContents [
	^OrderedCollection new
]
