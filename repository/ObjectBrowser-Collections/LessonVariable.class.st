Class {
	#name : #LessonVariable,
	#superclass : #Object,
	#instVars : [
		'reference',
		'name'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #creation }
LessonVariable class >> newNamed: aNameString [
	^self new name: aNameString; yourself
]

{ #category : #'as yet unclassified' }
LessonVariable >> asString [
	^self name, ' - (' , self pointsTo displayString , ')'.
]

{ #category : #'as yet unclassified' }
LessonVariable >> asStringOrText [ 
	^self name
]

{ #category : #'as yet unclassified' }
LessonVariable >> desreference [
	self pointTo: (NoObjectBrowserObject new: nil).
]

{ #category : #'as yet unclassified' }
LessonVariable >> hasReferencesTo: anObject [

	^(reference realObject == anObject realObject )
]

{ #category : #showing }
LessonVariable >> icon [
	^ObjectBrowserIcons referenceIcon
]

{ #category : #'as yet unclassified' }
LessonVariable >> isPointingTo: anObject [
	^(reference = anObject)
]

{ #category : #selection }
LessonVariable >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser selectedObjectBrowserVariable: self.
	
]

{ #category : #menues }
LessonVariable >> menu: aMenuMorph [ 
|opcionEliminar|
	opcionEliminar := Array braceWith: 'Eliminar referencia a este objeto' translated with: #deleteLessonVariable.
	aMenuMorph addList: (OrderedCollection with: opcionEliminar ).
	self pointsTo menu: aMenuMorph.
	^aMenuMorph
]

{ #category : #menues }
LessonVariable >> name [
	 ^name
]

{ #category : #menues }
LessonVariable >> name: aName [
	 name := aName
]

{ #category : #messages }
LessonVariable >> notifySelectionTo: anObserverCollection [
	anObserverCollection do: [ :o | o selectedClassOrMetaClass: self pointsTo realClass ]
]

{ #category : #'as yet unclassified' }
LessonVariable >> pointTo: anObject [
	reference := anObject.
	self changed.
]

{ #category : #'as yet unclassified' }
LessonVariable >> pointsTo [
	^reference
]

{ #category : #'as yet unclassified' }
LessonVariable >> printString [ 
	^self pointsTo printString 
]

{ #category : #messages }
LessonVariable >> referencePosibleName [
	^self pointsTo posibleName
]

{ #category : #accessing }
LessonVariable >> treeContents [
	^OrderedCollection new
]
