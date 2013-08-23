Class {
	#name : #NoObjectBrowserObjectTestCase,
	#superclass : #TestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
NoObjectBrowserObjectTestCase >> testEqualityBetweenNoObjectBrowserObjects [
	self assert:(OBExternalObjectMetaObject new: nil ) = (OBExternalObjectMetaObject new:nil).
]
