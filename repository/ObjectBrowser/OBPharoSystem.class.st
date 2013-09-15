"
System utilities from Pharo
"
Class {
	#name : #OBPharoSystem,
	#superclass : #Object,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ObjectBrowser-PharoLayer'
}

{ #category : #'instance creation' }
OBPharoSystem class >> reset [

	UniqueInstance := nil
]

{ #category : #'instance creation' }
OBPharoSystem class >> uniqueInstance [

	^UniqueInstance ifNil: [ UniqueInstance := OBPharoSystem new ]
]

{ #category : #'system-events' }
OBPharoSystem >> suspendSystemEventsWhile: aBlock [ 

	SystemAnnouncer uniqueInstance suspendAllWhile: aBlock
]
