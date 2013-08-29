Class {
	#name : #NoObjectBrowserObjectTestCase,
	#superclass : #TestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #tests }
NoObjectBrowserObjectTestCase >> testEqualityBetweenNoObjectBrowserObjects [
	self assert:(OBExternalObjectMetaObject new: nil ) = (OBExternalObjectMetaObject new:nil).
]
