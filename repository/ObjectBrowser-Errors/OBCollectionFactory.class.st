Class {
	#name : #OBCollectionFactory,
	#superclass : #Object,
	#category : #'ObjectBrowser-Collections'
}

{ #category : #'as yet unclassified' }
OBCollectionFactory class >> initialize [
	Smalltalk at:#bag ifAbsentPut: (OBBagFactory new).
	Smalltalk at:#set ifAbsentPut: (OBSetFactory new).
	Smalltalk at:#ordered ifAbsentPut: (OBOrderedCollectionFactory new).
]

{ #category : #'as yet unclassified' }
OBCollectionFactory class >> new [
	^self basicNew.
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> clone [
	^self subclassResponsibility .
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> hasClones [
	^true
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> hasReferencesTo: anOBObject [
	^false
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> printString [
	^ self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> references [
	^Set new.
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> removeClassFromSystem [
	"(metodo implementado solo para que haya polimorfismo) Una baseCollection no la podemos sacar  del sistema... es algo que llego para quedarse...."
	^self 
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> variables [
	^ OrderedCollection new
]
