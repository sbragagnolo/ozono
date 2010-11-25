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
	self deprecated: 'no se usa'.
	^true
]

{ #category : #'as yet unclassified' }
OBCollectionFactory >> hasReferencesTo: anOBObject [
	self deprecated: 'no se usa'.
	^false
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