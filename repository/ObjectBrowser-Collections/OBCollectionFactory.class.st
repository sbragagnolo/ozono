Class {
	#name : #OBCollectionFactory,
	#superclass : #Object,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBCollectionFactory class >> initialize [
	Smalltalk at:#bag put: (OBBagFactory new).
	Smalltalk at:#set put: (OBSetFactory new).
	Smalltalk at:#ordered put: (OBOrderedCollectionFactory new).
	Smalltalk at:#orderedcollection put: (OBOrderedCollectionFactory new).
	Smalltalk at:#sorted put: (OBSortedFactory new).
	Smalltalk at:#sortedcollection put: (OBSortedFactory new).
	Smalltalk at:#dictionary put: (OBDictionaryFactory new).
]

{ #category : #'as yet unclassified' }
OBCollectionFactory class >> new [
	^self basicNew.
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> clone [
	| col |
	col := self createCollection.
	self notifyCreationOf: col to: ObjectBrowserCollection.
	^col
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> hasClones [
	self deprecated: 'no se usa'.
	^true
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> hasReferencesTo: anOBObject [
	self deprecated: 'no se usa'.
	^false
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> newObjectBrowserObjectWithRealObject: aRealCollection [
	^ObjectBrowserCollection newWithRealObject: aRealCollection.
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> notifyCreationOf: aCollection to: anObserver [
	^anObserver notifyCollectionCreated: aCollection from: self
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> printString [
	^self displayString 
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> references [
	self deprecated: 'no se usa'.
	^Set new.
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> removeClassFromSystem [
	"(metodo implementado solo para que haya polimorfismo) Una baseCollection no la podemos sacar  del sistema... es algo que llego para quedarse...."
	self deprecated: 'no se usa'.
	^self 
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> variables [
	self deprecated: 'no se usa'.
	^ OrderedCollection new
]
