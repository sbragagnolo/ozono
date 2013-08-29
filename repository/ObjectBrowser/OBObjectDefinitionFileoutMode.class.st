Class {
	#name : #OBObjectDefinitionFileoutMode,
	#superclass : #OBObjectFileoutMode,
	#category : #'ObjectBrowser-Fileout'
}

{ #category : #visiting }
OBObjectDefinitionFileoutMode >> visitCollection: anObject inFileoutFormat: aFormat [

	aFormat visitCollectionForDefinition: anObject
]

{ #category : #visiting }
OBObjectDefinitionFileoutMode >> visitObject: anObject inFileoutFormat: aFormat [

	aFormat visitObjectForDefinition: anObject
]
