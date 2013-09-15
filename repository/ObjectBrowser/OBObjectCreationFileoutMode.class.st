Class {
	#name : #OBObjectCreationFileoutMode,
	#superclass : #OBObjectFileoutMode,
	#category : #'ObjectBrowser-Fileout'
}

{ #category : #visiting }
OBObjectCreationFileoutMode >> visitCollection: anObject inFileoutFormat: aFormat [

	aFormat visitCollectionForCreation: anObject
]

{ #category : #visiting }
OBObjectCreationFileoutMode >> visitDictionary: anObject inFileoutFormat: aFormat [

	aFormat visitDictionaryForCreation: anObject
]

{ #category : #visiting }
OBObjectCreationFileoutMode >> visitObject: anObject inFileoutFormat: aFormat [

	aFormat visitObjectForCreation: anObject
]
