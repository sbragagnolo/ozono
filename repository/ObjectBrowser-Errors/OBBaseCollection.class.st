Class {
	#name : #OBBaseCollection,
	#superclass : #ObjectBrowserObject,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
OBBaseCollection class >> new [
	^self basicNew.
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> addVariable: variableName [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> clone [
	^self subclassResponsibility .
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> cloneWithName: theName [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> compileMethod: aMethod  notifying: someone [
	self signalNotModificableCollection
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
OBBaseCollection >> removeMethod: aSelector [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> removeVariable: variableName [
	self signalNotModificableCollection
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> sourceCodeAt: aSelector [
	^'Usted no quiere ver esto realmente ;-)'
]

{ #category : #'as yet unclassified' }
OBBaseCollection >> variables [
	^ OrderedCollection new
]
