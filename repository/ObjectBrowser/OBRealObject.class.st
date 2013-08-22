Class {
	#name : #OBRealObject,
	#superclass : #Object,
	#classVars : [
		'ObjectBrowserObjects'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
OBRealObject class >> new [
	^self basicNew
]

{ #category : #cloning }
OBRealObject >> clone [
	LOOPLesson allInstancesDo: [ :aLesson |
		aLesson objects do: [ :anObjectBrowserObject |
			anObjectBrowserObject realObject == self ifTrue:
				[ ^anObjectBrowserObject clone ]]].
	self error: 'Se está intentando clonar un objeto que no tiene representación en ninguna lección'
]

{ #category : #printing }
OBRealObject >> displayString [

	^'anObject'
]

{ #category : #printing }
OBRealObject >> printOn: aStream [

	aStream nextPutAll: self displayString
]

{ #category : #printing }
OBRealObject >> printString [

	^self displayString
]
