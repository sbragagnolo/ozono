Trait {
	#name : #OBSimpleCollectionTrait,
	#category : #'ObjectBrowser-Tests'
}

{ #category : #'as yet unclassified' }
OBSimpleCollectionTrait >> expectedOnCollect [ 
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
OBSimpleCollectionTrait >> putSomeElements [
	self collection add: 5.
	self collection add: 6.
	self collection add: 8.
]

{ #category : #tests }
OBSimpleCollectionTrait >> testAdd [
	self assert: 0 equals: self collection size.
	self collection add: 1.
	self collection add: 1.
	self assert: self expectedOnAdd equals: self collection size.
	
]

{ #category : #tests }
OBSimpleCollectionTrait >> testAllSatisfy [
	self putSomeElements.
	self assert:  (self collection allSatisfy: [:num|num>3]).
	self assert:  (self collection allSatisfy: [:num|num>100]) not.
]

{ #category : #tests }
OBSimpleCollectionTrait >> testAnySatisfy [
	self putSomeElements.
	self assert:  (self collection anySatisfy: [:num|num>7]).
	self assert:  (self collection anySatisfy: [:num|num>100]) not.
]

{ #category : #tests }
OBSimpleCollectionTrait >> testCollect [
	|expected collectionCollected|
	
	self putSomeElements.
	collectionCollected :=self collection collect: [:num|num+2].
	expected := self expectedOnCollect .
	self assert: expected size equals: collectionCollected size.
	self assert: (collectionCollected allSatisfy: [:e| expected includes: e] ).
	
]

{ #category : #tests }
OBSimpleCollectionTrait >> testDo [
	|total|
	self putSomeElements.
	total := 0.
	self collection do: [:e | total := total +e].
	self assert: 19 equals: total.
]

{ #category : #tests }
OBSimpleCollectionTrait >> testIncludes [
	self putSomeElements.
	self assert: (self collection includes: 5).
]

{ #category : #tests }
OBSimpleCollectionTrait >> testInjectInto [
	self putSomeElements.
	self assert: 19 equals: (self collection inject: 0 into:[:tot :e | tot+e] ).
]

{ #category : #tests }
OBSimpleCollectionTrait >> testIsEmpty [
	self assert: self collection isEmpty.
	self putSomeElements .
	self assert: self collection isEmpty not.
]

{ #category : #tests }
OBSimpleCollectionTrait >> testRemove [
	self putSomeElements .
	self assert: (self collection includes: 5).
	self collection remove: 5.
	self assert: (self collection includes: 5) not.
]

{ #category : #tests }
OBSimpleCollectionTrait >> testSelect [
	self putSomeElements .
	self assert: (self collection  includes: 5).
	self assert: ((self collection  select: [:e| e >5]) includes: 5) not.
]

{ #category : #tests }
OBSimpleCollectionTrait >> testSize [
	self assert: 0 equals: self collection size.
	self putSomeElements .
	self assert: 3 equals: self collection  size.
]
