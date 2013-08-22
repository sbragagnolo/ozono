Class {
	#name : #ObjectBrowserClass,
	#superclass : #Object,
	#classVars : [
		'ObjectBrowserObjects'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'as yet unclassified' }
ObjectBrowserClass class >> new [
	^self basicNew
]

{ #category : #cloning }
ObjectBrowserClass >> clone [
	LOOPLesson allInstancesDo: [ :aLesson |
		aLesson objects do: [ :anObjectBrowserObject |
			anObjectBrowserObject realObject == self ifTrue:
				[ ^anObjectBrowserObject clone ]]].
	self error: 'Se está intentando clonar un objeto que no tiene representación en ninguna lección'
]

{ #category : #printing }
ObjectBrowserClass >> displayString [

	^'anObject'
]

{ #category : #printing }
ObjectBrowserClass >> printOn: aStream [

	aStream nextPutAll: self displayString
]
