Class {
	#name : #OBObjectUsesCollectionPrototypes,
	#superclass : #OBTestCase,
	#instVars : [
		'pepita'
	],
	#category : #'ObjectBrowser-Tests'
}

{ #category : #tests }
OBObjectUsesCollectionPrototypes >> testObjectUsesBagPrototypeAndGetsABag [

	| bag |
	pepita compileMethod: 'createBag ^bag clone'.
	bag := pepita baseObject createBag.
	bag
		add: 1;
		add: 1.
	self assert: bag size equals: 2.
]

{ #category : #tests }
OBObjectUsesCollectionPrototypes >> testObjectUsesDictionaryPrototypeAndGetsADictionary [

	| dictionary |
	pepita compileMethod: 'createDictionary ^dictionary clone'.
	dictionary := pepita baseObject createDictionary.
	dictionary
		at: 1 put: 'hello';
		at: 2 put: 'world'.
	self assert: dictionary size equals: 2.
	self assert: (dictionary at: 1) equals: 'hello'.
	self assert: (dictionary at: 2) equals: 'world'.
]

{ #category : #tests }
OBObjectUsesCollectionPrototypes >> testObjectUsesOrderedCollectionPrototypeAndGetsAnOrderedCollection [

	| orderedCollection |
	pepita compileMethod: 'createOrdered ^ordered clone'.
	orderedCollection := pepita baseObject createOrdered.
	orderedCollection
		add: 1;
		add: 13.
	self assert: orderedCollection size equals: 2.
	self assert: orderedCollection first equals: 1.
	self assert: orderedCollection second equals: 13.
]

{ #category : #tests }
OBObjectUsesCollectionPrototypes >> testObjectUsesSetPrototypeAndGetsASet [

	| set |
	pepita compileMethod: 'createSet ^set clone'.
	set := pepita baseObject createSet.
	set
		add: 1;
		add: 1.
	self assert: set size equals: 1.
]

{ #category : #tests }
OBObjectUsesCollectionPrototypes >> testObjectUsesSortedPrototypeAndGetsASorted [

	| sorted |
	pepita compileMethod: 'createSorted
		| points |
		points := sorted clone.
		points sortBlock: [ :a :b | a abs > b abs ].
		^ points'.
	sorted := pepita baseObject createSorted.
	sorted
		add: -1;
		add: -5;
		add: 10.
	self assert: sorted first equals: 10.
	self assert: sorted second equals: -5.
	self assert: sorted third equals: -1.
]
