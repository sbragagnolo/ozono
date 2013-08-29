Class {
	#name : #OBObjectStateFileoutMode,
	#superclass : #OBObjectFileoutMode,
	#category : #'ObjectBrowser-Fileout'
}

{ #category : #visiting }
OBObjectStateFileoutMode >> visitCollection: anObject inFileoutFormat: aFormat [

	aFormat visitCollectionForState: anObject
]

{ #category : #visiting }
OBObjectStateFileoutMode >> visitObject: anObject inFileoutFormat: aFormat [

	aFormat visitObjectForState: anObject
]
