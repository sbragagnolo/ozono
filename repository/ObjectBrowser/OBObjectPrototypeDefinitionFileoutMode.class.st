Class {
	#name : #OBObjectPrototypeDefinitionFileoutMode,
	#superclass : #OBObjectFileoutMode,
	#category : #'ObjectBrowser-Fileout'
}

{ #category : #'as yet unclassified' }
OBObjectPrototypeDefinitionFileoutMode >> visitObject: anObject inFileoutFormat: aFormat [

	aFormat visitPrototype: anObject
]
