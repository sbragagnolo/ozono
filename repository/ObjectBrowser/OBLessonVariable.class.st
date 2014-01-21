"
I am a variable hold by the lesson.

"
Class {
	#name : #OBLessonVariable,
	#superclass : #Object,
	#instVars : [
		'baseObjectBinding'
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

{ #category : #references }
OBLessonVariable >> baseObjectBinding [

	^baseObjectBinding
]

{ #category : #references }
OBLessonVariable >> baseObjectBinding: aAssotiation [

	^baseObjectBinding := aAssotiation
]

{ #category : #accessing }
OBLessonVariable >> desreference [

	self pointTo: (OBExternalObjectMetaObject new: nil).
]

{ #category : #references }
OBLessonVariable >> hasReferencesTo: anObject [

	^(baseObjectBinding value baseObject == anObject baseObject )
]

{ #category : #ui }
OBLessonVariable >> icon [

	^OBIcons referenceIcon
]

{ #category : #printing }
OBLessonVariable >> initialize [

	super initialize.
	self baseObjectBinding: (Association key: nil value: nil)
]

{ #category : #references }
OBLessonVariable >> isPointingTo: anObject [

	^baseObjectBinding value = anObject
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

	^ baseObjectBinding key
]

{ #category : #accessing }
OBLessonVariable >> name: aName [

	baseObjectBinding key: aName
]

{ #category : #selection }
OBLessonVariable >> notifySelectionTo: anObserverCollection [

	anObserverCollection do: [ :o | o selectedClassOrMetaClass: (OBPharoReflection uniqueInstance classOf: self pointsTo baseObject) ]
]

{ #category : #accessing }
OBLessonVariable >> pointTo: anMetaObject [

	baseObjectBinding value: anMetaObject baseObject.
	self changed.
]

{ #category : #references }
OBLessonVariable >> pointsTo [

	^baseObjectBinding value metaObject.
]

{ #category : #printing }
OBLessonVariable >> printString [

	^self pointsTo printString
]

{ #category : #ui }
OBLessonVariable >> treeContents [

	^#()
]
