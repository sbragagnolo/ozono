Class {
	#name : #ObjectBrowserTestCase,
	#superclass : #TestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> tearDown [
	ob objects do:[:o | o removeFromSystem ].
]

{ #category : #'as yet unclassified' }
ObjectBrowserTestCase >> testCreateObject [
	ObjectBrowser clean.
	ob := ObjectBrowser new.
	ob objects: OrderedCollection new.
	ob createObject: 'testObject'.
	self assert: 1 equals: (ob objects size).
	self assert: 'testObject' equals: (ob objects anyOne name).
	self assert: 'TestObject' equals: (ob objects anyOne realObject class name).
	
	"clean"
	ob objects anyOne realObject class removeFromSystem.
]
