Class {
	#name : #OBCollectionPrototypeV2,
	#superclass : #Object,
	#instVars : [
		'class'
	],
	#category : #'ObjectBrowser-Filein'
}

{ #category : #'instance creation' }
OBCollectionPrototypeV2 class >> for: aClass [

	^ self new
			class: aClass;
			yourself
]

{ #category : #compatibility }
OBCollectionPrototypeV2 >> class: aClass [ 

	class := aClass
]
