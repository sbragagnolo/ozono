"
I am a variable hold by the lesson.
"
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

{ #category : #printing }
LessonVariable >> asString [

	^self name, ' - (' , self pointsTo displayString , ')'.
]

{ #category : #printing }
LessonVariable >> asStringOrText [

	^self name
]

{ #category : #accessing }
LessonVariable >> desreference [

	self pointTo: (OBExternalObjectMetaObject new: nil).
]

{ #category : #references }
LessonVariable >> hasReferencesTo: anObject [

	^(reference realObject == anObject realObject )
]

{ #category : #ui }
LessonVariable >> icon [

	^OBIcons referenceIcon
]

{ #category : #references }
LessonVariable >> isPointingTo: anObject [

	^reference = anObject
]

{ #category : #selection }
LessonVariable >> makeSelectionOn: anObjectBrowser [

	anObjectBrowser selectedObjectBrowserVariable: self.
]

{ #category : #ui }
LessonVariable >> menu: aMenuMorph [ 

	|opcionEliminar|
	opcionEliminar := Array braceWith: 'Eliminar referencia a este objeto' translated with: #deleteLessonVariable.
	aMenuMorph addList: (OrderedCollection with: opcionEliminar ).
	self pointsTo menu: aMenuMorph.
	^aMenuMorph
]

{ #category : #accessing }
LessonVariable >> name [

	 ^name
]

{ #category : #accessing }
LessonVariable >> name: aName [

	 name := aName
]

{ #category : #selection }
LessonVariable >> notifySelectionTo: anObserverCollection [

	anObserverCollection do: [ :o | o selectedClassOrMetaClass: self pointsTo realClass ]
]

{ #category : #accessing }
LessonVariable >> pointTo: anObject [

	reference := anObject.
	self changed.
]

{ #category : #references }
LessonVariable >> pointsTo [

	^reference
]

{ #category : #printing }
LessonVariable >> printString [

	^self pointsTo printString
]

{ #category : #ui }
LessonVariable >> treeContents [

	^#()
]
