"
I am a null object representing the not existance of a lesson
"
Class {
	#name : #OBNullLesson,
	#superclass : #Object,
	#category : #'ObjectBrowser-Lessons'
}

{ #category : #menues }
OBNullLesson >> menuActions [
	"Una NullLOOPLesson no tiene items en el menu desplegable"
	^OrderedCollection new.
]
