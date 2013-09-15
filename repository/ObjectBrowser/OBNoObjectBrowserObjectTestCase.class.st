Class {
	#name : #OBNoObjectBrowserObjectTestCase,
	#superclass : #OBTestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #tests }
OBNoObjectBrowserObjectTestCase >> testEqualityBetweenNoObjectBrowserObjects [
	self assert:(OBExternalObjectMetaObject new: nil ) = (OBExternalObjectMetaObject new:nil).
]
