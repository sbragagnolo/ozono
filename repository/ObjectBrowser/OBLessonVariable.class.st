"
I am a variable hold by the lesson.
"
Class {
	#name : #OBLessonVariable,
	#superclass : #Object,
	#instVars : [
		'reference',
		'name'
	],
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #'instance-creation' }
OBLessonVariable class >> newNamed: aNameString [
	^self new name: aNameString; yourself
]

{ #category : #visiting }
OBLessonVariable >> accept: aVisitor [

	aVisitor visitLessonVariable: self.
]

{ #category : #printing }
OBLessonVariable >> asString [

	^self name, ' - (' , self pointsTo displayString , ')'.
]

{ #category : #printing }
OBLessonVariable >> asStringOrText [

	^self name
]

{ #category : #accessing }
OBLessonVariable >> desreference [

	self pointTo: (OBExternalObjectMetaObject new: nil).
]

{ #category : #references }
OBLessonVariable >> hasReferencesTo: anObject [

	^(reference concreteObject == anObject concreteObject )
]

{ #category : #ui }
OBLessonVariable >> icon [

	^OBIcons referenceIcon
]

{ #category : #references }
OBLessonVariable >> isPointingTo: anObject [

	^reference = anObject
]

{ #category : #selection }
OBLessonVariable >> makeSelectionOn: anObjectBrowser [

	anObjectBrowser selectedObjectBrowserVariable: self.
]

{ #category : #ui }
OBLessonVariable >> menu: aMenuMorph [ 

	|opcionEliminar|
	opcionEliminar := Array braceWith: 'Eliminar referencia a este objeto' translated with: #deleteLessonVariable.
	aMenuMorph addList: (OrderedCollection with: opcionEliminar ).
	self pointsTo menu: aMenuMorph.
	^aMenuMorph
]

{ #category : #accessing }
OBLessonVariable >> name [

	 ^name
]

{ #category : #accessing }
OBLessonVariable >> name: aName [

	 name := aName
]

{ #category : #selection }
OBLessonVariable >> notifySelectionTo: anObserverCollection [

	anObserverCollection do: [ :o | o selectedClassOrMetaClass: self pointsTo realClass ]
]

{ #category : #accessing }
OBLessonVariable >> pointTo: anObject [

	reference := anObject.
	self changed.
]

{ #category : #references }
OBLessonVariable >> pointsTo [

	^reference
]

{ #category : #printing }
OBLessonVariable >> printString [

	^self pointsTo printString
]

{ #category : #ui }
OBLessonVariable >> treeContents [

	^#()
]
