"
I am an abstract class that contains the common behavior for the object browser objects.
"
Class {
	#name : #OBObject,
	#superclass : #Object,
	#traits : 'TOBObject',
	#classTraits : 'TOBObject classTrait',
	#instVars : [
		'_metaObject'
	],
	#category : #'ObjectBrowser-Objects'
}

{ #category : #'instance-creation' }
OBObject class >> new [
	^self basicNew
]

{ #category : #cloning }
OBObject >> clone [

	^ self metaObject clone concreteObject
]

{ #category : #printing }
OBObject >> displayString [

	^'anObject'
]

{ #category : #accessing }
OBObject >> metaObject [

	^_metaObject
]

{ #category : #accessing }
OBObject >> metaObject: aMetaObject [
	_metaObject ifNotNil: [ self error: 'No se puede cambiar el metaObject de un objeto' ].
	_metaObject := aMetaObject.
]
