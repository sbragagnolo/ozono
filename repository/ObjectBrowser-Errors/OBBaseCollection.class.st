Class {
	#name : #OBBaseCollection,
	#superclass : #Object,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBBaseCollection class >> new [
	^self basicNew.
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> clone [
	^self subclassResponsibility .
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> hasClones [
	^true
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> hasReferencesTo: anOBObject [
	^false
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> printString [
	^ self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> references [
	^Set new.
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> removeClassFromSystem [
	"(metodo implementado solo para que haya polimorfismo) Una baseCollection no la podemos sacar  del sistema... es algo que llego para quedarse...."
	^self 
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> variables [
	^ OrderedCollection new
]
