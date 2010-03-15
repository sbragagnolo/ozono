Class {
	#name : #ObjectBrowserObjectTestCase,
	#superclass : #TestCase,
	#instVars : [
		'ob'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
ObjectBrowserObjectTestCase >> tearDown [
	ob objects do:[:o | o removeFromSystem].
]

{ #category : #'as yet unclassified' }
ObjectBrowserObjectTestCase >> testAddVariable [
	| object name variableName |
	name:= 'pepito'.
	variableName := 'polillo'.
	ob := ObjectBrowser new.
	ob objects: OrderedCollection new.
	object := ob createObject: name.
	object addVariable: variableName.
	self assert: (object variables includes: variableName).
]

{ #category : #'as yet unclassified' }
ObjectBrowserObjectTestCase >> testCloneObject [
	| name object cloneName clone |
	ob := ObjectBrowser new.
	name := 'pepito'.
	cloneName := 'sarasin'.
	object := ob createObject: name.
	clone := object cloneWithName: cloneName.
	
	self assert: (ob objects includes: clone).
	self assert: cloneName equals: (clone name).
	self assert: (object realClass) equals: (clone realClass superclass).
]

{ #category : #'as yet unclassified' }
ObjectBrowserObjectTestCase >> testCompileMethod [
	| object name method |
	name:= 'pepito'.
	method := 'sumaEntre: a y: b ^a+b'.
	ob := ObjectBrowser new.
	object := ob createObject: name.
	object compileMethod: method.
	self assert: (object hasMethod: 'sumaEntre:y:').
]

{ #category : #'as yet unclassified' }
ObjectBrowserObjectTestCase >> testNewObjectBrowserObject [
	| name object realObject |
	ob := ObjectBrowser new.
	name := 'pepito'.
	object := ob createObject: 'pepito'.
	self assert: (object objectBrowser objects includes: object).
	self assert: name equals: object name.
]

{ #category : #'as yet unclassified' }
ObjectBrowserObjectTestCase >> testRemoveMethod [
	| object name method |
	name:= 'pepito'.
	method := 'sumaEntre: a y: b ^a+b'.
	ob := ObjectBrowser new.
	object := ob createObject: name.
	object compileMethod: method.
	self assert: (object hasMethod: #sumaEntre:y:).
	object removeMethod: #sumaEntre:y:.
	self assert: ((object hasMethod: #sumaEntre:y:) not).
]

{ #category : #'as yet unclassified' }
ObjectBrowserObjectTestCase >> testRemoveVariable [
	| object name variableName |
	name:= 'pepito'.
	variableName := 'polillo'.
	ob := ObjectBrowser new.
	object := ob createObject: name.
	object addVariable: variableName.
	self assert: (object hasVariable: variableName).
	object removeVariable: variableName.
	self assert: ((object hasVariable: variableName) not).
]
