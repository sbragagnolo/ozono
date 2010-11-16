Class {
	#name : #NoObjectBrowserObjectTestCase,
	#superclass : #TestCase,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
NoObjectBrowserObjectTestCase >> testEqualityBetweenNoObjectBrowserObjects [
	self assert:(NoObjectBrowserObject new: nil ) = (NoObjectBrowserObject new:nil).
]
